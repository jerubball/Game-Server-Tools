#!/bin/python3

import os
import subprocess
import types
import copy
import re
import json
import datetime
import asyncio
import discord


def findmatchlist(pattern, string):
	matches = []
	results = re.finditer(pattern, string)
	for result in results:
		matches.append(result)
	return matches

def deleteallmatches(pattern, string):
	pattern = pattern if pattern is not None else r'(<[@#][!&]?[0-9]+>|@[A-Za-z0-9]+)'
	results = re.finditer(pattern, string)
	index = 0
	newstring = ''
	for result in results:
		newstring += string[index:result.start()]
		index = result.end()
	newstring += string[index:]
	return newstring


class HimBotException(Exception):
	'''Base class for Exceptions raised by HimBotClient module.'''
	pass

class NameException(HimBotException):
	'''Added subcommand to target command where command name key already exists.'''
	def __init__(self, supercommandname, subcommandname):
		super().__init__('Key ' + subcommandname + ' exists in ' + supercommandname + '.')

class PermissionException(HimBotException):
	'''User invoked command with no applicable permission.'''
	def __init__(self, commandname):
		super().__init__('You do not have permission for command: `' + commandname + '`')

class ParameterException(HimBotException):
	'''User invoked command with missing parameter.'''
	def __init__(self, commandname):
		super().__init__('Missing command after: `' + commandname + '`\nType `@HimBot help [command]` for more information.')

class UnknownException(HimBotException):
	'''User invoked command with unknown parameter or extra parameter.'''
	def __init__(self, commandname):
		super().__init__('Unknown command: `' + commandname + '`\nType `@HimBot help [command]` for more information.')

class PermissionItem:
	'''Data container for permission.

	All id fields are of integer.
	None field represent 'Any'.
	Thus, PermissionItem() grants access to anyone in any channel in any server.
	'''
	def __init__(self, guildid = None, channelid = None, *, userid = None, roleid = None):
		self.guildid = guildid
		self.channelid = channelid
		self.userid = userid
		self.roleid = roleid

	def check(self, textchannel, member):
		'''Checks if permission is valid in given channel with given user.
		textchannel must be type of discord.TextChannel and member must be type of discord.Member.'''
		assert type(textchannel) is discord.TextChannel and type(member) is discord.Member
		if self.guildid is None or self.guildid == textchannel.guild.id:
			if self.channelid is None or self.channelid == textchannel.id:
				if self.userid is None or self.userid == member.id:
					if self.roleid is None:
						return True
					for role in member.roles:
						if self.roleid == role.id:
							return True
		return False

class CommandItem:
	'''Represents a command in single level.

	name must contain single word with no whitespace.
	aliases should be a list/tuple/set of strings or None.
	description should be a string or None.
	perm describes command permissiona and can be following types:
		None to use parent permission,
		True to grant all access,
		False to deny all access,
		a PeremissionItem or a list/tuple/set of PermissionItem for permission specs.
	func should be a function or instance method, which can be coroutine, or None.
	accepts describes function's parameter behavior and can be following types:
		False to indicate no additional parameters (except that of subcommand),
		True to indicate any additiona parameters,
		or integer to indicate number of additional parameters.
		This has no effect if func is None.
	supeercommand should be a CommandItem or None.
	subcommands should be a list/tuple/set of CommandItem or None.
	'''
	def __init__(self, name, *, aliases = None, description = None, perm = None, func = None, accepts = False, subcommands = None):
		self.name = name
		self.aliases = aliases
		self.description = description
		self.perm = perm
		self.func = func
		self.accepts = accepts
		self.fullname = self.name
		self.supercommand = None
		self.subcommands = {}
		self.subcommandaliases = {}
		if subcommands is not None:
			self.add(*subcommands)

	def __str__(self):
		return self.fullname

	def __len__(self):
		return len(self.subcommands)

	def __contains__(self, subcommandname):
		return subcommandname in self.subcommands or subcommandname in self.subcommandaliases

	def __repr__(self):
		return self.fullname

	def __copy__(self):
		item = CommandItem(self.name, aliases = self.aliases, description = self.description, perm = self.perm, func = self.func, accepts = self.accepts)
		item.subcommands = self.subcommands
		item.subcommandaliases = self.subcommandaliases
		return item

	def __deepcopy__(self, memo = None):
		pass

	def __deepcopy1__(self, memo = None):
		memo[id(self)] = self

	def setSuper(self, supercommand, memo = None):
		'''Sets supercommand and update own and subcommand's fullname.
		this commaand must be already subcommand of supercommand.'''
		#if memo is None:
		#	memo = set()
		#assert self not in memo
		#memo.add(self)
		self.supercommand = supercommand
		assert self.supercommand.has(self.name)
		self.fullname = self.name if self.supercommand is None else supercommand.fullname + ' ' + self.name
		for command in self.subcommands.values():
			command.setSuper(self, memo)

	def add(self, *subcommands):
		'''Adds subcommand and alias entry.
		subcommand's supercommand field is also updated.'''
		for subcommand in subcommands:
			if self.has(subcommand.name):
				raise NameException(self.name, subcommand.name)
			else:
				self.subcommands[subcommand.name] = subcommand
				subcommand.setSuper(self)
				if subcommand.aliases is not None:
					for alias in subcommand.aliases:
						if self.has(alias):
							raise NameException(self.name, alias)
						else:
							self.subcommandaliases[alias] = subcommand.name

	def get(self, subcommandname):
		'''Get CommandItem that matches subcommandname'''
		return self.subcommands[subcommandname] if subcommandname in self.subcommands else self.subcommands[self.subcommandaliases[subcommandname]]

	def has(self, subcommandname):
		'''Check if subcommandname is vaild subcommand key of this command'''
		return subcommandname in self.subcommands or subcommandname in self.subcommandaliases

	def check(self, message):
		'''Check if given message's information meets permisssion spec.
		message must be that from guild; with discord.TextChannel as type of message.channel and discord.Member as type of message.author'''
		if self.perm is None:
			return False if self.supercommand is None else self.supercommand.check(message)
		elif type(self.perm) is bool:
			return self.perm
		elif type(self.perm) is PermissionItem:
			return self.perm.check(message.channel, message.author)
		elif type(self.perm) is dict:
			for permname in self.perm:
				if self.perm.permname.check(message.channel, message.author):
					return True
			return False
		elif type(self.perm) in (list, set, tuple):
			for perm in self.perm:
				if perm.check(message.channel, message.author):
					return True
			return False
		else:
			return False


