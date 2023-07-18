config = {}

config.prices = {

---------tipos de cor-----------

	['colortypes'] = {
		['cromado'] = 1000,  -- + o preco da cor normal
		['metálico'] = 1000,
		['fosco'] = 0,
		['metal'] = 0 
	},

----------cor secundária custom--------
	['cor-secundaria'] = {
		startprice = 0,
	},	
----------cor primaria custom--------
	['cor-primaria'] = {
		startprice = 0,
	},
----------cor secundária--------
	['secundaria'] = {
		startprice = 1000,
	},	
----------cor primaria--------
	['primaria'] = {
		startprice = 2000,
	},
----------Perolado--------
	['perolado'] = {
		startprice = 0,
	},
----------Cor da roda--------
	['wheelcolor'] = {
		startprice = 1000,
	},
----------Neon--------
	['neon'] = {
		startprice = 10000,
	},
----------Pneu custom--------
	['custom'] = {
		startprice = 1000,
	},
----------Pneu a prova de balas--------
	['bulletproof'] = {
		startprice = 240000,
	},
----------Placa--------
	['placa'] = {
		startprice = 1000,
		increaseby = 0
	},
----------Vidro--------
	['vidro'] = {
		startprice = 3000,
		increaseby = 0
	},
----------Liveries--------
	[48] = {
		startprice = 5000,
		increaseby = 0
	},
	
----------Windows--------
	[46] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Tank--------
	[45] = {
		startprice = 10000,
		increaseby = 10000
	},
	
----------Trim--------
	[44] = {
		startprice = 1000,
		increaseby = 0
	},
	
----------Aerials--------
	[43] = {
		startprice = 2000,
		increaseby = 0
	},

----------Arch cover--------
	[42] = {
		startprice = 1000,
		increaseby = 0
	},

----------Struts--------
	[41] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Air filter--------
	[40] = {
		startprice = 2000,
		increaseby = 0
	},
	
----------Engine block--------
	[39] = {
		startprice = 2000,
		increaseby = 0
	},

----------Hydraulics--------
	[38] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Trunk--------
	[37] = {
		startprice = 3000,
		increaseby = 0
	},

----------Speakers--------
	[36] = {
		startprice = 3000,
		increaseby = 0
	},

----------Plaques--------
	[35] = {
		startprice = 1000,
		increaseby = 0
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 2000,
		increaseby = 0
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 2000,
		increaseby = 0
	},
	
----------Seats--------
	[32] = {
		startprice = 2000,
		increaseby = 0
	},
	
----------Door speaker--------
	[31] = {
		startprice = 2000,
		increaseby = 0
	},

----------Dial--------
	[30] = {
		startprice = 2000,
		increaseby = 0
	},
----------Dashboard--------
	[29] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Ornaments--------
	[28] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Trim--------
	[27] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Plate holder--------
	[25] = {
		startprice = 3000,
		increaseby = 0
	},
---------Back Wheels---------
	[24] = {
		startprice = 3000,
		increaseby = 0
	},
---------Front Wheels---------
	[23] = {
		startprice = 3000,
		increaseby = 0
	},
---------Headlights---------
	[22] = {
		startprice = 10000,
	},
	
----------Turbo---------
	[18] = {
		startprice = 10000,
	},
	
-----------Armor-------------
	[16] = {
		startprice = 10000,
		increaseby = 10000
	},

---------Suspension-----------
	[15] = {
		startprice = 3000,
		increaseby = 3000
	},
-----------Horn----------
    [14] = {
        startprice = 2000,
		increaseby = 0
    },
-----------Transmission-------------
    [13] = {
        startprice = 15000,
		increaseby = 8000
	},
	
-----------Brakes-------------
	[12] = {
        startprice = 8000,
		increaseby = 8000
	},
	
------------Engine----------
	[11] = {
        startprice = 8000,
		increaseby = 8000
	},
    ---------Roof----------
	[10] = {
		startprice = 2000,
		increaseby = 0
	},
	
------------Fenders---------
	[8] = {
		startprice = 3000,
		increaseby = 0
	},
	
------------Hood----------
	[7] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Grille----------
	[6] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Roll cage----------
	[5] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Exhaust----------
	[4] = {
		startprice = 3000,
		increaseby = 0
	},
	
----------Skirts----------
	[3] = {
		startprice = 4000,
		increaseby = 0
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 4000,
		increaseby = 0
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 5000,
		increaseby = 0
	},
	
----------Spoiler----------
	[0] = {
		startprice = 5000,
		increaseby = 0
	},
}

config.mechanics = {
	{ coord = vector3(105.9429, -1413.758, 29.22925), perm = nil }
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')