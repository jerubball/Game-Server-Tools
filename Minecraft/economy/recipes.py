import os
import json
import re
#import sys

#os.chdir('recipes')
recipedir = 'recipes\\'
items = os.listdir(recipedir)
tagdir = 'tags\\items\\'
tags = os.listdir(tagdir)

def getItemName(item):
    index = item.find('_from_')
    if index != -1:
        itemname = item[:index]
    else:
        itemname = item[:-5]
    return itemname

def enumerateRecipeNames(items, outfilename='recipes.json', showentry=True):
    names = {}
    for item in items:
        itemname = getItemName(item)
        if itemname not in names:
            names[itemname] = {'count': 1, 'entry': []}
        else:
            names[itemname]['count'] += 1
        if showentry:
            names[itemname]['entry'].append(item)
    if outfilename is not None:
        with open(outfilename, mode='w') as recipefile:
            recipefile.write(json.dumps(names, sort_keys=True, indent=2))
    return names

def enumerateRecipeTypes(items, itemprefix=recipedir, outfilename='types.json', showentry=True):
    types = {}
    for item in items:
        with open(itemprefix + item) as recipe:
            info = json.loads(recipe.read())
        if info['type'] not in types:
            types[info['type']] = {'count': 1, 'entry': []}
        else:
            types[info['type']]['count'] += 1
        if showentry:
            types[info['type']]['entry'].append(item)
    if outfilename is not None:
        with open(outfilename, mode='w') as outfile:
            outfile.write(json.dumps(types, sort_keys=True, indent=2))
    return types

def enumerateItemTagList(tags, tagprefix=tagdir, outfilename='itemtags.json'):
    names = {}
    for tag in tags:
        with open(tagprefix + tag) as tagdata:
            info = json.loads(tagdata.read())
        tagname = 'minecraft:' + tag[:-5]
        name = ''
        for entry in info['values']:
            if len(name) > 0:
                name += '||'
            name += entry
        names[tagname] = name
    for tagname in names:
        while '#' in names[tagname]:
            match = re.search('#([^|]+)', names[tagname])
            searchname = match.group(1)
            if searchname == tagname:
                raise Exception('recursion detected')
            else:
                names[tagname] = names[tagname][:match.start()] + names[searchname] + names[tagname][match.end():]
    if outfilename is not None:
        with open(outfilename, mode='w') as outfile:
            outfile.write(json.dumps(names, sort_keys=True, indent=2))
    return names 

def getIngredientName(data, exceptionmsg='unrecognized format'):
    # data has list
    if type(data) == list:
        name = ''
        for entry in data:
            if len(name) > 0:
                name += '||'
            if 'item' in entry:
                name += entry['item']
            elif 'tag' in entry:
                try:
                    name += itemtaglist[data['tag']]
                except (NameError, KeyError):
                    name += 'tag:' + data['tag']
            else:
                raise Exception(exceptionmsg)
    # data has 'item'
    elif 'item' in data:
        name = data['item']
    # data has 'tag'
    elif 'tag' in data:
        try:
            name = itemtaglist[data['tag']]
        except (NameError, KeyError):
            name = 'tag:' + data['tag']
    # data has none
    else:
        raise Exception(exceptionmsg)
    return name

def getCraftingResult(info, ingredient):
    result = {}
    if type(info['result']) == dict and 'count' in info['result']:
        result['count'] = info['result']['count']
    else:
        result['count'] = 1
    result['ingredient'] = ingredient
    return result

def addIngredient(ingredients, itemname, result):
    if itemname not in ingredients:
        ingredients[itemname] = []
    ingredients[itemname].append(result)

def readBaselineIngredients(infilename='baseingredients.json'):
    ingredients = None
    with open(infilename) as ingredientfile:
        ingredients = json.loads(ingredientfile.read())
    return ingredients

