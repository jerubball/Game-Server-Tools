AutoclickMod = {
	id: 'autoclick mod',
	name: 'Autoclick mod',
	modVersion: 7,
	author: 'jerubball',
	
	// --------------------------------------------------
	// START of SETTINGS
	// Please edit below as desired.
	// --------------------------------------------------
	
	cookieTime: 11, // all "Time" in milliseconds, unless otherwise noted.
	goldTime: 500,
	goldLife: 100, // in frames, which is 30-33 millisecond.
	goldWrath: true, // set to true to click wrath cookie, set to false to only click gold cookie
	reindeerTime: 200,
	reindeerLife: 7,
	wrinklerTime: 1000,
	wrinklerAll: false, // set to true to click all wrinklers, set to false to only click "last" wrinkler. will always leave "special" wrinkler
	lumpTime: 60000,
	lumpMature: false, // set to true to harvest when it is mature, set to false to wait until lump ripes. will always wait for "special" lumps.
	fortuneTime: 5000,
	gardenTime: 60000,
	gardenHarvest: 90, // when to harvest plant. all plants die at 100. will only harvest mature plant.
	gardenRandom: false, // set to true to randomly choose seed, set to false to re-plant harvested seed.
	gardenRetry: false, // set to true to retry planting if not enough money, set to false to do otherwise.
	gardenRetryTime: 60000,
	stockTime: 30000,
	stockConfig: [ // dollar = $econds of cps. buy lower than set value, sell higher than set value.
		{buy: 5.0, sell: 20.0}, //  0: CRL/Cereals, Farm
		{buy: 5.0, sell: 40.0}, //  1: CHC/Chocolate, Mine
		{buy: 5.0, sell: 40.0}, //  2: BTR/Butter, Factory
		{buy: 5.0, sell: 40.0}, //  3: SUG/Sugar, Bank
		{buy: 5.0, sell: 60.0}, //  4: NUT/Nuts, Temple
		{buy: 5.0, sell: 60.0}, //  5: SLT/Salt, Wizard tower
		{buy: 5.0, sell: 60.0}, //  6: VNL/Vanilla, Shipment
		{buy: 10.0, sell: 60.0}, //  7: EGG/Eggs, Alchemy lab
		{buy: 10.0, sell: 60.0}, //  8: CNM/Cinnamon, Portal
		{buy: 10.0, sell: 60.0}, //  9: CRM/Cream, Time machine
		{buy: 10.0, sell: 80.0}, // 10: JAM/Jam, Antimatter condenser
		{buy: 15.0, sell: 100.0}, // 11: WCH/White chocolate, Prism
		{buy: 15.0, sell: 100.0}, // 12: HNY/Honey, Chancemaker
		{buy: 15.0, sell: 100.0}, // 13: CKI/Cookies, Fractal engine
		{buy: 15.0, sell: 100.0}, // 14: RCP/Recipes, Javascript console
		{buy: 15.0, sell: 100.0}, // 15: SBD/Subsidiaries, Idleverse
	],
	grimoireTime: 60000,
	grimoireTarget: 1, // 
	
	// --------------------------------------------------
	// END of SETTINGS
	// Do not edit after this line.
	// --------------------------------------------------
	
	// setInterval ID variables
	cookieInterval: null,
	goldInterval: null,
	reindeerInterval: null,
	wrinklerInterval: null,
	lumpInterval: null,
	fortuneInterval: null,
	gardenInterval: null,
	stockInterval: null,
	grimoireInterval: null,
	
	// minigame variable access
	garden: null, // Game.ObjectsById[2].minigame
	stockMarket: null, // Game.ObjectsById[5].minigame
	pantheon: null, // Game.ObjectsById[6].minigame
	grimoire: null, // Game.ObjectsById[7].minigame
	
	
	// --------------------------------------------------
	// functions required by mod specification
	// --------------------------------------------------
	
	init() {
		/* Residual code block
		// we declare "MOD" as a proxy for "this", this is done for scoping/closure of this inside nested function.
		This is no longer needed as lambda function does not have own scope.
		let MOD = this;
		element.onclick = function (evt) {
			return MOD.func(this, evt);
		};
		[a,b] = [1,2]
		{a,b} = {a:1,b:2}
		function(...a) {console.log(...a)}
		function({a,b}={}) {console.log(a,b)}
		// style tags
		float:right; right:56px; z-index:1000000001; z-index:10001; z-index:500; display:block;
		.autoClickModGroup {display:flex; justify-content:space-between;} \n\
		div.autoClickModGroup > a:first-child {margin-right:1.5em;} \n\
		*/
		
		// create HTML elements
		this.autoContainer = this.createElement('div', 'autoClickModContainer');
		if (Game.sesame) {
			this.autoContainer.style = 'top:140px;';
		}
		
		this.menuBtn = this.createElement('div', 'autoClickModMenuBtn', 'crate', 'enabled', 'icon');
		this.menuBtn.onclick = (event) => {this.displayToggle(event, this.menuContainer);};
		
		this.menuContainer = this.createElement('div', 'autoClickModMenu', 'framed');
		this.displayToggle(undefined, this.menuContainer, true);
		
		this.menuTitle = this.createElement('span', 'autoClickModTitle');
		this.menuTitle.innerText = this.name + ' version ' + this.modVersion;
		this.menuTitle.onclick = (event) => {this.displayToggle(event, this.authorContainer);};
		
		this.authorContainer = this.createElement('div');
		this.displayToggle(undefined, this.authorContainer, true);
		
		this.authorText = this.createElement('span');
		this.authorText.innerText = 'made by ' + this.author;
		this.debugCount = 10;
		this.authorText.onclick = (event) => {this.debugToggle(event);};
		
		this.debugContainer = this.createElement('div');
		this.displayToggle(undefined, this.debugContainer, true);
		
		this.appendChildren(this.authorContainer, this.authorText, this.debugContainer);
		
		this.debugBar = this.createElement('div', undefined, 'line');
		
		this.debugBtnRow = this.createElement('div');
		this.debugBtn = this.createElement('a');
		this.debugBtn.innerText = 'debug:';
		this.debugBtn.onclick = (event) => {this.debug(event);};
		this.appendChildren(this.debugBtnRow, this.debugBtn);
		
		this.debugAddonRow = this.createElement('div');
		this.debugAddon = this.createElement('a');
		this.debugAddon.innerText = 'Get Third-party achievement';
		this.debugAddon.onclick = (event) => {Game.Win('Third-party');};
		this.appendChildren(this.debugAddonRow, this.debugAddon);
		
		this.debugCheatRow = this.createElement('div');
		this.debugCheat = this.createElement('a');
		this.debugCheat.innerText = 'Get Cheated cookie achievement';
		this.debugCheat.onclick = (event) => {Game.Win('Cheated cookies taste awful');};
		this.appendChildren(this.debugCheatRow, this.debugCheat);
		
		this.appendChildren(this.debugContainer, this.debugBar, this.debugBtnRow, this.debugAddonRow, this.debugCheatRow);
		
		this.menuTitleBar = this.createElement('div', undefined, 'line');
		
		this.menuTable = this.createElement('table', 'autoClickModTable');
		this.createTable(this.menuTable, 9, 2);
		
		this.cookieBtn = this.createElement('a');
		this.cookieBtn.innerText = 'Cookie click: ';
		this.cookieBtn.onclick = (event) => {this.cookieToggle(event);};
		this.menuTable.rows[0].cells[0].appendChild(this.cookieBtn);
		
		this.goldBtn = this.createElement('a');
		this.goldBtn.innerText = 'Golden cookie click: ';
		this.goldBtn.onclick = (event) => {this.goldToggle(event);};
		this.menuTable.rows[1].cells[0].appendChild(this.goldBtn);
		this.goldSet = this.createElement('a');
		this.goldSet.innerText = 'Wrath cookie: '
		this.goldSet.onclick = (event) => {this.goldOption(event);};
		this.menuTable.rows[1].cells[1].appendChild(this.goldSet);
		
		this.reindeerBtn = this.createElement('a');
		this.reindeerBtn.innerText = 'Reindeer click: ';
		this.reindeerBtn.onclick = (event) => {this.reindeerToggle(event);};
		this.menuTable.rows[2].cells[0].appendChild(this.reindeerBtn);
		
		this.wrinklerBtn = this.createElement('a');
		this.wrinklerBtn.innerText = 'Wrinkler click: ';
		this.wrinklerBtn.onclick = (event) => {this.wrinklerToggle(event);};
		this.menuTable.rows[3].cells[0].appendChild(this.wrinklerBtn);
		this.wrinklerSet = this.createElement('a');
		this.wrinklerSet.innerText = 'All wrinklers: ';
		this.wrinklerSet.onclick = (event) => {this.wrinklerOption(event);};
		this.menuTable.rows[3].cells[1].appendChild(this.wrinklerSet);
		
		this.lumpBtn = this.createElement('a');
		this.lumpBtn.innerText = 'Lump click: ';
		this.lumpBtn.onclick = (event) => {this.lumpToggle(event);};
		this.menuTable.rows[4].cells[0].appendChild(this.lumpBtn);
		this.lumpSet = this.createElement('a');
		this.lumpSet.innerText = 'Harvest mature: ';
		this.lumpSet.onclick = (event) => {this.lumpOption(event);};
		this.menuTable.rows[4].cells[1].appendChild(this.lumpSet);
		
		this.fortuneBtn = this.createElement('a');
		this.fortuneBtn.innerText = 'Fortune news click: ';
		this.fortuneBtn.onclick = (event) => {this.fortuneToggle(event);};
		this.menuTable.rows[5].cells[0].appendChild(this.fortuneBtn);
		
		this.gardenBtn = this.createElement('a');
		this.gardenBtn.innerText = 'Auto garden: ';
		this.gardenBtn.onclick = (event) => {this.gardenToggle(event);};
		this.menuTable.rows[6].cells[0].appendChild(this.gardenBtn);
		this.gardenSetRetry = this.createElement('a');
		this.gardenSetRetry.innerText = 'Retry if not enough: ';
		this.gardenSetRetry.onclick = (event) => {this.gardenOptionRetry(event);};
		this.menuTable.rows[6].cells[1].appendChild(this.gardenSetRetry);
		
		this.stockBtn = this.createElement('a');
		this.stockBtn.innerText = 'Auto stock market: ';
		this.stockBtn.onclick = (event) => {this.stockToggle(event);};
		this.menuTable.rows[7].cells[0].appendChild(this.stockBtn);
		
		this.grimoireBtn = this.createElement('a');
		this.grimoireBtn.innerText = 'Auto grimoire: ';
		this.grimoireBtn.onclick = (event) => {this.grimoireToggle(event);};
		this.menuTable.rows[8].cells[0].appendChild(this.grimoireBtn);
		this.grimoireSetLabel = this.createElement('span');
		this.grimoireSetLabel.innerText = 'Target: ';
		this.menuTable.rows[8].cells[1].appendChild(this.grimoireSetLabel);
		this.grimoireSet = this.createElement('input', undefined, 'autoClickModInput');
		this.grimoireSet.type = 'number';
		this.grimoireSet.min = 0;
		this.grimoireSet.onchange = (event) => {this.grimoireOption(event);};
		this.menuTable.rows[8].cells[1].appendChild(this.grimoireSet);
		
		this.style = this.createElement('style');
		this.style.innerHTML = '\n\
			#autoClickModContainer {position:absolute; left:0; z-index:10001; padding:3px;} \n\
			#autoClickModTitle {display:block; color:white; font-weight:bold;} \n\
			#autoClickModMenuBtn {display:inline-block; padding:0; margin:0; background-position:-576px 0px; transform:scale(0.75);} \n\
			#autoClickModMenu {display:inline-block; margin:3px 6px;} \n\
			div#autoClickModMenu a, div#autoClickModMenu span {line-height:1.25;} \n\
			table#autoClickModTable td:first-child {width:12.5em;} \n\
			table#autoClickModTable td:last-child {width:11.5em;} \n\
			.autoClickModOn::after {content:"ON"; font-weight:bold;} \n\
			.autoClickModOff::after {content:"OFF"; font-weight:bold;} \n\
			input.autoClickModInput {width:2.5em; padding:0 2px; border:none;} \n\
			input.autoClickModInput:focus {outline:none;} \n\
			';
		
		// add html elements
		this.appendChildren(this.menuContainer, this.menuTitle, this.authorContainer, this.menuTitleBar, this.menuTable);
		this.appendChildren(this.autoContainer, this.menuBtn, this.menuContainer, this.style);
		this.updateAll();
		document.getElementById('sectionLeft').appendChild(this.autoContainer);
		
		Game.Notify(this.name + ' loaded!', 'ModVersion ' + this.modVersion, [12,0]);
		console.log(this.name + ' initialized');
	},
	
	save() {
		//use this to store persistent data associated with your mod
		let obj = {
			'goldWrath': this.goldWrath,
			'wrinklerAll': this.wrinklerAll,
			'lumpMature': this.lumpMature,
			'gardenRetry': this.gardenRety,
			'grimoireTarget': this.grimoireTarget,
			'cookie': (this.cookieInterval !== null),
			'gold': (this.goldInterval !== null),
			'reindeer': (this.reindeerInterval !== null),
			'wrinkler': (this.wrinklerInterval !== null),
			'lump': (this.lumpInterval !== null),
			'fortune': (this.fortuneInterval !== null),
			'garden': (this.gardenInterval !== null),
			'stock': (this.stockInterval !== null),
			'grimoire': (this.grimoireInterval !== null),
		};
		let str = JSON.stringify(obj);
		console.log(this.name + ' saved');
		return str;
	},
	
	load(str) {
		//do stuff with the string data you saved previously
		if (str) {
			let obj = JSON.parse(str);
			this.goldWrath = obj['goldWrath'];
			this.wrinklerAll = obj['wrinklerAll'];
			this.lumpMature = obj['lumpMature'];
			this.gardenRetry = obj['gardenRetry'];
			this.grimoireTarget = obj['grimoireTarget'];
			/*if (obj['cookie']) {
				this.cookieToggle();
			}*/
			this.updateAll();
			console.log(this.name + ' loaded');
		} else {
			console.log(this.name + ' loaded: no savedata');
		}
	},
	
	// --------------------------------------------------
	// utility functions
	// --------------------------------------------------
	
	updateAll() {
		this.updateElement(this.cookieBtn, this.cookieInterval);
		this.updateElement(this.goldBtn, this.goldInterval);
		this.updateElement(this.goldSet, this.goldWrath);
		this.updateElement(this.reindeerBtn, this.reindeerInterval);
		this.updateElement(this.wrinklerBtn, this.wrinklerInterval);
		this.updateElement(this.wrinklerSet, this.wrinklerAll);
		this.updateElement(this.lumpBtn, this.lumpInterval);
		this.updateElement(this.lumpSet, this.lumpMature);
		this.updateElement(this.fortuneBtn, this.fortuneInterval);
		this.updateElement(this.gardenBtn, this.gardenInterval);
		this.updateElement(this.gardenSetRetry, this.gardenRetry);
		this.updateElement(this.stockBtn, this.stockInterval);
		this.updateElement(this.grimoireBtn, this.grimoireInterval);
		this.grimoireOption(undefined, this.grimoireTarget);
	},
	
	updateElement(element, state) {
		if (state) {
			element.classList.add('autoClickModOn');
			element.classList.remove('autoClickModOff');
		} else {
			element.classList.add('autoClickModOff');
			element.classList.remove('autoClickModOn');
		}
	},
	
	debug(event) {
		this.debugBtn.innerText = 'debug: ' + this;
	},
	
	debugToggle(event) {
		if (--this.debugCount === 0) {
			this.displayToggle(event, this.debugContainer, false);
			//this.authorText.innerText = 'made by ' + this.author;
		} else if (this.debugCount < 0) {
			this.debugCount = 10;
			this.displayToggle(event, this.debugContainer, true);
		} else {
			//this.authorText.innerText = 'made by ' + this.author + ' (' + this.debugCount + ')';
		}
	},
	
	displayToggle(event, element, state) {
		if (state === undefined) {
			state = !element.hidden;
		}
		if (state) {
			element.hidden = true;
			element.style.display = 'none';
		} else {
			element.hidden = false;
			element.style.display = '';
		}
	},
	
	createTable(element, row, col) {
		let body = element.createTBody();
		for (let i = 0; i < row; i++) {
			let line = body.insertRow();
			for (let j = 0; j < col; j++) {
				line.insertCell();
			}
		}
	},
	
	createElement(tagName, elementId, ...classTokens) {
		let element = document.createElement(tagName);
		element.MOD = this;
		if (elementId !== undefined) {
			element.id = elementId;
		}
		if (classTokens.length > 0) {
			element.classList.add(...classTokens);
		}
		return element;
	},
	
	appendChildren(parent, ...nodes) {
		for (let i = 0; i < nodes.length; i++) {
			parent.appendChild(nodes[i]);
		}
	},
	
	debugAutoAscend() {
		// this.ascendInterval = null;
		if (this.ascendInterval) {
			clearInterval(this.ascendInterval);
			this.ascendInterval = null;
			this.debugBtn.innerText = 'debug: enable auto ascend';
		} else {
			this.ascendState = 0;
			this.ascnedBuyValue = 0;
			this.ascendInterval = setInterval(() => {
				if (this.ascendState === 0) {
					let newPrestige = Math.floor(Game.HowMuchPrestige(Game.cookiesReset + Game.cookiesEarned));
					if (newPrestige > Game.prestige) {
						this.ascendState = 1;
						Game.Ascend(true);
					} else {
						Game.storeBuyAll();
						if (++this.ascnedBuyValue === Game.ObjectsById.length) {
							this.ascnedBuyValue = 0;
						}
						Game.ObjectsById[this.ascnedBuyValue].buy(100);
					}
				} else if (this.ascendState === 1) {
					if (Game.AscendTimer === 0) {
						this.ascendState = 0;
						Game.Reincarnate(true);
					}
				}
			}, 200);
			this.debugBtn.innerText = 'debug: disable auto ascend';
		}
	},
	
	// --------------------------------------------------
	// Autoclick functions
	// --------------------------------------------------
	
	// click cookies.
	cookieToggle(event) {
		if (this.cookieInterval) {
			clearInterval(this.cookieInterval);
			this.cookieInterval = null;
		} else {
			this.cookieInterval = setInterval(Game.ClickCookie, this.cookieTime);
		}
		this.updateElement(this.cookieBtn, this.cookieInterval);
	},
	
	// click gold cookies
	goldToggle(event) {
		if (this.goldInterval) {
			clearInterval(this.goldInterval);
			this.goldInterval = null;
		} else {
			this.goldInterval = setInterval(() => {this.goldClick();}, this.goldTime);
		}
		this.updateElement(this.goldBtn, this.goldInterval);
	},
	goldClick() {
		for (let i = 0; i < Game.shimmers.length; i++) {
			if (Game.shimmers[i].type == 'golden' && (Game.shimmers[i].wrath == 0 || this.goldWrath) && Game.shimmers[i].life <= this.goldLife) {
				Game.shimmers[i].pop();
			}
		}
	},
	goldOption(event, state) {
		if (state === undefined) {
			this.goldWrath = !this.goldWrath;
		} else {
			this.goldWrath = state;
		}
		this.updateElement(this.goldSet, this.goldWrath);
	},
	
	// click reindeer
	reindeerToggle(event) {
		if (this.reindeerInterval) {
			clearInterval(this.reindeerInterval);
			this.reindeerInterval = null;
		} else {
			this.reindeerInterval = setInterval(() => {this.reindeerClick();}, this.reindeerTime);
		}
		this.updateElement(this.reindeerBtn, this.reindeerInterval);
	},
	reindeerClick() {
		for (let i = 0; i < Game.shimmers.length; i++) {
			if (Game.shimmers[i].type == 'reindeer' && Game.shimmers[i].life <= this.reindeerLife) {
				Game.shimmers[i].pop();
			}
		}
	},
	
	// click wrinklers
	wrinklerToggle(event) {
		if (this.wrinklerInterval) {
			clearInterval(this.wrinklerInterval);
			this.wrinklerInterval = null;
		} else {
			this.wrinklerInterval = setInterval(() => {this.wrinklerClick();}, this.wrinklerTime);
		}
		this.updateElement(this.wrinklerBtn, this.wrinklerInterval);
	},
	wrinklerClick() {
		if (this.wrinklerAll) {
			for (let i = 0; i < Game.wrinklers.length; i++) {
				if (Game.wrinklers[i].phase === 2 && Game.wrinklers[i].type === 0) {
					Game.wrinklers[i].hp = -10;
				}
			}
		} else {
			let count = 0, index = -1, value = 0;
			for (let i = 0; i < Game.wrinklers.length; i++) {
				if (Game.wrinklers[i].phase > 0) {
					count++;
					if (Game.wrinklers[i].type === 0 && Game.wrinklers[i].sucked > value) {
						index = i;
						value = Game.wrinklers[i].sucked;
					}
				}
			}
			if (count >= Game.getWrinklersMax() && index >= 0) {
				Game.wrinklers[index].hp = -10;
			}
		}
	},
	wrinklerOption(event, state) {
		if (state === undefined) {
			this.wrinklerAll = !this.wrinklerAll;
		} else {
			this.wrinklerAll = state;
		}
		this.updateElement(this.wrinklerSet, this.wrinklerAll);
	},
	
	
	// click sugar lumps
	lumpToggle(event) {
		if (this.lumpInterval) {
			clearInterval(this.lumpInterval);
			this.lumpInterval = null;
		} else {
			this.lumpInterval = setInterval(() => {this.lumpClick();}, this.lumpTime);
		}
		this.updateElement(this.lumpBtn, this.lumpInterval);
	},
	lumpClick() {
		let lumpAge = new Date().getTime() - Game.lumpT;
		if (lumpAge > ((this.lumpMature && Game.lumpCurrentType === 0) ? Game.lumpMatureAge : Game.lumpRipeAge)) {
			Game.clickLump();
		}
	},
	lumpOption(event, state) {
		if (state === undefined) {
			this.lumpMature = !this.lumpMature;
		} else {
			this.lumpMature = state;
		}
		this.updateElement(this.lumpSet, this.lumpMature);
	},
	
	// click fortune news
	fortuneToggle(event) {
		if (this.fortuneInterval) {
			clearInterval(this.fortuneInterval);
			this.fortuneInterval = null;
		} else {
			this.fortuneInterval = setInterval(() => {this.fortuneClick();}, this.fortuneTime);
		}
		this.updateElement(this.fortuneBtn, this.fortuneInterval);
	},
	fortuneClick() {
		if (Game.TickerEffect && Game.TickerEffect.type=='fortune') {
			Game.tickerL.click();
		}
	},
	
	// click garden
	gardenToggle(event) {
		if (this.gardenInterval) {
			clearInterval(this.gardenInterval);
			this.gardenInterval = null;
		} else {
			if (this.garden == null) {
				this.garden = Game.ObjectsById[2].minigame;
			}
			this.gardenInterval = setInterval(() => {this.gardenClick();}, this.gardenTime);
		}
		this.updateElement(this.gardenBtn, this.gardenInterval);
	},
	gardenClick() {
		// bypass garden.isTileUnlocked() and garden.getTile() as they are costly.
		let bound = this.garden.plotLimits[Math.max(1, Math.min(this.garden.plotLimits.length, this.garden.parent.level)) - 1];
		for (let x = bound[0]; x < bound[2]; x++) {
			for (let y = bound[1]; y < bound[3]; y++) {
				// check if can be harvested.
				let [plantId, plantAge] = this.garden.plot[y][x], harvested = false;
				if (--plantId >= 0 && plantAge >= this.gardenHarvest && plantAge >= this.garden.plantsById[plantId].mature) {
					harvested = this.garden.harvest(x, y);
				}
				// if empty, try to plant.
				if (harvested || plantId === -1) {
					this.gardenPlant(plantId, x, y, bound);
				}
			}
		}
	},
	gardenPlant(plantId, x, y, bound) {
		// check neighbors.
		if (this.garden.plot[y][x][0] === 0 && this.garden.plot[y][x][1] === 0
			&& (x === bound[0] || this.garden.plot[y][x-1][0] === 0) && (x === bound[2]-1 || this.garden.plot[y][x+1][0] === 0)
			&& (y === bound[1] || this.garden.plot[y-1][x][0] === 0) && (y === bound[3]-1 || this.garden.plot[y+1][x][0] === 0)) {
			// generate random selection if no previous
			if (plantId === -1 || this.gardenRandom) {
				let plantList = [];
				for (let i = 0; i < this.garden.plantsById.length; i++) {
					if (this.garden.plantsById[i].unlocked) {
						plantList.push(i);
					}
				}
				plantId = plantList[Math.floor(Math.random() * plantList.length)];
			}
			// plant or retry.
			if (!this.garden.useTool(plantId, x, y) && this.gardenRetry) {
				setTimeout(() => {this.gardenPlant(plantId, x, y, bound);}, this.gardenRetryTime);
			}
		}
	},
	gardenOptionRetry(event, state) {
		if (state === undefined) {
			this.gardenRetry = !this.gardenRetry;
		} else {
			this.gardenRetry = state;
		}
		this.updateElement(this.gardenSetRetry, this.gardenRetry);
	},
	gardenOptionRandom(event, state) {
		if (state === undefined) {
			this.gardenRandom = !this.gardenRandom;
		} else {
			this.gardenRandom = state;
		}
		this.updateElement(this.gardenSetRetry, this.gardenRandom);
	},
	
	// click stock market
	stockToggle(event) {
		if (this.stockInterval) {
			clearInterval(this.stockInterval);
			this.stockInterval = null;
		} else {
			if (this.stockMarket == null) {
				this.stockMarket = Game.ObjectsById[5].minigame;
			}
			this.stockInterval = setInterval(() => {this.stockClick();}, this.stockTime);
		}
		this.updateElement(this.stockBtn, this.stockInterval);
	},
	stockClick() {
		for (let i = 0; i < this.stockMarket.goodsById.length; i++) {
			let currentGood = this.stockMarket.goodsById[i]
			if (currentGood.active && currentGood.last === 0) {
				if (currentGood.val < this.stockConfig[i].buy) {
					this.stockMarket.buyGood(i, 10000);
				} else if (currentGood.val > this.stockConfig[i].sell) {
					this.stockMarket.sellGood(i, 10000);
				}
			}
		}
	},
	
	// click grimoire
	grimoireToggle(event) {
		if (this.grimoireInterval) {
			clearInterval(this.grimoireInterval);
			this.grimoireInterval = null;
		} else {
			if (this.grimoire == null) {
				this.grimoire = Game.ObjectsById[7].minigame;
				this.grimoireSet.max = this.grimoire.spellsById.length - 1;
			}
			this.grimoireInterval = setInterval(() => {this.grimoireClick();}, this.grimoireTime);
		}
		this.updateElement(this.grimoireBtn, this.grimoireInterval);
	},
	grimoireClick() {
		if (this.grimoire.magic === this.grimoire.magicM) {
			this.grimoire.castSpell(this.grimoire.spellsById[this.grimoireTarget]);
		}
	},
	grimoireOption(event, state) {
		if (this.grimoire == null) {
			this.grimoire = Game.ObjectsById[7].minigame;
			this.grimoireSet.max = this.grimoire.spellsById.length - 1;
		}
		if (state !== undefined) {
			this.grimoireSet.value = state;
		}
		if (this.grimoireSet.value !== '') {
			let value = parseInt(this.grimoireSet.value)
			if (value >= 0 && value < this.grimoire.spellsById.length) {
				this.grimoireTarget = value;
			} else {
				this.grimoireSet.value = this.grimoireTarget;
			}
		}
	},
};

// Why do I need this?
AutoclickMod.MOD = AutoclickMod;
AutoclickMod.GAME = Game;

Game.registerMod(AutoclickMod.id, AutoclickMod);
