
import sys,re

if __name__ == '__main__':
    filename = input('Enter filename: ')

    with open(filename) as file:
        cmd = []
        for line in file:
            line = line.strip()
            if len(line) > 0 and line[0] != '#':
                cmd.append(re.sub(r'(?<!\\)"','\\"',line.replace('\\', '\\\\')))

        if len(cmd) > 0:
            num = len(cmd)

            command = 'summon falling_block ~ ~1 ~ \
{Time:1,BlockState:{Name:"repeating_command_block",Properties:{facing:"down"}},TileEntityData:{auto:1,Command:"kill @e[type=armor_stand,nbt={OnGround:1b,Invisible:1b,CustomName:\\"{\\\\\\"text\\\\\\":\\\\\\"CMDSPACER\\\\\\"}\\"},sort=nearest,limit=1]"}\
,Passengers:[{id:armor_stand,Invisible:1,CustomName:"\\"CMDSPACER\\"",Passengers:[{id:falling_block,Time:1,BlockState:{Name:"chain_command_block",Properties:{facing:"down"}},TileEntityData:{Command:"fill ~ ~-1 ~ ~ ~' \
                    + str(num) + ' ~ air"}'

            for i in range(num-1,0,-1):
                command += ',Passengers:[{id:armor_stand,Invisible:1,CustomName:"\\"CMDSPACER\\""\
,Passengers:[{id:falling_block,Time:1,BlockState:{Name:"chain_command_block",Properties:{facing:"down"}},TileEntityData:{Command:"' \
                           + cmd[i] + '"}'

            command += ',Passengers:[{id:armor_stand,Invisible:1,CustomName:"\\"CMDSPACER\\""\
,Passengers:[{id:falling_block,Time:1,BlockState:{Name:"command_block",Properties:{facing:"down"}},TileEntityData:{auto:1,Command:"' \
                           + cmd[0] + '"}' + '}]}]' * num + '}]}]}'

            print(command)

        else:
            print('No command supplied', file=sys.stderr)