def enumerateRecipeIngredients(ingredients, items, itemprefix=recipedir, outfilename='ingredients.json'):
    for item in items:
        #itemname = getItemName(item)
        with open(itemprefix + item) as recipe:
            info = json.loads(recipe.read())
        if 'crafting_special_' in info['type']:
            continue
        # shaped crafting recipe
        if info['type'] == 'minecraft:crafting_shaped':
            counter = {}
            for line in info['pattern']:
                for char in line:
                    if char not in counter:
                        counter[char] = 1
                    else:
                        counter[char] += 1
            countresult = {}
            for key, value in counter.items():
                if key in info['key']:
                    name = getIngredientName(info['key'][key], 'unrecognized format for shaped recipe key')
                    countresult[name] = value
            addIngredient(ingredients, info['result']['item'], getCraftingResult(info, countresult))
        # shapeless crafting recipe
        if info['type'] == 'minecraft:crafting_shapeless':
            countresult = {}
            for key in info['ingredients']:
                name = getIngredientName(key, 'unrecognized format for shapeless recipe ingredients')
                if name not in countresult:
                    countresult[name] = 1
                else:
                    countresult[name] += 1
            addIngredient(ingredients, info['result']['item'], getCraftingResult(info, countresult))
        # smelting crafting recipe
        if info['type'] == 'minecraft:smelting':
            countresult = {'minecraft:coal': 0.125}
            name = getIngredientName(info['ingredient'], 'unrecognized format for smelting recipe ingredient')
            countresult[name] = 1
            addIngredient(ingredients, info['result'], getCraftingResult(info, countresult))
        # smithing crafting recipe
        if info['type'] == 'minecraft:smithing':
            countresult = {}
            name = getIngredientName(info['base'])
            countresult[name] = 1
            name = getIngredientName(info['addition'])
            if name not in countresult:
                countresult[name] = 1
            else:
                countresult[name] += 1
            addIngredient(ingredients, info['result']['item'], getCraftingResult(info, countresult))
    if outfilename is not None:
        with open(outfilename, mode='w') as outfile:
            outfile.write(json.dumps(ingredients, sort_keys=True, indent=2))
    return ingredients

def readBaselineCosts(infilename='basecosts.json'):
    costs = None
    with open(infilename) as costfile:
        costs = json.loads(costfile.read())
    return costs

#stacktrace = []
#baseitemnames = ['minecraft:wheat', 'minecraft:honey_bottle', 'minecraft:slime_ball']
def calculateRelativeCost(costs, outfilename='costs.json', verbose=False):
    def calculateItemCost(itemname):
        #stacktrace.append(itemname)
        if itemname not in costs:
            if itemname in ingredientlist:
                itemdata = ingredientlist[itemname]
                if len(itemdata) > 1:
                    if 'minecraft:lapis_lazuli' in itemdata[0]['ingredient']:
                        index = 1
                    elif 'minecraft:redstone_block' in itemdata[0]['ingredient']:                        
                        index = 1
                    elif 'minecraft:honey_bottle' in itemdata[0]['ingredient']:
                        index = 1
                    elif 'minecraft:coal_block' in itemdata[0]['ingredient']:                        
                        index = 1
                    elif 'minecraft:diamond_block' in itemdata[0]['ingredient']:                        
                        index = 1
                    elif 'minecraft:dried_kelp_block' in itemdata[0]['ingredient']:                        
                        index = 1
                    elif 'minecraft:emerald_block' in itemdata[0]['ingredient']:                        
                        index = 1
                    elif 'minecraft:honey_bottle' in itemdata[0]['ingredient']:                        
                        index = 1
                    else:
                        index = 0
                    #index = int(input('Enter recipe index to use in calculation: '))
                    if verbose:
                        print('Multiple recipes found for', itemname)
                        for index in range(len(itemdata)):
                            print(index, ':', itemdata[index])
                        print('using index', index)
                    recipe = itemdata[index]
                else:
                    recipe = itemdata[0]
                totalcost = 0.0
                for key, value in recipe['ingredient'].items():
                    if '||' in key:
                        keyitems = key.split('||')
                        if keyitems[0] in ['minecraft:chiseled_quartz_block']:
                            index = 1
                        else:
                            index = 0
                        #index = int(input('Enter ingredient index to use in calculation: '))
                        if verbose:
                            print('Multiple ingredients found for', itemname)
                            for index in range(len(keyitems)):
                                print(index, ':', keyitems[index])
                            print ('using index', index)
                        key = keyitems[index]
                    totalcost += calculateItemCost(key) * value
                totalcost /= recipe['count']
                if 'factor' in recipe:
                    factor = recipe['factor']
                else:
                    factor = 1 + min(max(0.5 / totalcost, 0.01), 0.5)
                costs[itemname] = round(totalcost * factor, 2)
            else:
                #print('Base price for', itemname, 'is assumed to be 10')
                #costs[itemname] = 10.0
                #baseitemnames.append(itemname)
                costs[itemname] = float(input('Enter base price for ' + itemname + ': '))
        #stacktrace.pop()
        return costs[itemname]
    for itemname in ingredientlist:
        calculateItemCost(itemname)
    if outfilename is not None:
        with open(outfilename, mode='w') as outfile:
            outfile.write(json.dumps(costs, sort_keys=True, indent=2))
    return costs

