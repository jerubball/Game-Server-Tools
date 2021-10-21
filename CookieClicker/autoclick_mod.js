AutoclickMod = {
	id: 'autoclick mod',
	name: 'Autoclick mod',
	modVersion: 6,
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
	lumpRipe: true, // set to true to wait until lump ripes, set to false to harvest when it is mature. will always wait for "special" lumps.
	gardenTime: 60000,
	gardenHarvest: 90, // when to harvest plant. all plants die at 100. will only harvest mature plant.
	gardenRetry: true, // set to true to retry planting if not enough money, set to false to do otherwise.
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
	gardenInterval: null,
	stockInterval: null,
	debugInterval: null,
	
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
		// style tags
		float:right; right:56px; z-index:1000000001;
		*/
		
		// create HTML elements
		this.autoContainer = this.createElement('div');
		this.autoContainer.id = 'autoClickModContainer';
		if (Game.sesame) {
			this.autoContainer.style = 'top:140px;';
		}
		
		this.menuBtn = this.createElement('div');
		this.menuBtn.id = 'autoClickModMenuBtn';
		this.menuBtn.classList.add('crate', 'enabled', 'icon');
		this.menuBtn.onclick = (event) => {this.displayToggle(event, this.menuContainer);};
		
		this.menuContainer = this.createElement('div');
		this.menuContainer.id = 'autoClickModMenu';
		this.menuContainer.classList.add('framed');
		this.displayToggle(undefined, this.menuContainer, true);
		
		this.menuTitle = this.createElement('span');
		this.menuTitle.style = 'color: white; font-weight: bold;';
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
		
		this.debugBar = this.createElement('div');
		this.debugBar.classList.add('line');
		
		this.debugBtn = this.createElement('a');
		this.debugBtn.innerText = 'debug:';
		this.debugBtn.onclick = (event) => {this.debug(event);};
		
		this.debugAddon = this.createElement('a');
		this.debugAddon.innerText = 'Get Third-party achievement';
		this.debugAddon.onclick = (event) => {Game.Win('Third-party');};
		
		this.debugCheat = this.createElement('a');
		this.debugCheat.innerText = 'Get Cheated cookie achievement';
		this.debugCheat.onclick = (event) => {Game.Win('Cheated cookies taste awful');};
		
		this.menuTitleBar = this.createElement('div');
		this.menuTitleBar.classList.add('line');
		
		this.cookieBtn = this.createElement('a');
		this.cookieBtn.innerText = 'Enable cookie click';
		this.cookieBtn.onclick = (event) => {this.cookieToggle(event);};
		
		this.goldBtn = this.createElement('a');
		this.goldBtn.innerText = 'Enable golden cookie click';
		this.goldBtn.onclick = (event) => {this.goldToggle(event);};
		
		this.reindeerBtn = this.createElement('a');
		this.reindeerBtn.innerText = 'Enable reindeer click';
		this.reindeerBtn.onclick = (event) => {this.reindeerToggle(event);};
		
		this.wrinklerBtn = this.createElement('a');
		this.wrinklerBtn.innerText = 'Enable wrinkler click';
		this.wrinklerBtn.onclick = (event) => {this.wrinklerToggle(event);};
		
		this.lumpBtn = this.createElement('a');
		this.lumpBtn.innerText = 'Enable lump click';
		this.lumpBtn.onclick = (event) => {this.lumpToggle(event);};
		
		this.gardenBtn = this.createElement('a');
		this.gardenBtn.innerText = 'Enable auto garden';
		this.gardenBtn.onclick = (event) => {this.gardenToggle(event);};
		
		this.stockBtn = this.createElement('a');
		this.stockBtn.innerText = 'Enable auto stock market';
		this.stockBtn.onclick = (event) => {this.stockToggle(event);};
		
		this.style = this.createElement('style');
		this.style.innerHTML = '\n\
			#autoClickModContainer {position:absolute; left:0; z-index:10001; padding:3px;} \n\
			#autoClickModMenuBtn {display:inline-block; padding:0; margin:0; background-position:-576px 0px; transform:scale(0.75);} \n\
			#autoClickModMenu {display:inline-block; margin:3px 6px;} \n\
			div#autoClickModMenu a, div#autoClickModMenu span {display:block; line-height: 1.25;} \n\
			';
		
		// add html elements
		this.appendChildren(this.autoContainer, this.menuBtn, this.menuContainer, this.style);
		this.appendChildren(this.menuContainer,
							this.menuTitle, this.authorContainer, this.menuTitleBar,
							this.cookieBtn, this.goldBtn, this.reindeerBtn, this.wrinklerBtn, this.lumpBtn,
							this.gardenBtn, this.stockBtn);
		this.appendChildren(this.authorContainer, this.authorText, this.debugContainer);
		this.appendChildren(this.debugContainer, this.debugBar, this.debugBtn, this.debugAddon, this.debugCheat);
		document.getElementById('sectionLeft').appendChild(this.autoContainer);
		
		Game.Notify(this.name + ' loaded!', 'ModVersion ' + this.modVersion, [12,0]);
		console.log(this.name + ' initialized');
	},
	
	save() {
		//use this to store persistent data associated with your mod
		console.log(this.name + ' saved');
		return '';
	},
	
	load(str) {
		//do stuff with the string data you saved previously
		console.log(this.name + ' loaded');
	},
	
	// --------------------------------------------------
	// utility functions
	// --------------------------------------------------
	
	debug(event) {
		//this.debugBtn.innerText = 'debug: ' + this;
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
	
	createElement(tagName) {
		let element = document.createElement(tagName);
		element.MOD = this;
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
			this.debugBtn.innerText = 'debug: auto ascend enable';
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
			this.debugBtn.innerText = 'debug: auto ascend disable';
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
			this.cookieBtn.innerText = 'Enable cookie click';
		} else {
			this.cookieInterval = setInterval(Game.ClickCookie, this.cookieTime);
			this.cookieBtn.innerText = 'Disable cookie click';
		}
	},
	
	// click gold cookies
	goldToggle(event) {
		if (this.goldInterval) {
			clearInterval(this.goldInterval);
			this.goldInterval = null;
			this.goldBtn.innerText = 'Enable golden cookie click';
		} else {
			this.goldInterval = setInterval(() => {this.goldClick();}, this.goldTime);
			this.goldBtn.innerText = 'Disable golden cookie click';
		}
	},
	goldClick() {
		for (let i = 0; i < Game.shimmers.length; i++) {
			if (Game.shimmers[i].type == 'golden' && (Game.shimmers[i].wrath == 0 || this.goldWrath) && Game.shimmers[i].life <= this.goldLife) {
				Game.shimmers[i].pop();
			}
		}
	},
	
	// click reindeer
	reindeerToggle(event) {
		if (this.reindeerInterval) {
			clearInterval(this.reindeerInterval);
			this.reindeerInterval = null;
			this.reindeerBtn.innerText = 'Enable reindeer click';
		} else {
			this.reindeerInterval = setInterval(() => {this.reindeerClick();}, this.reindeerTime);
			this.reindeerBtn.innerText = 'Disable reindeer click';
		}
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
			this.wrinklerBtn.innerText = 'Enable wrinkler click';
		} else {
			this.wrinklerInterval = setInterval(() => {this.wrinklerClick();}, this.wrinklerTime);
			this.wrinklerBtn.innerText = 'Disable wrinkler click';
		}
	},
	wrinklerClick() {
		if (this.wrinklerAll) {
			for (let i = 0; i < Game.wrinklers.length; i++) {
				if (Game.wrinklers[i].phase > 0 && Game.wrinklers[i].type === 0) {
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
	
	// click sugar lumps
	lumpToggle(event) {
		if (this.lumpInterval) {
			clearInterval(this.lumpInterval);
			this.lumpInterval = null;
			this.lumpBtn.innerText = 'Enable lump click';
		} else {
			this.lumpInterval = setInterval(() => {this.lumpClick();}, this.lumpTime);
			this.lumpBtn.innerText = 'Disable lump click';
		}
	},
	lumpClick() {
		let lumpAge = new Date().getTime() - Game.lumpT;
		if (lumpAge > ((this.lumpRipe || Game.lumpCurrentType !== 0) ? Game.lumpRipeAge : Game.lumpMatureAge)) {
			Game.clickLump();
		}
	},
	
	// click garden
	gardenToggle(event) {
		if (this.gardenInterval) {
			clearInterval(this.gardenInterval);
			this.gardenInterval = null;
			this.gardenBtn.innerText = 'Enable auto garden';
		} else {
			if (this.garden == null) {
				this.garden = Game.ObjectsById[2].minigame;
			}
			this.gardenInterval = setInterval(() => {this.gardenClick();}, this.gardenTime);
			this.gardenBtn.innerText = 'Disable auto garden';
		}
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
			if (plantId === -1) {
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
	
	// click stock market
	stockToggle(event) {
		if (this.stockInterval) {
			clearInterval(this.stockInterval);
			this.stockInterval = null;
			this.stockBtn.innerText = 'Enable auto stock market';
		} else {
			if (this.stockMarket == null) {
				this.stockMarket = Game.ObjectsById[5].minigame;
			}
			this.stockInterval = setInterval(() => {this.stockClick();}, this.stockTime);
			this.stockBtn.innerText = 'Disable auto stock market';
		}
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
};

// Why do I need this?
AutoclickMod.MOD = AutoclickMod;
AutoclickMod.GAME = Game;

Game.registerMod(AutoclickMod.id, AutoclickMod);
