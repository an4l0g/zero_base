config = {}

config.prices = {

---------tipos de cor-----------

	['colortypes'] = {
		['cromado'] = 200,  -- + o preco da cor normal
		['metálico'] = 200,
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
		startprice = 200,
	},	
----------cor primaria--------
	['primaria'] = {
		startprice = 400,
	},
----------Perolado--------
	['perolado'] = {
		startprice = 0,
	},
----------Cor da roda--------
	['wheelcolor'] = {
		startprice = 200,
	},
----------Neon--------
	['neon'] = {
		startprice = 500,
	},
----------Pneu custom--------
	['custom'] = {
		startprice = 200,
	},
----------Pneu a prova de balas--------
	['bulletproof'] = {
		startprice = 5000,
	},
----------Placa--------
	['placa'] = {
		startprice = 200,
		increaseby = 0
	},
----------Vidro--------
	['vidro'] = {
		startprice = 400,
		increaseby = 0
	},
----------Liveries--------
	[48] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Windows--------
	[46] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Tank--------
	[45] = {
		startprice = 2000,
		increaseby = 2000
	},
	
----------Trim--------
	[44] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Aerials--------
	[43] = {
		startprice = 400,
		increaseby = 0
	},

----------Arch cover--------
	[42] = {
		startprice = 200,
		increaseby = 0
	},

----------Struts--------
	[41] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Air filter--------
	[40] = {
		startprice = 300,
		increaseby = 0
	},
	
----------Engine block--------
	[39] = {
		startprice = 200,
		increaseby = 0
	},

----------Hydraulics--------
	[38] = {
		startprice = 400,
		increaseby = 0
	},
	
----------Trunk--------
	[37] = {
		startprice = 400,
		increaseby = 0
	},

----------Speakers--------
	[36] = {
		startprice = 400,
		increaseby = 0
	},

----------Plaques--------
	[35] = {
		startprice = 200,
		increaseby = 0
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 200,
		increaseby = 0
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 200,
		increaseby = 0
	},
	
----------Seats--------
	[32] = {
		startprice = 200,
		increaseby = 0
	},
	
----------Door speaker--------
	[31] = {
		startprice = 200,
		increaseby = 0
	},

----------Dial--------
	[30] = {
		startprice = 200,
		increaseby = 0
	},
----------Dashboard--------
	[29] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Ornaments--------
	[28] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Trim--------
	[27] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Plate holder--------
	[25] = {
		startprice = 500,
		increaseby = 0
	},
---------Back Wheels---------
	[24] = {
		startprice = 500,
		increaseby = 0
	},
---------Front Wheels---------
	[23] = {
		startprice = 500,
		increaseby = 0
	},
---------Headlights---------
	[22] = {
		startprice = 500,
	},
	
----------Turbo---------
	[18] = {
		startprice = 1000,
	},
	
-----------Armor-------------
	[16] = {
		startprice = 5000,
		increaseby = 1000
	},

---------Suspension-----------
	[15] = {
		startprice = 500,
		increaseby = 500
	},
-----------Horn----------
    [14] = {
        startprice = 200,
		increaseby = 0
    },
-----------Transmission-------------
    [13] = {
        startprice = 1000,
		increaseby = 1000
	},
	
-----------Brakes-------------
	[12] = {
        startprice = 1000,
		increaseby = 1000
	},
	
------------Engine----------
	[11] = {
        startprice = 1000,
		increaseby = 1000
	},
    ---------Roof----------
	[10] = {
		startprice = 200,
		increaseby = 0
	},
	
------------Fenders---------
	[8] = {
		startprice = 500,
		increaseby = 0
	},
	
------------Hood----------
	[7] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Grille----------
	[6] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Roll cage----------
	[5] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Exhaust----------
	[4] = {
		startprice = 500,
		increaseby = 0
	},
	
----------Skirts----------
	[3] = {
		startprice = 800,
		increaseby = 0
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 800,
		increaseby = 0
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 800,
		increaseby = 0
	},
	
----------Spoiler----------
	[0] = {
		startprice = 1000,
		increaseby = 0
	},
}

config.mechanics = {
	{ coord = vector3(105.9429, -1413.758, 29.22925), perm = nil }
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')