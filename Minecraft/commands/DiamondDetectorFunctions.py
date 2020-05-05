
if __name__ == '__main__':

    for limit in range(1,6):
        ans = set()
        for depth in range(0,limit+1):
            temp = set()
            for index in range(0,limit-depth+1):
                temp.add((index,depth+1,limit-depth-index))
            for item in temp.copy():
                temp.add((item[0],item[1],-item[2]))
            for item in temp.copy():
                temp.add((-item[0],item[1],item[2]))
            for item in temp.copy():
                temp.add((item[0],-item[1]+1,item[2]))
            ans = ans.union(temp)

        str1 = 'execute at @a[scores={detectdiamond=' + str(limit) + '..},gamemode=!spectator] if block'
        str3 = ' diamond_ore run tell @p Diamond ore detected within '
        if limit == 1:
            str3 += str(limit) + ' block.'
        else:
            str3 += str(limit) + ' blocks.'

        for item in ans:
            str2 = ''
            for i in range(3):
                str2 += ' ~'
                if item[i] != 0:
                    str2 += str(item[i])
            print(str1 + str2 + str3)
        print()