def getSubprocessSSHCommand(*remotecommand):
	commands = ['ssh', '-i', '~/.ssh/id_rsa_nopasswd', '192.168.1.31']
	for item in remotecommand:
		commands.append(item)
	return commands


class HimBotClient(discord.Client):
	'''HimBotClient servers user command to automate remote command task.

	commandlist is a reference to root CommandItem that functions as start point for tree search. The root item is expected to have no functionality.
	All command set should be defined as child CommandItem of commandlist.
	iddata contains integer id for guild, channel, user, and role. It is useful to have these information beforehand, as connection is not established when object is constructed.
	permdata contains integer pair of guild, channel, user, and role. It is used to construct PermissionItems.
	rootoverride is boolean that indicates that root, that is the application owner, overrides all permission structure.
	owneroverride is boolean that indicates that the guild owner overrides all permission in that guild.
	adminoveerride is boolean that indicates that the admins override all permission in that guild.
	'''
	def __init__(self, iddata=None, permdata=None):
		super().__init__()
		self.appinfo = None
		self.iddata = iddata
		self.rootoverride = True
		self.owneroverride = False
		self.adminoverride = False
		self.memberperm = PermissionItem(self.iddata['guildid'], self.iddata['primarychannelid'], roleid = self.iddata['userroleid'])
		self.subcommandgroup = {
			'minecraft': [
				CommandItem('spigot', aliases = ['plugin'], func = lambda *_, **__: '"StartMinecraftServerSpigot"'),
				CommandItem('vanilla', aliases = ['original'], func = lambda *_, **__: '"StartMinecraftServerVanilla"')  ]
		}
		self.commandlist = CommandItem('@HimBot', description = 'Type `@HimBot help [command]` for more information.', perm = True, subcommands = [
			CommandItem('help', description = 'Get information about command.', aliases = [None], perm = True, accepts = True, func = self.cmdHelp),
			CommandItem('status', description = 'Get HimBot status.', aliases = ['info', 'version'], perm = True, func = self.cmdStatus),
			CommandItem('link', description = 'Get server invitation link.', perm = True, func = self.cmdLink, subcommands = [
				CommandItem('raw', description = 'Format invitation as raw text.', func = lambda *_, **__: True) ]),
			CommandItem('server', description = 'Controls server computer.', perm = self.memberperm, subcommands = [
				CommandItem('wakeup', func = self.cmdServer31Wakeup),
				CommandItem('shutdown', perm = False, func = self.cmdServer31Shutdown),
				CommandItem('priority', func = self.cmdServer31Priority, subcommands = [
					CommandItem('normal', aliases = [None], func = lambda *_, **__: '"SetServerProcessPriorityNormal"'),
					CommandItem('minecraft', func = lambda *_, **__: '"SetServerProcessPriorityMinecraft"')  ]),
				CommandItem('status', func = self.cmdServer31Status)  ]),
			CommandItem('minecraftserver', description = 'Controls minecraft server.', aliases = ['mcserver', 'minecraft'], perm = self.memberperm, subcommands = [
				CommandItem('start', func = self.cmdMinecraftServer31Start, subcommands = copy.copy(self.subcommandgroup['minecraft'])),
				CommandItem('stop', func = self.cmdMinecraftServer31Stop, subcommands = copy.copy(self.subcommandgroup['minecraft'])),
				CommandItem('priority', func = lambda cmd, res: self.cmdMinecraftServer31Priority(cmd, '"SetServerProcessPriorityMinecraft"')),
				CommandItem('status', func = self.cmdMinecraftServer31Status)  ])
		])
		self.versionstring = 'HimBot-DiscordClient v1.2.0'
		self.starttime = datetime.datetime.now()

	def checkRootPerm(self, user):
		return self.rootoverride and user.id == self.appinfo.owner.id

	def checkOwnerPerm(self, user):
		return self.owneroverride and type(user) is discord.Member and user.guild.owner.id == user.id

	def checkAdminPerm(self, user):
		if self.adminoverride and type(user) is discord.Member:
			if member.guild_permissions.administrator:
				return True
			for role in user.roles:
				if role.permissions.administrator:
					return True
		return False

	def checkClientMentionString(self, string):
		#return self.user.mention == string
		return re.fullmatch('^<@!?' + str(self.user.id) + '>$', string)

	async def on_ready(self):
		self.commandlist.alises = [self.user.mention]
		self.appinfo = await self.application_info()
		print('Logged on as', self.user)

	async def on_disconnect(self):
		print('Disconnected!')

	async def on_resumed(self):
		print('Resumed!')

	async def on_message(self, message):
		'''Determines if sent message is command to HimBot.
		If the message is command for HimBot, further analyze command.
		If the command chain returns string or list of strings, it will be sent to the same text channel.
		If the command chain raises exception, the exception message will be sent as the reply, mentioning the author.
		'''
		#print(message)
		if message.author == self.user \
			   or type(message.channel) is not discord.TextChannel or type(message.author) is not discord.Member:
			return
		commands = message.content.lower().split()
		print(commands)
		if len(commands) > 0 and self.checkClientMentionString(commands[0]) \
				and len(message.mentions) > 0 and self.user in message.mentions:
			try:
				# run down through command chain
				result = await self.runCommand(message, commands, self.commandlist)
				if type(result) in (list, tuple, set):
					for item in result:
						await message.channel.send(item)
				else:
					await message.channel.send(result)
				#await message.reply(result)
				print(' * Successful')
			except HimBotException as exception:
				await message.reply(str(exception))
				print(' * Failed with ', type(exception))
			except Exception as exception:
				await message.reply('Internal error occurred.')
				raise exception

	async def runCommand(self, message, commands, commandlist):
		'''Recursively analyze and run the given command list.
		message must be from TextChannel with Member as author.
		commands is list of string that contains the commands. This list cannot be empty, and each string is expected to be a single word.
		commandlist is a reference to current root node to look up next subcommand.
		'''
		#print('\t', commands)
		assert len(commands) > 0
		if commandlist.check(message) \
			   or self.checkAdminPerm(message.author) or self.checkOwnerPerm(message.author) or self.checkRootPerm(message.author):
			# a given parameter
			if len(commands) > 1:
				# a subcommand list
				if len(commandlist) > 0:
					# subcommand match
					if commandlist.has(commands[1]):
						result = await self.runCommand(message, commands[1:], commandlist.get(commands[1]))
					# subcommand mismatch
					else:
						raise UnknownException(commands[1])
				# no subcommand list
				else:
					# no function or no additional parameter
					if commandlist.func is None or not commandlist.accepts:
						raise UnknownException(commands[1])
					# expected function with additional parameter
					else:
						result = None
			# no given parameter
			else:
				# None subcommand
				if len(commandlist) > 0 and commandlist.has(None):
					result = await self.runCommand(message, [None], commandlist.get(None))
				# no function
				elif commandlist.func is None:
					# subcommand exists
					if len(commandlist) > 0:
						raise ParameterException(commands[0])
					# no function and no subcommand
					else:
						raise HimBotException('Invalid configuration for command: ' + commands[0])
				else:
					result = None
			# execute function
			if commandlist.func:
				result = commandlist.func(commands[1:], result)
				if type(result) is types.CoroutineType:
					result = await result
			# cascade result
			return result
		# no permission
		else:
			raise PermissionException(commands[0])

	async def on_message_edit(self, messagebefore, messageafter):
		pass

	async def on_reaction_add(self, reaction, user):
		pass

	def cmdHelp(self, commands, result):
		commandlist = self.commandlist
		while len(commands) > 0 and commandlist.has(commands[0]):
			commandlist = commandlist.get(commands[0])
			commands.pop(0)
		content = 'Help topic for `' + str(commandlist) + '`:'
		if commandlist.description is not None:
			content += '\n> ' + commandlist.description
		if commandlist.aliases is not None:
			content += '\n> Aliases: '
			firstitem = True
			for alias in commandlist.aliases:
				if firstitem:
					firstitem = False
				else:
					content += ', '
				if alias is None:
					content += '(default)'
				else:
					content += '`' + alias + '`'
		if len(commandlist) > 0:
			content += '\n> Available subcommands: '
			firstitem = True
			for command in commandlist.subcommands.values():
				if firstitem:
					firstitem = False
				else:
					content += ', '
				content += '`' + str(command.name) + '`'
		return content

	def cmdStatus(self, *_, **__):
		content = self.user.mention + ' is online.\nStart time: `' + str(self.starttime) + '`\n' + self.versionstring
		return content

	def cmdLink(self, commands, result):
		content = '''```fix
Welcome to our Discord Server!
Server UnServer NoServer.
a.k.a. SUNday server.
https://discord.gg/BBcKJs3
```'''
		if result:
			return '\\' + content
		else:
			return content

	def cmdServer31Wakeup(self, commands, result):
		wakeup = subprocess.run(['./wakeup.sh'], capture_output=True, text=True)
		if wakeup.returncode == 0:
			content = 'Sent wakeup signal to server computer.'
		else:
			content = 'Failed to send wakeup signal.'
		return content

	def cmdServer31Shutdown(self, commands, result):
		shutdown = subprocess.run(getSubprocessSSHCommand(r'powershell Stop-Computer -Force'), capture_output=True, text=True)
		if shutdown.returncode == 0:
			content = 'Sent shutdown signal to server computer.'
		else:
			content = 'Failed to send shutdown signal.'
		if shutdown.stdout and len(shutdown.stdout) > 0:
			content += '\n```' + shutdown.stdout + '```'
		return content

	def cmdServer31Priority(self, commands, result):
		start = subprocess.run(getSubprocessSSHCommand(r'powershell Start-ScheduledTask -TaskName ' + result), capture_output=True, text=True)
		if start.returncode == 0:
			content = 'Sent command to server computer.'
		else:
			content = 'Failed to send signal.'
		if start.stdout and len(start.stdout) > 0:
			content += '\n```' + start.stdout + '```'
		return content

	def cmdServer31Status(self, commands, result):
		ping = subprocess.run(['ping', '-c1', '192.168.1.31'], capture_output=True, text=True)
		if ping.returncode == 0:
			content = 'The server computer is online.'
		else:
			content = 'The server computer is **offline**.'
		if ping.stdout and len(ping.stdout) > 0:
			content += '\n```' + ping.stdout[ping.stdout.find('\n\n')+2:] + '```'
		return content

	def cmdServer31Check(self, commands, result):
		if result is not None:
			groupnames = [result]
		else:
			groupnames = self.subcommandgroup.keys()
		for groupname in groupnames:
			for command in self.subcommandgroup[groupname]:
				taskname = command.func(self, commands, result)
				check = subprocess.run(getSubprocessSSHCommand(r'powershell (Get-ScheduledTask -TaskName ' + taskname + r').State'), capture_output=True, text=True)
				if check.returncode == 0 and check.stdout and len(check.stdout) > 0 and check.stdout == 'Running':
					return 'Running'
		return 'Not Running'

	def cmdMinecraftServer31Start(self, commands, result):
		start = subprocess.run(getSubprocessSSHCommand(r'powershell Start-ScheduledTask -TaskName ' + result), capture_output=True, text=True)
		if start.returncode == 0:
			content = 'Sent start command to server computer.'
		else:
			content = 'Failed to send start signal.'
		if start.stdout and len(start.stdout) > 0:
			content += '\n```' + start.stdout + '```'
		return content

	def cmdMinecraftServer31Stop(self, commands, result):
		pass

	def cmdMinecraftServer31Status(self, commands, result):
		contents = [self.cmdServer31Status(commands, result)]
		status = subprocess.run(['/home/hasol/.local/bin/mcstatus', '192.168.1.31:25566', 'status'], capture_output=True, text=True)
		if status.returncode == 0:
			content = 'Minecraft server is running.'
		else:
			content = 'Minecraft server is **stopped**.'
		if status.stdout and len(status.stdout) > 0:
			content += '\n```' + status.stdout + '```'
		contents.append(content)
		return contents


if __name__ == "__main__":  # main.
	os.chdir('/home/hasol/Documents/Discord')

	with open('.token') as tokenfile:
		clienttoken = tokenfile.read().strip()
	with open('idfile.json') as idfile:
		iddata = json.loads(idfile.read())

	client = HimBotClient(iddata)
	client.run(clienttoken)