def generatePotionRecipeIngredients(outfilename='potioningredients.json'):
    effectlist = {
        'water':            {'long': False, 'strong': False, 'ingredient': None},
        'awkward':          {'long': False, 'strong': False, 'ingredient': ('minecraft:water_potion', 'minecraft:nether_wart')},
        'mundane':          {'long': False, 'strong': False, 'ingredient': ('minecraft:water_potion', 'minecraft:sugar')},
        'thick':            {'long': False, 'strong': False, 'ingredient': ('minecraft:water_potion', 'minecraft:glowstone_dust')},
        'fire_resistance':  {'long': True, 'strong': False, 'ingredient': ('minecraft:awkward_potion', 'minecraft:magma_cream')},
        'harming':          {'long': False, 'strong': True, 'ingredient': ('minecraft:poison_potion', 'minecraft:fermented_spider_eye')},
        'healing':          {'long': False, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:glistering_melon_slice')},
        'invisibility':     {'long': True, 'strong': False, 'ingredient': ('minecraft:night_vision_potion', 'minecraft:fermented_spider_eye')},
        'leaping':          {'long': True, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:rabbit_foot')},
        'night_vision':     {'long': True, 'strong': False, 'ingredient': ('minecraft:awkward_potion', 'minecraft:golden_carrot')},
        'poison':           {'long': True, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:spider_eye')},
        'regeneration':     {'long': True, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:ghast_tear')},
        'slowness':         {'long': True, 'strong': True, 'ingredient': ('minecraft:swiftness_potion', 'minecraft:fermented_spider_eye')},
        'slow_falling':     {'long': True, 'strong': False, 'ingredient': ('minecraft:awkward_potion', 'minecraft:phantom_membrane')},
        'strength':         {'long': True, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:blaze_powder')},
        'swiftness':        {'long': True, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:sugar')},
        'turtle_master':    {'long': True, 'strong': True, 'ingredient': ('minecraft:awkward_potion', 'minecraft:turtle_helmet')},
        'water_breathing':  {'long': True, 'strong': False, 'ingredient': ('minecraft:awkward_potion', 'minecraft:pufferfish')},
        'weakness':         {'long': True, 'strong': False, 'ingredient': ('minecraft:water_potion', 'minecraft:fermented_spider_eye')}
    }
    def addKeyResults(results, key, keyname):
        keyname1 = 'minecraft:' + key + '_splash_potion'
        results[keyname1] = [{
            'count': 2, 'ingredient': {'minecraft:blaze_powder': 0.1, keyname: 2, 'minecraft:gunpowder': 1}
        }]
        keyname2 = 'minecraft:' + key + '_lingering_potion'
        results[keyname2] = [{
            'count': 2, 'ingredient': {'minecraft:blaze_powder': 0.1, keyname1: 2, 'minecraft:dragon_breath': 1}
        }]
        keyname3 = 'minecraft:' + key + '_tipped_arrow'
        results[keyname3] = [{
            'count': 8, 'ingredient': {keyname2: 1, 'minecraft:arrow': 8}
        }]
    results = {}
    for key, value in effectlist.items():
        keyname = 'minecraft:' + key + '_potion'
        if value['ingredient'] is not None:
            results[keyname] = [{
                'count': 2, 'ingredient': {'minecraft:blaze_powder': 0.1, value['ingredient'][0]: 2, value['ingredient'][1]: 1}
            }]
        addKeyResults(results, key, keyname)
        if value['long']:
            newkey = 'long_' + key
            newkeyname = 'minecraft:' + newkey + '_potion'
            results[newkeyname] = [{
                'count': 2, 'ingredient': {'minecraft:blaze_powder': 0.1, keyname: 2, 'minecraft:redstone': 1}
            }]
            addKeyResults(results, newkey, newkeyname)
        if value['strong']:
            newkey = 'strong_' + key
            newkeyname = 'minecraft:' + newkey + '_potion'
            results[newkeyname] = [{
                'count': 2, 'ingredient': {'minecraft:blaze_powder': 0.1, keyname: 2, 'minecraft:glowstone_dust': 1}
            }]
            addKeyResults(results, newkey, newkeyname)
    if outfilename is not None:
        with open(outfilename, mode='w') as outfile:
            outfile.write(json.dumps(results, sort_keys=True, indent=2))
    return results

#enumerateRecipeNames(items)
#enumerateRecipeTypes(items, showentry=True)
itemtaglist = enumerateItemTagList(tags, outfilename=None)
ingredientlist = enumerateRecipeIngredients(readBaselineIngredients(), items, outfilename=None)
costs = calculateRelativeCost(readBaselineCosts())
#generatePotionRecipeIngredients()
