
if __name__ == '__main__':

    ores = ['diamond_ore', 'emerald_ore', 'ancient_debris', 'gold_ore', 'nether_gold_ore', 'lapis_ore', 'redstone_ore', 'iron_ore', 'nether_quarts_ore', 'coal_ore']
    value = {'diamond_ore': 0, 'emerald_ore': 1, 'ancient_debris': 2, 'gold_ore': 3, 'nether_gold_ore': 4, 'lapis_ore': 5, 'redstone_ore': 6, 'iron_ore': 7, 'nether_quarts_ore': 8, 'coal_ore': 9}
    name = {'diamond_ore': 'Diamond Ore', 'emerald_ore': 'Emerald Ore', 'ancient_debris': 'Ancient Debris', 'gold_ore': 'Gold Ore', 'nether_gold_ore': 'Nether Gold Ore', 'lapis_ore': 'Lapis Lazuli Ore', 'redstone_ore': 'Redstone Ore', 'iron_ore': 'Iron Ore', 'nether_quarts_ore': 'Nether Quartz Ore', 'coal_ore': 'Coal Ore'}
    multiplier = 10

    selection = ['diamond_ore', 'emerald_ore']
    size = range(1,7)

    for block in selection:
        for level in size:
            score = value[block] * multiplier + level
            print('execute at @a[scores={oretell=' + str(score) + '}] run tell @p ' + name[block] + ' detected within ' + str(level) + (' block.' if level == 1 else ' blocks.'))
        print()
    print()

    for block in selection:
        for level in size:
            score = value[block] * multiplier + level
            limit = (value[block] + 1) * multiplier
            ans = set()
            for depth in range(0,level+1):
                temp = set()
                for index in range(0,level-depth+1):
                    temp.add((index,depth+1,level-depth-index))
                for item in temp.copy():
                    temp.add((item[0],item[1],-item[2]))
                for item in temp.copy():
                    temp.add((-item[0],item[1],item[2]))
                for item in temp.copy():
                    temp.add((item[0],-item[1]+1,item[2]))
                ans = ans.union(temp)

            str0 = str(score) + '..' + str(limit)
            str1 = 'execute at @a[scores={orescan=' + str(score) + '..' + str(limit) + ',oretell=' + str(score+1) + '..},gamemode=!spectator] if block'
            str3 = ' ' + block + ' run scoreboard players set @p oretell ' + str(score)

            for item in ans:
                str2 = ''
                for i in range(3):
                    str2 += ' ~'
                    if item[i] != 0:
                        str2 += str(item[i])
                print(str1 + str2 + str3)
            print()
        print()
