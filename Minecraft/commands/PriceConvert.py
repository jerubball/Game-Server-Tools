
def convert(filename='worth.yml', adjust=10.0, multiplier=2):
    output = []
    with open(filename) as worth:
        for line in worth:
            line = line.strip()
            if len(line) > 0 and line[0] != '#':
                parts = line.split(':')
                if len(parts) == 2:
                    name = parts[0].lower()
                    price = round(float(parts[1]) * adjust)
                    output.append('scoreboard players set ' + name + '_sell Price ' + str(price))
                    output.append('scoreboard players set ' + name + '_sell_64 Price ' + str(price * 64))
                    output.append('scoreboard players set ' + name + '_buy Price ' + str(price * multiplier))
                    #output.append('scoreboard players set ' + name + '_buy_4 Price ' + str(price * multiplier * 4))
                    output.append('scoreboard players set ' + name + '_buy_16 Price ' + str(price * multiplier * 16))
                    #output.append('scoreboard players set ' + name + '_buy_64 Price ' + str(price * multiplier * 64))
                    output.append('')
    return output

def convert_interactive(filename='worth.yml', adjust=10.0, multiplier=2):
    output = []
    with open(filename) as worth:
        for line in worth:
            line = line.strip()
            if len(line) > 0 and line[0] != '#':
                parts = line.split(':')
                if len(parts) == 2:
                    name = parts[0].lower()
                    price = round(float(parts[1]) * adjust)
                    print('Name: ' + name + '\nPrice: ' + str(price))
                    num = input('Amount?: ')
                    print()
                    if len(num) > 0:
                        output.append('scoreboard players set ' + name + '_sell_' + num + ' Price ' + str(price * int(num)))
                        output.append('scoreboard players set ' + name + '_buy_' + num + ' Price ' + str(price * int(num) * multiplier))
                        output.append('')
    return output

output = convert('base.yml')
#output = convert_interactive('base.yml')
print('\n'.join(output))
