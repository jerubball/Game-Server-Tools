
import sys
#import re

def parse(infile, outfile=None):
    cmd = []
    meta = {}
    keep = {'keep', 'remove', 'optional'}
    mode = {'impulse', 'chain', 'repeat'}
    auto = {'auto', 'manual'}
    cond = {'conditional', 'unconditional'}
    for line in infile:
        line = line.strip()
        # command
        if len(line) > 0 and line[0] != '#':
            #cmd.append(re.sub(r'(?<!\\)"','\\"',line.replace('\\', '\\\\')))
            cmd.append(line.replace('\\', '\\\\').replace('"', '\\"'))
        # metadata
        elif len(line) > 2 and line[0:2] == '#@':
            line = line[2:].strip()
            # global data
            if 'keep' not in meta and line in keep:
                meta['keep'] = line
            elif line[0:7] == 'default':
                line = line[7:].strip()
                if 'mode' not in meta and line in mode:
                    meta['mode'] = line
                elif 'auto' not in meta and line in auto:
                    meta['auto'] = line
                elif 'cond' not in meta and line in cond:
                    meta['cond'] = line
            else:
                # block specific data
                if len(cmd) not in meta:
                    meta[len(cmd)] = {}
                if 'mode' not in meta[len(cmd)] and line in mode:
                    meta[len(cmd)]['mode'] = line
                elif 'auto' not in meta[len(cmd)] and line in auto:
                    meta[len(cmd)]['auto'] = line
                elif 'cond' not in meta[len(cmd)] and line in cond:
                    meta[len(cmd)]['cond'] = line

    # skip if no command
    num = len(cmd)
    if num > 0:
        if num > 250:
            print('Input command of ' + str(num) + ' is more than limit of 250 commands', file=sys.stderr)

        # determine automatic behavior of keep
        if 'keep' not in meta:
            if 'mode' in meta and meta['mode'] != 'chain':
                meta['keep'] = 'optional'
            else:
                for i in range(num):
                    if i in meta and 'mode' in meta[i] and meta[i]['mode'] != 'chain':
                        meta['keep'] = 'optional'
                        break
                if 'keep' not in meta:
                        meta['keep'] = 'remove'

        #spacer = ',Passengers:[{id:armor_stand,Invisible:1,CustomName:"\\"CMDSPACER\\"",Passengers:[{id:falling_block,Time:1,BlockState:'
        spacer = ',Passengers:[{id:armor_stand,Invisible:1,Tags:["CMDSPACER"],Passengers:[{id:falling_block,Time:1,BlockState:'
        nsp = num if meta['keep'] == 'keep' else num + 1

        # generate command segment
        def apply(cmd, data=None):
            if data is None:
                data = {}
            if 'mode' not in data:
                if 'mode' in meta:
                    data['mode'] = meta['mode']
                else:
                    data['mode'] = 'chain'
            if 'auto' not in data:
                if 'auto' in meta:
                    data['auto'] = meta['auto']
                else:
                    data['auto'] = 'auto'
            if 'cond' not in data:
                if 'cond' in meta:
                    data['cond'] = meta['cond']
                else:
                    data['cond'] = 'unconditional'
            com = spacer + '{Name:"'
            if data['mode'] == 'chain':
                com += 'chain_'
            elif data['mode'] == 'repeat':
                com += 'repeating_'
            com += 'command_block",Properties:{facing:"down"'
            if data['cond'] == 'conditional':
                com += ',conditional:"true"'
            com += '}},TileEntityData:{'
            if data['auto'] == 'auto' and data['mode'] != 'chain':
                com += 'auto:1,'
            elif data['auto'] == 'manual' and data['mode'] == 'chain':
                com += 'auto:0,'
            com += 'Command:"' + cmd + '"}'
            return com

        # base command to kill spacer
        #command = 'summon falling_block ~ ~1 ~ {Time:1,BlockState:{Name:"command_block",Properties:{facing:"down"}},TileEntityData:{auto:1,Command:"kill @e[type=armor_stand,nbt={Invisible:1b,CustomName:\\"{\\\\\\"text\\\\\\":\\\\\\"CMDSPACER\\\\\\"}\\"},sort=nearest,limit=' + str(nsp) + ']"}'
        command = 'summon falling_block ~ ~1 ~ {Time:1,BlockState:{Name:"command_block",Properties:{facing:"down"}},TileEntityData:{auto:1,Command:"kill @e[type=armor_stand,tag=CMDSPACER,sort=nearest,limit=' + str(nsp) + ']"}'

        if meta['keep'] != 'keep':
            command += spacer + '{Name:"'
            if meta['keep'] == 'remove':
                command += 'chain_'
            command += 'command_block",Properties:{facing:"down"}},TileEntityData:{Command:"fill ~ ~-1 ~ ~ ~' + str(num) + ' ~ air"}'

        for i in range(num-1,0,-1):
            if i in meta:
                command += apply(cmd[i], meta[i])
            else:
                command += apply(cmd[i])

        if 0 in meta:
            if 'mode' in meta[0] and meta[0]['mode'] == 'chain':
                print('Chain mode will be fixed to impulse mode in first block', file=sys.stderr)
                meta[0]['mode'] = 'impulse'
            if 'cond' in meta[0] and meta[0]['mode'] == 'conditional':
                print('Conditional will be fiexd to unconditional in first block', file=sys.stderr)
                meta[0]['cond'] = 'unconditional'
            command += apply(cmd[0], meta[0])
        else:
            command += apply(cmd[0],{'mode':'impulse'})

        command += '}]}]' * nsp + '}'

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

