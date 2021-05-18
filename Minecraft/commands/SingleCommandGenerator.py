
import sys
#import re

def parse(infile, outfile=None):
    def escape(string):
        #re.sub(r'(?<!\\)"','\\"',string.replace('\\', '\\\\'))
        return string.replace('\\', '\\\\').replace('"', '\\"')

    keep = ('keep', 'remove', 'optional', 'remove+')
    axis = ('vertical', 'positive-x', 'negative-x', 'positive-z', 'negative-z')
    mode = ('impulse', 'chain', 'repeat')
    auto = ('auto', 'manual')
    cond = ('conditional', 'unconditional')
    face = ('up', 'down', 'east', 'north', 'west', 'south')
    cmd = []
    meta = {}
    entry = {'position': 0}
    for line in infile:
        line = line.strip()
        # command
        if len(line) > 0 and line[0] != '#':
            entry['command'] = escape(line)
            cmd.append(entry)
            entry = {'position': len(cmd)}
        # metadata
        elif len(line) > 2 and line[0:2] == '#@':
            param = line[2:].strip()
            # global data
            if 'keep' not in meta and param in keep:
                meta['keep'] = param
            elif 'axis' not in meta and param in axis:
                meta['axis'] = param
            elif param[0:7] == 'default':
                param = param[7:].strip()
                if 'mode' not in meta and param in mode:
                    meta['mode'] = param
                elif 'auto' not in meta and param in auto:
                    meta['auto'] = param
                elif 'cond' not in meta and param in cond:
                    meta['cond'] = param
                elif 'face' not in meta and param in face:
                    meta['face'] = param
            else:
                # block specific data
                if 'mode' not in entry and param in mode:
                    entry['mode'] = param
                elif 'auto' not in entry and param in auto:
                    entry['auto'] = param
                elif 'cond' not in entry and param in cond:
                    entry['cond'] = param
                elif 'face' not in entry and param in face:
                    entry['face'] = param

    # skip if no command
    num = len(cmd)
    if num > 0:
        if num > 250:
            print('Input command of ' + str(num) + ' is more than limit of 250 commands', file=sys.stderr)

        horizontal = 'axis' in meta and meta['axis'] != 'vertical'
        if horizontal:
            horizontal_dir = meta['axis'][-1] == 'x'
            horizontal_sign = 1 if meta['axis'][0] == 'p' else -1

        # determine automatic behavior of keep
        if 'keep' not in meta:
            if horizontal:
                meta['keep'] = 'remove'
            elif 'mode' in meta and meta['mode'] != 'chain':
                meta['keep'] = 'keep'
            else:
                for entry in cmd:
                    if 'mode' in entry and entry['mode'] != 'chain':
                        meta['keep'] = 'optional'
                        break
                if 'keep' not in meta:
                    meta['keep'] = 'remove'

        def convert(data):
            if type(data) is dict:
                return '{' + ','.join([item + ':' + convert(data) for item, data in data.items()]) + '}'
            elif type(data) is list:
                #return '[' + ','.join([convert(item) for item in data]) + ']'
                return '[{' + ','.join([item + ':' + convert(data) for item, data in data[0].items()]) + '}]'
            else:
                return data

        def apply(entry):
        # generate command object
            if 'mode' not in entry:
                if 'mode' in meta:
                    entry['mode'] = meta['mode']
                elif entry['position'] == 0:
                    entry['mode'] = 'impulse'
                else:
                    entry['mode'] = 'chain'
            if 'auto' not in entry:
                if 'auto' in meta:
                    entry['auto'] = meta['auto']
                else:
                    entry['auto'] = 'auto'
            if 'cond' not in entry:
                if 'cond' in meta:
                    entry['cond'] = meta['cond']
                else:
                    entry['cond'] = 'unconditional'
            if 'face' not in entry and 'face' in meta:
                entry['face'] = meta['face']

            data = {'id': 'falling_block', 'Time': '1', 'BlockState': {'Name': '"chain_command_block"'}, 'TileEntityData': {}}
            if entry['mode'] == 'impulse':
                data['BlockState']['Name'] = '"command_block"'
            elif entry['mode'] == 'repeat':
                data['BlockState']['Name'] = '"repeating_command_block"'
            if entry['cond'] == 'conditional':
                data['BlockState']['Properties'] = {'condiitional': 'true'}
            elif not horizontal or 'face' in entry:
                data['BlockState']['Properties'] = {}
            if horizontal:
                if 'face' in entry:
                    data['BlockState']['Properties']['facing'] = '"' + entry['face'] + '"'
            else:
                data['BlockState']['Properties']['facing'] = '"down"'
            if entry['auto'] == 'auto' and entry['mode'] != 'chain':
                data['TileEntityData']['auto'] = '1'
            elif entry['auto'] == 'manual' and entry['mode'] == 'chain':
                data['TileEntityData']['auto'] = '0'
            data['TileEntityData']['Command'] = '"' + entry['command'] + '"'

            if horizontal:
                wrapper = {'id': 'falling_block', 'Time': '1', 'BlockState': {'Name': '"chain_command_block"', 'Properties': {'facing': '"down"'}}, 'TileEntityData': {}}
                if entry['position'] == 0:
                    wrapper['BlockState']['Name'] = '"command_block"'
                    wrapper['TileEntityData']['auto'] = '1'
                pos = entry['position'] + 1
                if horizontal_dir:
                    position = str(pos * horizontal_sign) + ' ~' + str(pos) + ' ~ '
                else:
                    position = ' ~' + str(pos) + ' ~' + str(pos * horizontal_sign) + ' '
                wrapper['TileEntityData']['Command'] = '"summon falling_block ~' + position + escape(convert(data)) + '"'
                data = wrapper

            spacer = {'id': 'armor_stand', 'Invisible': '1', 'Tags': '["CMDSPACER"]', 'Passengers': [data]}
            return spacer

        nsp = num if meta['keep'] == 'keep' else num + 1

        data = None
        for entry in cmd:
            spacer = apply(entry)
            if data is not None:
                spacer['Passengers'][0]['Passengers'] = [data]
            data = spacer
        wrapper = {'Time': '1', 'BlockState': {'Name': '"command_block"', 'Properties': {'facing': '"down"'}}, 'TileEntityData': {'auto': '1'}}
        wrapper['TileEntityData']['Command'] = '"kill @e[type=armor_stand,tag=CMDSPACER,sort=nearest,limit=' + str(nsp) + ']"'
        if meta['keep'] != 'keep':
            spacer = {'id': 'falling_block', 'Time': '1', 'BlockState': {'Name': '"chain_command_block"', 'Properties': {'facing': '"down"'}}, 'TileEntityData': {}, 'Passengers': [data]}
            if meta['keep'] == 'optional':
                spacer['BlockState']['Name'] = '"command_block"'
            spacer['TileEntityData']['Command'] = '"fill ~ ~' + ('-2' if meta['keep'][-1] == '+' else '-1') + ' ~ ~ ~' + str(num) + ' ~ air"'
            wrapper['Passengers'] = [{'id': 'armor_stand', 'Invisible': '1', 'Tags': '["CMDSPACER"]', 'Passengers': [spacer]}]
        else:
            wrapper['Passengers'] = [data]

        command = 'summon falling_block ~ ~1 ~ ' + convert(wrapper)
        
        if len(command) > 32500:
            print('Output command of ' + str(len(command)) + ' is longer than limit of 32500 characters', file=sys.stderr)

        if outfile is not None:
            print(command, end='\n\n', file=outfile)
        else:
            print(command)
        return command
    
    else:
        print('No command supplied', file=sys.stderr)
        return None


if __name__ == '__main__':
    sys.setrecursionlimit(1800)
    mode = 3
    if mode == 1:
        filename = input('Enter filename: ')
        with open(filename) as file:
            output = parse(file)
    elif mode == 2:
        wfile = open('output71.txt', 'w')
        for num in range(1,61):
            filename = 'commands.txt.' + str(num) + '.txt'
            with open(filename) as file:
                parse(file, wfile)
        wfile.close()
    elif mode == 3:
        print('Enter commands. Mark EOF with Ctrl + D.')
        string = sys.stdin.read()
        items = string.split('\n')
        output = parse(items)

