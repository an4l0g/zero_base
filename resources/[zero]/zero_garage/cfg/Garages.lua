config.clientSpawn = false
config.clientSpawnForced = {
    ['paredao'] = true
}

config.taxSafe = 0.01
config.taxDetained = 0.01
config.taxIPVA = 0.01
config.ipvaDays = 7

config.vehicles = {
------------------------------------------------------------------------------------------------------------------------
-- EXCLUSIVO
------------------------------------------------------------------------------------------------------------------------
    ['dcd'] = { name = 'Dodge', maker = 'Charger', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['ESDUCATI2K22'] = { name = 'Juca', maker = 'Ducati', price = 1000000, trunk = 15, glove = 0, type = 'vip', class = 'motocycle', banned = false },

------------------------------------------------------------------------------------------------------------------------
-- VIP
------------------------------------------------------------------------------------------------------------------------
    ['foxevo'] = { name = 'Lamborghini Evo', maker = 'Lamborghini', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'sports', banned = false }, 
    ['gtr502'] = { name = 'GTR 50', maker = 'Nissan', price = 1000000, trunk = 40, glove = 15, type = 'vip', class = 'super', banned = false },
    ['h2carb'] = { name = 'Ninja H2 Carb.', maker = 'Kawasaki', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['r34bluedragon'] = { name = 'Skyline Dragon', maker = 'Nissan', price = 1000000, trunk = 40, glove = 15, type = 'vip', class = 'super', banned = false },
    ['velar'] = { name = 'velar', maker = 'Land Rover', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'suvs', banned = false },
    ['458spider'] = { name = 'Spider', maker = 'Ferrari', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['audirs6'] = { name = 'RS6', maker = 'Audi', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['rmodrs6'] = { name = 'RS6 G2', maker = 'Audi', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['r1200'] = { name = 'R1250', maker = 'BMW', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['babyhuracan'] = { name = 'Baby Huracan', maker = 'Lamborghini', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'super', banned = false },
    ['bmwm4gts'] = { name = 'M4 GTS', maker = 'BMW', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['monalisa'] = { name = 'Monalisa', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['hornet'] = { name = 'Hornet', maker = 'Honda', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['a80'] = { name = 'Supra', maker = 'Toyota', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['sennagtr'] = { name = 'Senna', maker = 'Mclaren', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['urus'] = { name = 'Urus', maker = 'Lamborghini', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'suvs', banned = false },
    ['ferrariitalia'] = { name = 'Italia 478', maker = 'Ferrari', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['maxima22'] = { name = 'Nissan maxima', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['bmwe39'] = { name = 'Bmw e39', maker = 'Bmw', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['370zrubytiger'] = { name = '370z', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['jeslbwk'] = { name = 'Jesko', maker = 'Koenigsegg', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['720s18'] = { name = 'Mclaren 720s', maker = 'McLaren', price = 1000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['rmodgt63'] = { name = 'GT 63', maker = 'Mercedes-Benz', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'super', banned = false },
    ['rmodr8c'] = { name = 'R8 Conv.', maker = 'Audi', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['tiger'] = { name = 'Tiger', maker = 'Triumph', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['21Charscat'] = { name = 'Mustang', maker = 'Ford Mustang', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['lancerevolutionx'] = { name = 'Lancer E. X', maker = 'Mitsubishi', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['lancerevolution9'] = { name = 'Lancer E. 9', maker = 'Mitsubishi', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['xxxxx'] = { name = 'Monster 6X6', maker = 'Mercedes-Benz', price = 1200000, trunk = 200, glove = 15, type = 'vip', class = 'offroad', banned = false },
    ['ym1'] = { name = 'Race M1', maker = 'Yamaha', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['6x6ev'] = { name = '6x6 EV', maker = 'Hummer', price = 1000000, trunk = 150, glove = 15, type = 'vip', class = 'offroad', banned = false },
    ['rmodskyline34'] = { name = 'SkyLineR34 G2', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['nissanskyliner34'] = { name = 'Skyline R34', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['370zRubyTiger'] = { name = 'Nissan 370z', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['auditt'] = { name = 'Audi TT', maker = 'Audi', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['911r'] = { name = '911R', maker = 'Porsche', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['bmws'] = { name = 'S1000rr', maker = 'Bmw', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['mt09black'] = { name = 'Mt09', maker = 'Yamaha', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['hbocnetrongt'] = { name = 'Audi R8', maker = 'Audi', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'super', banned = false },
    ['babyr34'] = { name = 'Baby R34', maker = 'Nissan', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'super', banned = false },
    ['q820'] = { name = 'Audi Q8', maker = 'Audi', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'suvs', banned = false },
    ['zn20'] = { name = 'TSR-GT', maker = 'Zenvo', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['g7cross'] = { name = 'Saveiro', maker = 'Volkswagen', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['r1250baby'] = { name = 'Baby R1250', maker = 'Bmw', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'motocycle', banned = false },
    ['cbb'] = { name = 'Cb1000R', maker = 'Honda', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['nis15'] = { name = 'Silvia 15', maker = 'Nissan', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['teslaprior'] = { name = 'Prior', maker = 'Tesla', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['babyjesko'] = { name = 'Baby Jesko', maker = 'Koenigsegg', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'super', banned = false },
    ['ram1500'] = { name = 'Ram', maker = 'Dodge Ram', price = 1000000, trunk = 50, glove = 15, type = 'vip', class = 'suvs', banned = false },
    ['rmodgtr50'] = { name = 'GTR 50', maker = 'Nissan', price = 1000000, trunk = 40, glove = 15, type = 'vip', class = 'super', banned = false },
    ['z1000'] = { name = 'Z1000', maker = 'Kawasaki', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['xj6'] = { name = 'XJ-6', maker = 'Yamaha', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['africat'] = { name = 'CRF 1000 Africa', maker = 'Honda', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['tenere1200'] = { name = 'Tenere 12000', maker = 'Yamaha', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'motocycle', banned = false },
    ['fk8'] = { name = 'FK8', maker = 'Honda', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['rmodmi8lb'] = { name = 'I8 libert walker', maker = 'BMW', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['m40i'] = { name = 'Bmw M40i', maker = 'Bmw', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['merc23'] = { name = 'Mercedes E-class', maker = 'Mercedes-Benz', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['foxct'] = { name = 'Cybertruck', maker = 'Tesla', price = 1000000, trunk = 100, glove = 15, type = 'vip', class = 'offroad', banned = false },
    ['babym4conversible'] = { name = 'Baby M4', maker = 'Bmw', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'super', banned = false },
    ['rmodbolide'] = { name = 'Bolide W16', maker = 'Bugatti', price = 1000000, trunk = 40, glove = 15, type = 'vip', class = 'super', banned = false },
    ['amarok'] = { name = 'Amarok', maker = 'Volkswagen', price = 1000000, trunk = 150, glove = 15, type = 'vip', class = 'offroad', banned = false },
    ['rmodgt63mini'] = { name = 'Baby Mercedes', maker = 'Mercedes-Benz', price = 1000000, trunk = 0, glove = 0, type = 'vip', class = 'super', banned = false },
    ['19raptor'] = { name = 'Raptor', maker = 'Ford', price = 1000000, trunk = 100, glove = 15, type = 'vip', class = 'offroad', banned = false },
    ['golfrebaixado'] = { name = 'Golf Rebaixado', maker = 'Volkswagen', price = 65000, trunk = 30, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['gxlaferrari'] = { name = 'Laferrari', maker = 'Ferrari', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['bmwi8'] = { name = 'i8', maker = 'BMW', price = 1000000, trunk = 20, glove = 15, type = 'vip', class = 'super', banned = false },
    ['nissanr33tbk'] = { name = 'skyline r33', maker = 'Nissan', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['718b'] = { name = '718B', maker = 'Porsche', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['tiger1200'] = { name = 'Tiger 1200', maker = 'Tiger', price = 1000000, trunk = 30, glove = 15, type = 'vip', class = 'super', banned = false },
    ['silvia'] = { name = 'Silvia', maker = 'Nissan', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['x6mf962'] = { name = 'Bmw X6', maker = 'Bmw', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['lwgtr'] = { name = 'Gtr', maker = 'Nissan', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['jetta'] = { name = 'Jetta Rebaixado', maker = 'Volkswagen', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['gtz34'] = { name = 'Skyline R34', maker = 'Nissan', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['gtrstitch'] = { name = 'Gtr', maker = 'Nissan', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ['p1lbwk'] = { name = 'P1', maker = 'Mclaren', price = 1000000, trunk = 35, glove = 15, type = 'vip', class = 'sports', banned = false },
    ------------------------------------------------------------------------------------------------------------------------
    -- CARS
    ------------------------------------------------------------------------------------------------------------------------
    ['asbo'] = { name = 'Asbo', maker = 'Maxwell', price = 100000, trunk = 50, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['drafter'] = { name = 'Drafter', maker = 'Obey', price = 150000, trunk = 30, glove = 15, type  = 'car', class = 'sports', banned = false },
    ['emerus'] = { name = 'Emerus', maker = 'Progen', price = 300000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['glendale2'] = { name = 'Glendale 2', maker = 'Benefactor', price = 200000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['remus'] = { name = 'Remus', maker = 'Annis', price = 150000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['savestra'] = { name = 'Savestra', maker = 'Annis', price = 150000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['entity3'] = { name = 'Entity 3', maker = 'MT', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['rcbandito'] = { name = 'RC Bandito', maker = 'Rockstar', price = 1000000, trunk = 1000, glove = 15, type = 'rental', class = 'offroad', banned = false },
    ['kuruma'] = { name = 'Kuruma', maker = 'Karin', price = 375000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['sultan2'] = { name = 'Sultan 2', maker = 'Karin', price = 500000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['trophytruck2'] = { name = 'Trophytruck2', maker = 'Vapid', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['rhapsody'] = { name = 'Rhapsody', maker = 'Declasse', price = 10000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['vacca'] = { name = 'Vacca', maker = 'Pegassi', price = 350000, trunk = 30, glove = 15, type = 'car', class = 'super', banned = false },
    ['pounder'] = { name = 'Pounder', maker = 'MTL', price = 1000000, trunk = 5000, glove = 15, type = 'car', class = 'commercial', banned = false },
    ['massacro'] = { name = 'Massacro', maker = 'Dewbauchee', price = 330000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['dominator7'] = { name = 'Dominator7', maker = 'Vapid', price = 355000, trunk = 30, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['moonbeam'] = { name = 'Moonbeam', maker = 'Declasse', price = 220000, trunk = 80, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['bfinjection'] = { name = 'Bfinjection', maker = 'Bf', price = 80000, trunk = 100, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['entity2'] = { name = 'Entity2', maker = 'överflöd', price = 550000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['deviant'] = { name = 'Deviant', maker = 'Schyster', price = 370000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['pounder2'] = { name = 'Pounder2', maker = 'MTL', price = 1000000, trunk = 1200, glove = 15, type = 'car', class = 'commercial', banned = false },
    ['weevil'] = { name = 'weevil', maker = 'BF', price = 110000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['granger'] = { name = 'Granger', maker = 'Declasse', price = 345000, trunk = 100, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['buffalo'] = { name = 'Buffalo', maker = 'Bravado', price = 300000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['gresley'] = { name = 'Gresley', maker = 'Bravado', price = 150000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['penetrator'] = { name = 'Penetrator', maker = 'Ocelot', price = 480000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['faction3'] = { name = 'Faction3', maker = 'Willard', price = 350000, trunk = 60, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['limo2'] = { name = 'limo2', maker = 'Benefactor', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['vstr'] = { name = 'vstr', maker = 'Albany', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['dominator3'] = { name = 'Dominator3', maker = 'Vapid', price = 305000, trunk = 30, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['penumbra'] = { name = 'Penumbra', maker = 'Maibatsu', price = 150000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['blade'] = { name = 'Blade', maker = 'Vapid', price = 110000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['raiden'] = { name = 'Raiden', maker = 'Coil', price = 240000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['baller3'] = { name = 'Baller3', maker = 'Gallivanter', price = 175000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['monster4'] = { name = 'Monster', maker = 'Bravado', price = 1000000, trunk = 0, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['hotring'] = { name = 'Hotring', maker = 'Declasse', price = 300000, trunk = 60, glove = 15, type = 'car', class = 'sports', banned = false },
    ['seminole'] = { name = 'Seminole', maker = 'Canis', price = 110000, trunk = 60, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['btype3'] = { name = 'Btype3', maker = 'Albany', price = 100000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['tulip'] = { name = 'Tulip', maker = 'Declasse', price = 200000, trunk = 60, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['windsor2'] = { name = 'Windsor2', maker = 'Enus', price = 200000, trunk = 40, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['sugoi'] = { name = 'sugoi', maker = 'Dinka', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['kanjo'] = { name = 'Kanjo', maker = 'Dinka', price = 110000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['italigtb'] = { name = 'Italigtb', maker = 'Progen', price = 600000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['comet2'] = { name = 'Comet2', maker = 'Pfister', price = 250000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['emperor2'] = { name = 'Emperor 2', maker = 'Albany', price = 50000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['krieger'] = { name = 'krieger', maker = 'Benefactor', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['dubsta2'] = { name = 'Dubsta2', maker = 'Benefactor', price = 240000, trunk = 70, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['glendale'] = { name = 'Glendale', maker = 'Benefactor', price = 70000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['autarch'] = { name = 'Autarch', maker = 'överflöd', price = 760000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['ingot'] = { name = 'Ingot', maker = 'Vulcar', price = 160000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['sentinel3'] = { name = 'Sentinel3', maker = 'Übermacht', price = 70000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['furoregt'] = { name = 'Furoregt', maker = 'Lampadati', price = 290000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['tyrant'] = { name = 'Tyrant', maker = 'överflöd', price = 650000, trunk = 30, glove = 15, type = 'car', class = 'super', banned = false },
    ['burrito3'] = { name = 'Burrito3', maker = 'Declasse', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['riata'] = { name = 'Riata', maker = 'Vapid', price = 250000, trunk = 80, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['imorgon'] = { name = 'imorgon', maker = 'Överflöd', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['adder'] = { name = 'Adder', maker = 'Truffade', price = 620000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['zion2'] = { name = 'Zion2', maker = 'Übermacht', price = 60000, trunk = 40, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['rapidgt2'] = { name = 'Rapidgt2', maker = 'Dewbauchee', price = 300000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['schafter4'] = { name = 'Schafter4', maker = 'Benefactor', price = 125000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['rumpo2'] = { name = 'Rumpo2', maker = 'Bravado', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = true },
    ['paragon'] = { name = 'paragon', maker = 'Enus', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['comet5'] = { name = 'Comet5', maker = 'Pfister', price = 300000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['cavalcade2'] = { name = 'Cavalcade2', maker = 'Albany', price = 130000, trunk = 60, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['zion'] = { name = 'Zion', maker = 'Übermacht', price = 50000, trunk = 50, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['gauntlet3'] = { name = 'Gauntlet3', maker = 'Bravado', price = 195000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['dloader'] = { name = 'Dloader', maker = 'Bravado', price = 150000, trunk = 80, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['windsor'] = { name = 'Windsor', maker = 'Enus', price = 150000, trunk = 20, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['pigalle'] = { name = 'Pigalle', maker = 'Lampadati', price = 250000, trunk = 60, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['bullet'] = { name = 'Bullet', maker = 'Vapid', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['asea'] = { name = 'Asea', maker = 'Declasse', price = 55000, trunk = 30, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['brawler'] = { name = 'Brawler', maker = 'Coil', price = 250000, trunk = 50, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['tailgater'] = { name = 'Tailgater', maker = 'Obey', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['rebla'] = { name = 'Rebla', maker = 'Übermacht', price = 500000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['voodoo2'] = { name = 'Voodoo2', maker = 'Declasse', price = 220000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['massacro2'] = { name = 'Massacro2', maker = 'Dewbauchee', price = 330000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['rapidgt'] = { name = 'Rapidgt', maker = 'Dewbauchee', price = 250000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['dubsta'] = { name = 'Dubsta', maker = 'Benefactor', price = 210000, trunk = 70, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['deveste'] = { name = 'Deveste', maker = 'Principe', price = 1000000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['fagaloa'] = { name = 'Fagaloa', maker = 'Vulcar', price = 320000, trunk = 80, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['dynasty'] = { name = 'Dynasty', maker = 'Weeny', price = 250000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['banshee'] = { name = 'Banshee', maker = 'Bravado', price = 300000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['habanero'] = { name = 'Habanero', maker = 'Emperor', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['futo2'] = { name = 'futo2', maker = 'Karin', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['radi'] = { name = 'Radi', maker = 'Vapid', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['blista3'] = { name = 'Blista3', maker = 'Dinka', price = 80000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['tampa'] = { name = 'Tampa', maker = 'Declasse', price = 170000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['oracle2'] = { name = 'Oracle2', maker = 'Ubermacht', price = 80000, trunk = 60, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['jester3'] = { name = 'Jester3', maker = 'Dinka', price = 345000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['bodhi2'] = { name = 'Bodhi2', maker = 'Canis', price = 170000, trunk = 90, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['exemplar'] = { name = 'Exemplar', maker = 'Dewbauchee', price = 80000, trunk = 20, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['schlagen'] = { name = 'Schlagen', maker = 'Benefactor', price = 690000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['nero2'] = { name = 'Nero2', maker = 'Truffade', price = 480000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['jester4'] = { name = 'Jester4', maker = 'Dinka', price = 645000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['ellie'] = { name = 'Ellie', maker = 'Vapid', price = 320000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['blista'] = { name = 'Blista', maker = 'Dinka', price = 17500, trunk = 40, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['toreador'] = { name = 'toreador', maker = 'Pegassi', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['rapidgt3'] = { name = 'Rapidgt3', maker = 'Dewbauchee', price = 200000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['impaler'] = { name = 'Impaler', maker = 'Declasse', price = 320000, trunk = 60, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['sultan'] = { name = 'Sultan', maker = 'Karin', price = 210000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['sc1'] = { name = 'Sc1', maker = 'Übermacht', price = 495000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['ruston'] = { name = 'Ruston', maker = 'Hijak', price = 370000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['lynx'] = { name = 'Lynx', maker = 'Ocelot', price = 370000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['bjxl'] = { name = 'Bjxl', maker = 'Karin', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['sentinel2'] = { name = 'Sentinel2', maker = 'Übermacht', price = 60000, trunk = 40, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['bestiagts'] = { name = 'Bestiagts', maker = 'Grotti', price = 500000, trunk = 60, glove = 15, type = 'car', class = 'sports', banned = false },
    ['moonbeam2'] = { name = 'Moonbeam2', maker = 'Declasse', price = 250000, trunk = 70, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['tropos'] = { name = 'Tropos', maker = 'Lampadati', price = 170000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['previon'] = { name = 'Previon', maker = 'Karin', price = 145000, trunk = 30, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['retinue'] = { name = 'Retinue', maker = 'Vapid', price = 150000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['stratum'] = { name = 'Stratum', maker = 'Zirconium', price = 90000, trunk = 70, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['gauntlet4'] = { name = 'Gauntlet4', maker = 'Bravado', price = 215000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['baller'] = { name = 'Baller', maker = 'Gallivanter', price = 150000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['khamelion'] = { name = 'Khamelion', maker = 'Hijak', price = 210000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['nebula'] = { name = 'Nebula', maker = 'Vulcar', price = 180000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['btype2'] = { name = 'Btype2', maker = 'Albany', price = 460000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['phoenix'] = { name = 'Phoenix', maker = 'Imponte', price = 250000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['pony'] = { name = 'Pony', maker = 'Brute', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['stalion2'] = { name = 'Stalion2', maker = 'Declasse', price = 150000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['schwarzer'] = { name = 'Schwarzer', maker = 'Benefactor', price = 170000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['jugular'] = { name = 'Jugular', maker = 'Ocelot', price = 720000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['comet3'] = { name = 'Comet3', maker = 'Pfister', price = 290000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['club2'] = { name = 'Club2', maker = 'Bf', price = 60000, trunk = 25, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['novak'] = { name = 'Novak', maker = 'Lampadati', price = 490000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['virgo2'] = { name = 'Virgo2', maker = 'Dundreary', price = 250000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['vagner'] = { name = 'Vagner', maker = 'Dewbauchee', price = 350000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['baller6'] = { name = 'Baller6', maker = 'Gallivanter', price = 280000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['oracle'] = { name = 'Oracle', maker = 'Ubermacht', price = 60000, trunk = 50, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['virtue'] = { name = 'virtue', maker = 'Ocelot', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Super', banned = false },
    ['hotknife'] = { name = 'Hotknife', maker = 'Vapid', price = 180000, trunk = 30, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['brioso'] = { name = 'Brioso', maker = 'Grotti', price = 25000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['alpha'] = { name = 'Alpha', maker = 'Albany', price = 230000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['minivan'] = { name = 'Minivan', maker = 'Vapid', price = 110000, trunk = 70, glove = 15, type = 'car', class = 'vans', banned = false },
    ['surfer'] = { name = 'Surfer', maker = 'Bf', price = 150000, trunk = 80, glove = 15, type = 'car', class = 'vans', banned = false },
    ['brutus'] = { name = 'brutus', maker = 'Declasse', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['stinger'] = { name = 'Stinger', maker = 'Grotti', price = 220000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['sultan3'] = { name = 'sultan3', maker = 'Karin', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['prototipo'] = { name = 'Prototipo', maker = 'Grotti', price = 1000000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['gauntlet'] = { name = 'Gauntlet', maker = 'Bravado', price = 165000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['f620'] = { name = 'F620', maker = 'Ocelot', price = 55000, trunk = 30, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['intruder'] = { name = 'Intruder', maker = 'Karin', price = 60000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['chino'] = { name = 'Chino', maker = 'Vapid', price = 100000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['cyclone'] = { name = 'Cyclone', maker = 'Coil', price = 920000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['huntley'] = { name = 'Huntley', maker = 'Enus', price = 110000, trunk = 60, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['pony2'] = { name = 'Pony2', maker = 'Brute', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['pbus2'] = { name = 'Ônibus Festival', maker = 'Vapid', price = 1000000, trunk = 0, glove = 15, type = 'car', class = 'service', banned = false },
    ['lurcher'] = { name = 'Lurcher', maker = 'Albany', price = 150000, trunk = 60, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['flashgt'] = { name = 'Flashgt', maker = 'Vapid', price = 370000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['jb700'] = { name = 'Jb700', maker = 'Dewbauchee', price = 220000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['italigto'] = { name = 'Italigto', maker = 'Grotti', price = 800000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['futo'] = { name = 'Futo', maker = 'Karin', price = 170000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['infernus2'] = { name = 'Infernus2', maker = 'Pegassi', price = 450000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['fusilade'] = { name = 'Fusilade', maker = 'Schyster', price = 210000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['sabregt2'] = { name = 'Sabregt2', maker = 'Declasse', price = 150000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['baller2'] = { name = 'Baller2', maker = 'Gallivanter', price = 160000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['cavalcade'] = { name = 'Cavalcade', maker = 'Albany', price = 110000, trunk = 60, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['michelli'] = { name = 'Michelli', maker = 'Lampadati', price = 90000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['patriot2'] = { name = 'Patriot2', maker = 'Mammoth', price = 550000, trunk = 60, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['virgo3'] = { name = 'Virgo3', maker = 'Dundreary', price = 180000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['carbonizzare'] = { name = 'Carbonizzare', maker = 'Grotti', price = 290000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['cheburek'] = { name = 'Cheburek', maker = 'Rune', price = 170000, trunk = 50, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['everon'] = { name = 'Everon', maker = 'Karin', price = 700000, trunk = 100, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['cypher'] = { name = 'Cypher', maker = 'Übermacht', price = 980000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['gauntlet2'] = { name = 'Gauntlet2', maker = 'Bravado', price = 165000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['landstalker'] = { name = 'Landstalker', maker = 'Dundreary', price = 130000, trunk = 70, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['streiter'] = { name = 'Streiter', maker = 'Benefactor', price = 250000, trunk = 70, glove = 15, type = 'car', class = 'sports', banned = false },
    ['coquette3'] = { name = 'Coquette3', maker = 'Invetero', price = 195000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['stingergt'] = { name = 'Stingergt', maker = 'Grotti', price = 230000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['stalion'] = { name = 'Stalion', maker = 'Classique', price = 150000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['omnis'] = { name = 'Omnis', maker = 'Obey', price = 240000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['sentinel'] = { name = 'Sentinel', maker = 'Übermacht', price = 50000, trunk = 50, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['sultanrs'] = { name = 'Sultan RS', maker = 'Karin', price = 450000, trunk = 30, glove = 15, type = 'car', class = 'super', banned = false },
    ['kamacho'] = { name = 'Kamacho', maker = 'Canis', price = 350000, trunk = 90, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['cheetah2'] = { name = 'Cheetah2', maker = 'Grotti', price = 240000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['menacer'] = { name = 'menacer', maker = 'HVY', price = 700000, trunk = 30, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['deluxo'] = { name = 'deluxo', maker = 'Imponte', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['voodoo'] = { name = 'Voodoo', maker = 'Declasse', price = 220000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['elegy'] = { name = 'Elegy', maker = 'Annis', price = 350000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['speedo4'] = { name = 'speedo4', maker = 'Vapid', price = 220000, trunk = 100, glove = 15, type = 'car', class = 'vans', banned = false },
    ['youga3'] = { name = 'youga3', maker = 'Bravado', price = 220000, trunk = 100, glove = 15, type = 'car', class = 'vans', banned = false },
    ['vigilante'] = { name = 'vigilante', maker = 'Grotti', price = 400000, trunk = 0, glove = 15, type = 'car', class = 'super', banned = false },
    ['viseris'] = { name = 'viseris', maker = 'Lampadati', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['stromberg'] = { name = 'stromberg', maker = 'Ocelot', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['seminole2'] = { name = 'seminole2', maker = 'Canis', price = 400000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['burrito2'] = { name = 'Burrito2', maker = 'Declasse', price = 500000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['coquette4'] = { name = 'coquette4', maker = 'Invetero', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['yosemite'] = { name = 'Yosemite', maker = 'Declasse', price = 350000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['felon'] = { name = 'Felon', maker = 'Lampadati', price = 70000, trunk = 50, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['sheava'] = { name = 'Sheava', maker = 'Emperor', price = 700000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['turismor'] = { name = 'Turismor', maker = 'Grotti', price = 700000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['visione'] = { name = 'Visione', maker = 'Grotti', price = 650000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['virgo'] = { name = 'Virgo', maker = 'Albany', price = 150000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['panto'] = { name = 'Panto', maker = 'Benefactor', price = 5000, trunk = 20, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['rumpo'] = { name = 'Rumpo', maker = 'Bravado', price = 400000, trunk = 180, glove = 15, type = 'car', class = 'vans', banned = false },
    ['ruiner'] = { name = 'Ruiner', maker = 'Imponte', price = 150000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['coquette'] = { name = 'Coquette', maker = 'Invetero', price = 250000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['zr350'] = { name = 'zr350', maker = 'Annis', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['phantom3'] = { name = 'Phantom', maker = 'Jobuilt', price = 1000000, trunk = 0, glove = 15, type = 'car', class = 'commercial', banned = false },
    ['rallytruck'] = { name = 'RallyTruck', maker = 'MTL', price = 2000000, trunk = 500, glove = 15, type = 'car', class = 'service', banned = false },
    ['dukes'] = { name = 'Dukes', maker = 'Imponte', price = 150000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['picador'] = { name = 'Picador', maker = 'Cheval', price = 150000, trunk = 90, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['slamvan3'] = { name = 'Slamvan3', maker = 'Vapid', price = 230000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['mule2'] = { name = 'Mule2', maker = 'Maibatsu', price = 1000000, trunk = 400, glove = 15, type = 'car', class = 'commercial', banned = false },
    ['minivan2'] = { name = 'Minivan2', maker = 'Vapid', price = 220000, trunk = 60, glove = 15, type = 'car', class = 'vans', banned = false },
    ['growler'] = { name = 'growler', maker = 'Pfister', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['komoda'] = { name = 'komoda', maker = 'Lampadati', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['panthere'] = { name = 'panthere', maker = 'Toundra', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['paragon2'] = { name = 'paragon2', maker = 'Enus', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['casco'] = { name = 'Casco', maker = 'Lampadati', price = 355000, trunk = 50, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['patriot'] = { name = 'Patriot', maker = 'Mammoth', price = 250000, trunk = 70, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['mesa3'] = { name = 'Mesa3', maker = 'Canis', price = 200000, trunk = 60, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['yosemite3'] = { name = 'yosemite3', maker = 'Declasse', price = 400000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['scramjet'] = { name = 'scramjet', maker = 'Declasse', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Super', banned = false },
    ['nightshade'] = { name = 'Nightshade', maker = 'Imponte', price = 270000, trunk = 30, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['formula2'] = { name = 'formula2', maker = 'Ocelot', price = 400000, trunk = 0, glove = 0, type = 'car', class = 'Sports', banned = false },
    ['vapidlow'] = { name = 'vapidlow', maker = 'Vapid', price = 1000000, trunk = 0, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['veto2'] = { name = 'Veto 2', maker = 'Dinka', price = 200000, trunk = 4, glove = 15, type = 'car', class = 'sports', banned = false },
    ['rumpo3'] = { name = 'Rumpo3', maker = 'Bravado', price = 350000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['verus'] = { name = 'Verus', maker = 'Dinka', price = 200000, trunk = 4, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['pfister811'] = { name = 'Pfister811', maker = 'Pfister', price = 530000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['feltzer3'] = { name = 'Feltzer3', maker = 'Benefactor', price = 300000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['buccaneer'] = { name = 'Buccaneer', maker = 'Albany', price = 130000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['hermes'] = { name = 'Hermes', maker = 'Albany', price = 280000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['guardian'] = { name = 'Guardian', maker = 'Vapid', price = 500000, trunk = 150, glove = 15, type = 'car', class = 'industrial', banned = false },
    ['dubsta3'] = { name = 'Dubsta3', maker = 'Benefactor', price = 300000, trunk = 90, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['clique'] = { name = 'Clique', maker = 'Vapid', price = 360000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['reaper'] = { name = 'Reaper', maker = 'Pegassi', price = 620000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['buccaneer2'] = { name = 'Buccaneer2', maker = 'Albany', price = 250000, trunk = 60, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['zorrusso'] = { name = 'zorrusso', maker = 'Pegassi', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['fmj'] = { name = 'Fmj', maker = 'Vapid', price = 520000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['buffalo2'] = { name = 'Buffalo2', maker = 'Bravado', price = 300000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['z190'] = { name = 'Z190', maker = 'Karin', price = 350000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['schafter3'] = { name = 'Schafter3', maker = 'Benefactor', price = 275000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['jester'] = { name = 'Jester', maker = 'Dinka', price = 450000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['sandking'] = { name = 'Sandking', maker = 'Vapid', price = 300000, trunk = 120, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['premier'] = { name = 'Premier', maker = 'Declasse', price = 35000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['washington'] = { name = 'Washington', maker = 'Albany', price = 130000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['cognoscenti'] = { name = 'Cognoscenti', maker = 'Enus', price = 280000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['contender'] = { name = 'Contender', maker = 'Vapid', price = 500000, trunk = 80, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['torero'] = { name = 'Torero', maker = 'Pegassi', price = 160000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['t20'] = { name = 'T20', maker = 'Progen', price = 670000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['cogcabrio'] = { name = 'Cogcabrio', maker = 'Enus', price = 130000, trunk = 60, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['openwheel1'] = { name = 'openwheel1', maker = 'Benefactor', price = 400000, trunk = 0, glove = 0, type = 'car', class = 'Sports', banned = false },
    ['formula'] = { name = 'formula', maker = 'Progen Dinka', price = 400000, trunk = 0, glove = 0, type = 'car', class = 'Sports', banned = false },
    ['neo'] = { name = 'neo', maker = 'Vysser', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['tailgater2'] = { name = 'tailgater2', maker = 'Obey', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['mamba'] = { name = 'Mamba', maker = 'Declasse', price = 300000, trunk = 50, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['italigtb2'] = { name = 'Italigtb2', maker = 'Progen', price = 610000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['gp1'] = { name = 'Gp1', maker = 'Progen', price = 495000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['cog552'] = { name = 'Cog552', maker = 'Enus', price = 400000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['fugitive'] = { name = 'Fugitive', maker = 'Cheval', price = 50000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['primo'] = { name = 'Primo', maker = 'Albany', price = 130000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['infernus'] = { name = 'Infernus', maker = 'Pegassi', price = 470000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['bobcatxl'] = { name = 'Bobcatxl', maker = 'Vapid', price = 260000, trunk = 100, glove = 15, type = 'car', class = 'vans', banned = false },
    ['bison'] = { name = 'Bison', maker = 'Bravado', price = 220000, trunk = 70, glove = 15, type = 'car', class = 'vans', banned = false },
    ['everon2'] = { name = 'everon2', maker = 'Karin', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['banshee2'] = { name = 'Banshee2', maker = 'Bravado', price = 370000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['emperor'] = { name = 'Emperor', maker = 'Albany', price = 50000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['verlierer2'] = { name = 'Verlierer2', maker = 'Bravado', price = 380000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['monroe'] = { name = 'Monroe', maker = 'Pegassi', price = 260000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['sadler'] = { name = 'Sadler', maker = 'Vapid', price = 180000, trunk = 70, glove = 15, type = 'car', class = 'utility', banned = false },
    ['ninef'] = { name = 'Ninef', maker = 'Obey', price = 290000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['sabregt'] = { name = 'Sabregt', maker = 'Declasse', price = 260000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['raptor'] = { name = 'Raptor', maker = 'Bf', price = 300000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['kuruma2'] = { name = 'Kuruma Blindado', maker = 'Karin', price = 1000000, trunk = 90, glove = 15, type = 'car', class = 'sports', banned = false },
    ['xls'] = { name = 'Xls', maker = 'Benefactor', price = 300000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['dominator'] = { name = 'Dominator', maker = 'Vapid', price = 250000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['prairie'] = { name = 'Prairie', maker = 'Bollokan', price = 1000, trunk = 25, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['mule3'] = { name = 'Mule3', maker = 'Maibatsu', price = 1500000, trunk = 700, glove = 15, type = 'car', class = 'commercial', banned = false },
    ['vigero'] = { name = 'Vigero', maker = 'Declasse', price = 170000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['cognoscenti2'] = { name = 'Cognoscenti2', maker = 'Enus', price = 400000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['brioso2'] = { name = 'Brioso2', maker = 'Grotti', price = 25000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['rocoto'] = { name = 'Rocoto', maker = 'Obey', price = 110000, trunk = 60, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['osiris'] = { name = 'Osiris', maker = 'Pegassi', price = 460000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['surano'] = { name = 'Surano', maker = 'Benefactor', price = 310000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['zentorno'] = { name = 'Zentorno', maker = 'Pegassi', price = 920000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['schafter5'] = { name = 'Schafter5', maker = 'Benefactor', price = 275000, trunk = 50, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['youga'] = { name = 'Youga', maker = 'Bravado', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },    
    ['tempesta'] = { name = 'Tempesta', maker = 'Pegassi', price = 600000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['peyote'] = { name = 'Peyote', maker = 'Vapid', price = 150000, trunk = 50, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['faction'] = { name = 'Faction', maker = 'Willard', price = 150000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['gauntlet5'] = { name = 'Gauntlet5', maker = 'Bravado', price = 245000, trunk = 40, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['ztype'] = { name = 'Ztype', maker = 'Truffade', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['italirsx'] = { name = 'italirsx', maker = 'Grotti', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['pariah'] = { name = 'Pariah', maker = 'Ocelot', price = 500000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['xls2'] = { name = 'Xls2', maker = 'Benefactor', price = 350000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['blista2'] = { name = 'Blista2', maker = 'Dinka', price = 100000, trunk = 40, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['trophytruck'] = { name = 'Trophytruck', maker = 'Vapid', price = 1000000, trunk = 20, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['dilettante'] = { name = 'Dilettante', maker = 'Karin', price = 60000, trunk = 30, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['vectre'] = { name = 'vectre', maker = 'Emperor', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['outlaw'] = { name = 'Outlaw', maker = 'Nagasaki', price = 500000, trunk = 40, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['nightshark'] = { name = 'nightshark', maker = 'HVY', price = 700000, trunk = 30, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['le7b'] = { name = 'Le7b', maker = 'Annis', price = 700000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['swinger'] = { name = 'Swinger', maker = 'Ocelot', price = 250000, trunk = 20, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['gb200'] = { name = 'Gb200', maker = 'Vapid', price = 195000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['tigon'] = { name = 'tigon', maker = 'Lampadati', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['warrener'] = { name = 'Warrener', maker = 'Vulcar', price = 90000, trunk = 40, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['tampa2'] = { name = 'Tampa2', maker = 'Declasse', price = 200000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['slamvan'] = { name = 'Slamvan', maker = 'Vapid', price = 180000, trunk = 100, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['buffalo3'] = { name = 'Buffalo3', maker = 'Bravado', price = 300000, trunk = 50, glove = 15, type = 'car', class = 'sports', banned = false },
    ['surge'] = { name = 'Surge', maker = 'Cheval', price = 110000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['entityxf'] = { name = 'Entityxf', maker = 'överflöd', price = 460000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['burrito'] = { name = 'Burrito', maker = 'Declasse', price = 500000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['dominator2'] = { name = 'Dominator2', maker = 'Vapid', price = 230000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['sanctus'] = { name = 'Sanctus', maker = 'Liberty city cycles', price = 1000000, trunk = 20, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['baller4'] = { name = 'Baller4', maker = 'Gallivanter', price = 185000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['bifta'] = { name = 'Bifta', maker = 'Bf', price = 190000, trunk = 20, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['cheetah'] = { name = 'Cheetah', maker = 'Grotti', price = 425000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['baller5'] = { name = 'Baller5', maker = 'Gallivanter', price = 270000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['tornado2'] = { name = 'Tornado2', maker = 'Declasse', price = 160000, trunk = 60, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['comet6'] = { name = 'Comet6', maker = 'Pfister', price = 350000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['tornado'] = { name = 'Tornado', maker = 'Declasse', price = 150000, trunk = 70, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['burrito4'] = { name = 'Burrito4', maker = 'Declasse', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['caracara2'] = { name = 'Caracara2', maker = 'Vapid', price = 670000, trunk = 100, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['voltic'] = { name = 'Voltic', maker = 'Coil', price = 300000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['gt500'] = { name = 'Gt500', maker = 'Grotti', price = 250000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['turismo2'] = { name = 'Turismo2', maker = 'Grotti', price = 250000, trunk = 30, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['sandking2'] = { name = 'Sandking2', maker = 'Vapid', price = 350000, trunk = 120, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['ninef2'] = { name = 'Ninef2', maker = 'Obey', price = 290000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['coquette2'] = { name = 'Coquette2', maker = 'Invetero', price = 285000, trunk = 40, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['rancherxl'] = { name = 'Rancherxl', maker = 'Declasse', price = 220000, trunk = 70, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['feltzer2'] = { name = 'Feltzer2', maker = 'Benefactor', price = 255000, trunk = 40, glove = 15, type = 'car', class = 'sports', banned = false },
    ['issi2'] = { name = 'Issi2', maker = 'Weeny', price = 75000, trunk = 20, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['tampa3'] = { name = 'tampa3', maker = 'Declasse', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['openwheel2'] = { name = 'openwheel2', maker = 'Declasse Dinka', price = 400000, trunk = 0, glove = 0, type = 'car', class = 'Sports', banned = false },
    ['rt3000'] = { name = 'rt3000', maker = 'Dinka', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['euros'] = { name = 'euros', maker = 'Annis', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['utillitruck3'] = { name = 'Utillitruck3', maker = 'Vapid', price = 180000, trunk = 120, glove = 15, type = 'car', class = 'utility', banned = true },
    ['seven70'] = { name = 'Seven70', maker = 'Dewbauchee', price = 370000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['nero'] = { name = 'Nero', maker = 'Truffade', price = 450000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['tornado6'] = { name = 'Tornado6', maker = 'Declasse', price = 250000, trunk = 50, glove = 15, type = 'car', class = 'sportsclassics', banned = false },
    ['taipan'] = { name = 'Taipan', maker = 'Cheval', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['mesa'] = { name = 'Mesa', maker = 'Canis', price = 90000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['specter2'] = { name = 'Specter2', maker = 'Dewbauchee', price = 355000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['xa21'] = { name = 'Xa21', maker = 'Ocelot', price = 500000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['issi3'] = { name = 'Issi3', maker = 'Weeny', price = 190000, trunk = 20, glove = 15, type = 'car', class = 'compacts', banned = false },
    ['stretch'] = { name = 'Stretch', maker = 'Dundreary', price = 1000000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['vamos'] = { name = 'Vamos', maker = 'Declasse', price = 185000, trunk = 60, glove = 15, type = 'car', class = 'muscle', banned = false },
    ['benson'] = { name = 'Benson', maker = 'Vapid', price = 1000000, trunk = 1000, glove = 15, type = 'car', class = 'commercial', banned = false },
    ['neon'] = { name = 'Neon', maker = 'Pfister', price = 370000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['freecrawler'] = { name = 'Freecrawler', maker = 'Canis', price = 350000, trunk = 50, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['rentalbus'] = { name = 'Ônibus Escolinha', maker = 'Brute', price = 0, trunk = 100, glove = 15, type = 'car', class = 'service', banned = false },
    ['tezeract'] = { name = 'Tezeract', maker = 'Pegassi', price = 920000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ['fq2'] = { name = 'Fq2', maker = 'Fathom', price = 110000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['rebel2'] = { name = 'Rebel2', maker = 'Karin', price = 250000, trunk = 100, glove = 15, type = 'car', class = 'offroad', banned = false },
    ['specter'] = { name = 'Specter', maker = 'Dewbauchee', price = 320000, trunk = 20, glove = 15, type = 'car', class = 'sports', banned = false },
    ['asterope'] = { name = 'Asterope', maker = 'Karin', price = 65000, trunk = 30, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['landstalker2'] = { name = 'Landstalker2', maker = 'Dundreary', price = 450000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['toros'] = { name = 'Toros', maker = 'Pegassi', price = 350000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['calico'] = { name = 'calico', maker = 'Karin', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['serrano'] = { name = 'Serrano', maker = 'Benefactor', price = 150000, trunk = 50, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['paradise'] = { name = 'Paradise', maker = 'Bravado', price = 260000, trunk = 120, glove = 15, type = 'car', class = 'vans', banned = false },
    ['penumbra2'] = { name = 'penumbra2', maker = 'Maibatsu', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'Sports', banned = false },
    ['jackal'] = { name = 'Jackal', maker = 'Ocelot', price = 60000, trunk = 50, glove = 15, type = 'car', class = 'coupes', banned = false },
    ['elegy2'] = { name = 'Elegy2', maker = 'Annis', price = 355000, trunk = 30, glove = 15, type = 'car', class = 'sports', banned = false },
    ['squaddie'] = { name = 'squaddie', maker = 'Mammoth', price = 400000, trunk = 30, glove = 15, type = 'car', class = 'suvs', banned = false },
    ['stanier'] = { name = 'Stanier', maker = 'Vapid', price = 15000, trunk = 60, glove = 15, type = 'car', class = 'sedans', banned = false },
    ['tyrus'] = { name = 'Tyrus', maker = 'Progen', price = 400000, trunk = 20, glove = 15, type = 'car', class = 'super', banned = false },
    ------------------------------------------------------------------------------------------------------------------------
    -- MOTOS
    ------------------------------------------------------------------------------------------------------------------------
    ['shotaro'] = { name = 'Shotaro', maker = 'Nagasaki', price = 1000000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['cliffhanger'] = { name = 'Cliffhanger', maker = 'WMC', price = 310000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['bati'] = { name = 'Bati', maker = 'Pegassi', price = 370000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['double'] = { name = 'Double', maker = 'Dinka', price = 350000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['innovation'] = { name = 'Innovation', maker = 'Liberty city cycles', price = 250000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['bati2'] = { name = 'Bati2', maker = 'Pegassi', price = 300000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['ruffian'] = { name = 'Ruffian', maker = 'Pegassi', price = 345000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['carbonrs'] = { name = 'Carbonrs', maker = 'Nagasaki', price = 370000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['vindicator'] = { name = 'Vindicator', maker = 'Dinka', price = 340000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['avarus'] = { name = 'Avarus', maker = 'Liberty city cycles', price = 200000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['blazer4'] = { name = 'Blazer4', maker = 'Nagasaki', price = 370000, trunk = 20, glove = 15, type = 'motocycle', class = 'offroad', banned = true },
    ['oppressor'] = { name = 'oppressor', maker = 'Pegassi', price = 300000, trunk = 0, glove = 0, type = 'motocycle', class = 'motocycle', banned = false },
    ['akuma'] = { name = 'Akuma', maker = 'Dinka', price = 850000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['oppressor2'] = { name = 'oppressor2', maker = 'Pegassi', price = 300000, trunk = 0, glove = 0, type = 'motocycle', class = 'motocycle', banned = false },
    ['blazer'] = { name = 'Blazer', maker = 'Nagasaki', price = 230000, trunk = 20, glove = 15, type = 'motocycle', class = 'offroad', banned = true },
    ['bagger'] = { name = 'Bagger', maker = 'WMC', price = 300000, trunk = 40, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['daemon2'] = { name = 'Daemon2', maker = 'WMC', price = 150000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['powersurge'] = { name = 'powersurge', maker = 'WMC', price = 300000, trunk = 15, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['vader'] = { name = 'Vader', maker = 'Shitzu', price = 220000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['esskey'] = { name = 'Esskey', maker = 'Pegassi', price = 50000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['defiler'] = { name = 'Defiler', maker = 'Shitzu', price = 460000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['diablous'] = { name = 'Diablous', maker = 'WMC', price = 430000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['sanchez2'] = { name = 'Sanchez2', maker = 'Maibatsu', price = 125000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['wolfsbane'] = { name = 'Wolfsbane', maker = 'WMC', price = 290000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['lectro'] = { name = 'Lectro', maker = 'Principe', price = 380000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['faggio3'] = { name = 'Faggio3', maker = 'Pegassi', price = 7500, trunk = 30, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['manchez3'] = { name = 'manchez3', maker = 'Maibatsu', price = 300000, trunk = 15, glove = 0, type = 'motocycle', class = 'motocycle', banned = false },
    ['manchez2'] = { name = 'manchez2', maker = 'Maibatsu', price = 300000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['sovereign'] = { name = 'Sovereign', maker = 'WMC', price = 285000, trunk = 50, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['hexer'] = { name = 'Hexer', maker = 'Liberty city cycles', price = 250000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['enduro'] = { name = 'Enduro', maker = 'Dinka', price = 50000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['diablous2'] = { name = 'Diablous2', maker = 'WMC', price = 460000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['rrocket'] = { name = 'rrocket', maker = 'WMC', price = 300000, trunk = 0, glove = 0, type = 'motocycle', class = 'motocycle', banned = false },
    ['nemesis'] = { name = 'Nemesis', maker = 'Principe', price = 345000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['manchez'] = { name = 'Manchez', maker = 'Maibatsu', price = 355000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['fcr'] = { name = 'Fcr', maker = 'Pegassi', price = 390000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['hakuchou'] = { name = 'Hakuchou', maker = 'Shitzu', price = 380000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['bf400'] = { name = 'Bf400', maker = 'Nagasaki', price = 150000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['faggio'] = { name = 'Faggio', maker = 'Pegassi', price = 5000, trunk = 30, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['faggio2'] = { name = 'Faggio2', maker = 'Pegassi', price = 5000, trunk = 30, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['thrust'] = { name = 'Thrust', maker = 'Dinka', price = 375000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['chimera'] = { name = 'Chimera', maker = 'Nagasaki', price = 345000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['ratbike'] = { name = 'Ratbike', maker = 'WMC', price = 230000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['gargoyle'] = { name = 'Gargoyle', maker = 'WMC', price = 345000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['zombieb'] = { name = 'Zombieb', maker = 'Steel horse', price = 300000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['stryder'] = { name = 'stryder', maker = 'Nagasaki', price = 300000, trunk = 15, glove = 0, type = 'motocycle', class = 'motocycle', banned = false },
    ['zombiea'] = { name = 'Zombiea', maker = 'WMC', price = 290000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['hakuchou2'] = { name = 'Hakuchou2', maker = 'Shitzu', price = 550000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['fcr2'] = { name = 'Fcr2', maker = 'Pegassi', price = 390000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['pcj'] = { name = 'Pcj', maker = 'Shitzu', price = 50000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['nightblade'] = { name = 'Nightblade', maker = 'Liberty chop shop', price = 350000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['sanchez'] = { name = 'Sanchez', maker = 'Maibatsu', price = 185000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['vortex'] = { name = 'Vortex', maker = 'Pegassi', price = 375000, trunk = 20, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ['deathbike2'] = { name = 'Death Bike', maker = 'WMC', price = 1000000, trunk = 0, glove = 15, type = 'motocycle', class = 'motocycle', banned = false },
    ------------------------------------------------------------------------------------------------------------------------
    -- PLANES
    ------------------------------------------------------------------------------------------------------------------------
    ['maverick'] = { name = 'Maverick', maker = 'Western company', price = 100000, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopter', banned = true },
    ['swift2'] = { name = 'Swift 2', maker = 'Buckingham', price = 0, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopter', banned = false },
    ['swift'] = { name = 'Swift', maker = 'Buckingham', price = 0, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopter', banned = false },
    ['frogger'] = { name = 'Frogger', maker = 'Maibatsu', price = 1000000, trunk = 0, glove = 15, type = 'helicopter', class = 'helicopters', banned = true },
    ['supervolito'] = { name = 'Supervolito', maker = 'Buckingham', price = 1000, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopters', banned = false },
    ['cargobob'] = { name = 'CSC Cargobob', maker = 'Western company', price = 1000000, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopters', banned = false },
    ['buzzard2'] = { name = 'Buzzard 2', maker = 'Nagasaki', price = 1000000, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopters', banned = false },
    ['cargobob2'] = { name = 'Cargo Bob', maker = 'Western company', price = 1000000, trunk = 1000, glove = 15, type = 'helicopter', class = 'helicopters', banned = false },
    ------------------------------------------------------------------------------------------------------------------------
    -- WORK
------------------------------------------------------------------------------------------------------------------------
    ['flatbed3'] = { name = 'Flatbed 3', maker = 'Zero', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'commercial', banned = true },
    ['raptor150'] = { name = 'Raptor', maker = 'Ford', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'commercial', banned = true },
    ['avisa'] = { name = 'avisa', maker = 'Kraken', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['toro'] = { name = 'Toro', maker = 'Lampadati', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['jetmax'] = { name = 'Jetmax', maker = 'Grotti', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['vestra'] = { name = 'Vestra', maker = 'Buckingham', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'planes', banned = true },
    ['cog55'] = { name = 'Cog55', maker = 'Enus', price = 200000, trunk = 50, glove = 15, type = 'work', class = 'sedans', banned = false },
    ['youga2'] = { name = 'Youga2', maker = 'Bravado', price = 1000, trunk = 80, glove = 15, type = 'work', class = 'vans', banned = false },
    ['coach'] = { name = 'Coach', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'service', banned = true },
    ['riot'] = { name = 'Blindado', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['mule'] = { name = 'Mule', maker = 'Maibatsu', price = 500000, trunk = 0, glove = 15, type = 'work', class = 'commercial', banned = true },
    ['flatbed'] = { name = 'Reboque', maker = 'MTL', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'industrial', banned = true },
    ['superd'] = { name = 'Superd', maker = 'Enus', price = 200000, trunk = 50, glove = 15, type = 'work', class = 'sedans', banned = false },
    ['ratloader'] = { name = 'Caminhão', maker = 'Bravado', price = 80000, trunk = 80, glove = 15, type = 'work', class = 'muscle', banned = true },
    ['towtruck2'] = { name = 'Towtruck2', maker = 'Vapid', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['daemon'] = { name = 'Daemon', maker = 'WMC', price = 75000, trunk = 20, glove = 15, type = 'work', class = 'motocycle', banned = false },
    ['miljet'] = { name = 'Miljet', maker = 'Western company', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'planes', banned = true },
    ['bmx'] = { name = 'Bmx', maker = 'Bmx', price = 1, trunk = 0, glove = 15, type = 'work', class = 'cycles', banned = true },
    ['ambulance'] = { name = 'Ambulância', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['primo2'] = { name = 'Primo2', maker = 'Albany', price = 100000, trunk = 60, glove = 15, type = 'work', class = 'sedans', banned = false },
    ['boxville'] = { name = 'BoxVille', maker = 'Brute', price = 1000, trunk = 70, glove = 15, type = 'work', class = 'vans', banned = true },
    ['ratloader2'] = { name = 'Ratloader2', maker = 'Bravado', price = 1000, trunk = 70, glove = 15, type = 'work', class = 'muscle', banned = false },
    ['felon2'] = { name = 'Felon2', maker = 'Lampadati', price = 1000, trunk = 40, glove = 15, type = 'work', class = 'coupes', banned = false },
    ['tribike3'] = { name = 'Tribike3', maker = 'Bmx', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'cycles', banned = true },
    ['phantom'] = { name = 'Phantom', maker = 'Jobuilt', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'commercial', banned = true },
    ['cruiser'] = { name = 'Cruiser', maker = 'Bmx', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'cycles', banned = true },
    ['polmav'] = { name = 'Polmav', maker = 'Buckingham', price = 0, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['speeder'] = { name = 'Speeder', maker = 'Pegassi', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['supervolito2'] = { name = 'Supervolito2', maker = 'Buckingham', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'helicopters', banned = true },
    ['btype'] = { name = 'Btype', maker = 'Albany', price = 200000, trunk = 40, glove = 15, type = 'work', class = 'sportsclassics', banned = false },
    ['boxville4'] = { name = 'BoxVille4', maker = 'Brute', price = 1000, trunk = 70, glove = 15, type = 'work', class = 'vans', banned = true },
    ['squalo'] = { name = 'Squalo', maker = 'Grotti', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['speedo'] = { name = 'Speedo', maker = 'Vapid', price = 200000, trunk = 120, glove = 15, type = 'work', class = 'vans', banned = false },
    ['slamvan2'] = { name = 'Slamvan2', maker = 'Vapid', price = 200000, trunk = 100, glove = 15, type = 'work', class = 'muscle', banned = false },
    ['tornado5'] = { name = 'Tornado5', maker = 'Declasse', price = 200000, trunk = 60, glove = 15, type = 'work', class = 'sportsclassics', banned = false },
    ['gburrito'] = { name = 'GBurrito', maker = 'Declasse', price = 500000, trunk = 100, glove = 15, type = 'work', class = 'vans', banned = false },
    ['trailerlogs'] = { name = 'Woods', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['volatus'] = { name = 'Volatus', maker = 'Buckingham', price = 1000000, trunk = 1000, glove = 15, type = 'work', class = 'helicopters', banned = true },
    ['seashark3'] = { name = 'Seashark3', maker = 'Speedophile', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['fbi2'] = { name = 'Granger FBI', maker = 'Declasse', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['marquis'] = { name = 'Marquis', maker = 'Dinka', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['graintrailer'] = { name = 'GrainTrailer', maker = 'Brute', price = 1000, trunk = 500, glove = 15, type = 'work', class = 'utility', banned = false },
    ['tvtrailer'] = { name = 'Show', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['tanker2'] = { name = 'Gas', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['toro2'] = { name = 'Toro2', maker = 'Lampadati', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['tiptruck'] = { name = 'Tiptruck', maker = 'Brute', price = 1000, trunk = 70, glove = 15, type = 'work', class = 'industrial', banned = false },
    ['trash2'] = { name = 'Caminhão Lixo', maker = 'Brute', price = 1000, trunk = 80, glove = 15, type = 'work', class = 'utility', banned = false },
    ['towtruck'] = { name = 'Towtruck', maker = 'Vapid', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['rebel'] = { name = 'Rebel', maker = 'Karin', price = 1000, trunk = 80, glove = 15, type = 'work', class = 'offroad', banned = false },
    ['rubble'] = { name = 'Caminhão', maker = 'Jobuilt', price = 1000, trunk = 200, glove = 15, type = 'work', class = 'industrial', banned = false },
    ['caddy'] = { name = 'Caddy', maker = 'Work', price = 180000, trunk = 120, glove = 15, type = 'work', class = 'utility', banned = true },
    ['caddy2'] = { name = 'Caddy 2', maker = 'Work', price = 180000, trunk = 120, glove = 15, type = 'work', class = 'utility', banned = true },
    ['stafford'] = { name = 'Stafford', maker = 'Enus', price = 150000, trunk = 40, glove = 15, type = 'work', class = 'sedans', banned = false },
    ['dinghy'] = { name = 'Dinghy', maker = 'Nagasaki', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['mammatus'] = { name = 'Mammatus', maker = 'Jobuilt', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'planes', banned = true },
    ['armytanker'] = { name = 'Diesel', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['police4'] = { name = 'Cruiser FBI', maker = 'Vapid', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['fbi'] = { name = 'Buffalo FBI', maker = 'Declasse', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['suntrap'] = { name = 'Suntrap', maker = 'Shitzu', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['bus'] = { name = 'Ônibus', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'service', banned = true },
    ['faction2'] = { name = 'Faction2', maker = 'Willard', price = 200000, trunk = 40, glove = 15, type = 'work', class = 'muscle', banned = false },
    ['cuban800'] = { name = 'Cuban800', maker = 'Western company', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'planes', banned = true },
    ['velum2'] = { name = 'Velum2', maker = 'Jobuilt', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'planes', banned = true },
    ['boxville2'] = { name = 'BoxVille2', maker = 'Brute', price = 1000, trunk = 70, glove = 15, type = 'work', class = 'vans', banned = true },
    ['seashark2'] = { name = 'seashark2', maker = 'Kraken', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'Speedophile', banned = true },
    ['tribike'] = { name = 'Tribike', maker = 'Bmx', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'cycles', banned = true },
    ['tropic2'] = { name = 'Tropic2', maker = 'Grotti', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['bison2'] = { name = 'Bison2', maker = 'Bravado', price = 0, trunk = 0, glove = 15, type = 'work', class = 'vans', banned = true },
    ['luxor2'] = { name = 'Luxor Dourado', maker = 'Western company', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'planes', banned = true },
    ['tropic'] = { name = 'Tropic', maker = 'Grotti', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'boats', banned = true },
    ['packer'] = { name = 'Packer', maker = 'MTL', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'commercial', banned = true },
    ['seasparrow'] = { name = 'Paramédico Helicóptero Água', maker = 'Maibatsu', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'helicopters', banned = true },
    ['taxi'] = { name = 'Taxi', maker = 'Vapid', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'service', banned = true },
    ['tribike2'] = { name = 'Tribike2', maker = 'Bmx', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'cycles', banned = true },
    ['tr4'] = { name = 'Carga de Carros', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'utility', banned = true },
    ['tractor2'] = { name = 'Tractor2', maker = 'Stanley', price = 1000, trunk = 80, glove = 15, type = 'work', class = 'utility', banned = false },
    ['chino2'] = { name = 'Chino2', maker = 'Vapid', price = 100000, trunk = 60, glove = 15, type = 'work', class = 'muscle', banned = false },
    ['policeb'] = { name = 'Harley Davidson', maker = 'WMC', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['pbus'] = { name = 'PBus', maker = 'Brute', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['bison3'] = { name = 'Bison3', maker = 'Bravado', price = 0, trunk = 0, glove = 15, type = 'work', class = 'vans', banned = true },
    ['utillitruck'] = { name = 'Utillitruck', maker = 'Vapid', price = 180000, trunk = 120, glove = 15, type = 'work', class = 'utility', banned = true },
    ['scorcher'] = { name = 'Scorcher', maker = 'Bmx', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'cycles', banned = true },
    ['404_r1200'] = { name = 'Bmw R1200', maker = 'BMW', price = 1000, trunk = 0, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['jaguarhospital'] = { name = 'Jaguar', maker = 'Jaguar', price = 1000, trunk = 50, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['wrspeedoems'] = { name = 'Ambulância', maker = 'Vapid', price = 1000, trunk = 50, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['wrvolito'] = { name = 'Volito', maker = 'Hospital', price = 1000, trunk = 200, glove = 0, type = 'work', class = 'emergency', banned = true },
    ['ndagera'] = { name = 'Agera', maker = 'Koenigsegg', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['ndbmws1000'] = { name = 'Bmws', maker = 'Bmw', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['wra45'] = { name = 'A45', maker = 'Mercedes-Benz', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['wrbmwx6'] = { name = 'Bmw X6', maker = 'Bmw', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['wrbmwx7'] = { name = 'Bmw X6', maker = 'Bmw', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['wrm5'] = { name = 'Bmw M5', maker = 'Bmw', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['wrsubaru'] = { name = 'Subaru', maker = 'Subaru', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['trdcoreamarok'] = { name = 'Amarok COE', maker = 'Volkswagen', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['fpacehm'] = { name = 'GOT ', maker = 'Jaguar', price = 1000000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = false },
    ['bmheli'] = { name = 'Helicóptero', maker = 'Polícia', price = 1000, trunk = 100, glove = 0, type = 'work', class = 'helicopters', banned = true },
    ['wrsamarok'] = { name = 'Amarok', maker = 'Polícia', price = 1000, trunk = 150, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['wrsrs7'] = { name = 'Audi', maker = 'Polícia', price = 1000, trunk = 50, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['wryukon'] = { name = 'Yukon', maker = 'Polícia', price = 1000, trunk = 50, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['b412'] = { name = 'B412', maker = 'Polícia', price = 1000, trunk = 100, glove = 15, type = 'work', class = 'helicopters', banned = true },
    ['ghispo2'] = { name = 'Maserati', maker = 'Polícia', price = 1000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['nd911'] = { name = '911r', maker = 'Polícia', price = 1000, trunk = 30, glove = 15, type = 'work', class = 'emergency', banned = true },
    ['wrxc90'] = { name = 'volvo', maker = 'Polícia', price = 1000, trunk = 50, glove = 15, type = 'work', class = 'emergency', banned = true },
}

config.blips = {
    ['carOnly'] = {
        sprite = 357,
        color = 3,
        scale = 0.6,
    }
}

config.garages = {
    {
        coords = vector3(55.54286, -876.1714, 30.6615), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(50.5055, -873.7319, 30.42566, 155.9055),
            vector4(47.38022, -872.2681, 30.4425, 155.9055),
            vector4(44.09671, -870.9231, 30.45935, 155.9055)
        }
    },
    {
        coords = vector3(4980.699, -5728.589, 19.87769), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(4976.202, -5731.477, 19.87769, 240.9449),
            vector4(4972.141, -5739.297, 19.87769, 238.1102),
            vector4(4968.079, -5746.892, 19.87769, 249.4488)
        }
    },
    -- [Zero Fome] --
    {
        coords = vector3(-1845.903, -1214.782, 13.00293), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-1843.741, -1218.897, 12.34583, 291.9685),
        },
    },
    -- [DEIC PESSOAL] --
    {
        coords = vector3(466.2462, 4544.123, 80.33484), 
        points = {
            vector4(467.8813, 4537.424, 79.93042, 277.7953),
        },
    },
    -- [DEIC VIP] --
    {
        coords = vector3(490.3121, 4532.861, 79.9978), 
        permission = 'vippm.permissao',
        points = {
            vector4(485.1297, 4534.694, 79.98096, 68.03149),
        },
        vehicles = { 'wrbmwx6', 'ndagera' }
    },
    -- [DEIC VTR] --
    {
        coords = vector3(487.622, 4545.547, 79.9978), 
        permission = 'deic.permissao',
        points = {
            vector4(482.3868, 4542.198, 79.96411, 96.37794),
        },
        vehicles = { 'wrsamarok', 'wrsrs7', 'ghispo2', 'nd911', 'wrxc90' }
    },
    -- [DEIC HELI] --
    {
        coords = vector3(349.9648, 4434.989, 63.35022), 
        permission = 'deic.permissao',
        marker = 'heli',
        points = {
            vector4(355.5824, 4441.859, 63.65344, 212.5984),
        },
        vehicles = { 'b412' }
    },
    -- [Hospital] --
    {
        coords = vector3(-861.666, -1226.189, 6.195557), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-864.1187, -1217.697, 5.150879, 303.3071),
            vector4(-859.3582, -1221.218, 5.487915, 323.1496)
        },
    },
    -- --
    {
        coords = vector3(-854.5846, -1239.363, 6.920166), 
        rule = 'carOnly',
        permission = 'hospital.permissao',
        points = {
            vector4(-849.0989, -1241.473, 6.920166, 320.315),
            vector4(-856.6418, -1233.547, 6.920166, 317.4803),
        },
        vehicles = { 'jaguarhospital', 'wrspeedoems', '404_r1200' }
    },
    {
        coords = vector3(-349.2791, -148.7077, 39.0022), 
        rule = 'carOnly',
        permission = 'zeromecanica.permissao',
        points = {
            vector4(-340.4308, -149.0242, 39.08643, 289.1339),
            vector4(-339.5209, -152.5055, 39.08643, 291.9685)
        },
        vehicles = { 'flatbed3', 'raptor150' }
    },
    {
        coords = vector3(-2281.081, 401.644, 174.5927), 
        rule = 'carOnly',
        permission = 'vippm.permissao',
        points = {
            vector4(-2282.176, 404.1758, 174.4579, 119.0551),
            vector4(-2284.22, 407.2088, 174.4579, 124.7244),
            vector4(-2286.725, 410.2154, 174.4579, 136.063),
        },
        vehicles = { 'wrbmwx6', 'ndagera' }
    },
    {
        coords = vector3(-2292.356, 420.1451, 174.5927), 
        rule = 'carOnly',
        permission = 'policia.permissao',
        points = {
            vector4(-2296.338, 415.7538, 174.4579, 161.5748),
            vector4(-2292.58, 414.4088, 174.4579, 150.2362),
            vector4(-2289.534, 412.2198, 174.4579, 144.5669),
        },
        vehicles = { 'ndbmws1000', 'wra45', 'wrm5', 'wrsubaru', 'fpacehm' }
    },
    {
        coords = vector3(-2267.776, 386.4396, 193.2117), 
        rule = 'heliOnly',
        marker = 'heli',
        permission = 'policia.permissao',
        points = {
            vector4(-2267.644, 395.0901, 193.1274, 68.03149)
        },
        vehicles = { 'bmheli' }
    },
    {
        coords = vector3(-724.0352, -1453.622, 4.999268), 
        rule = 'heliOnly',
        marker = 'heli',
        points = {
            vector4(-724.7868, -1444.167, 4.999268, 323.1496)
        },
    },
    -- [Helipa] --
    {
        coords = vector3(291.7582, 1881.059, 206.5905), 
        rule = 'heliOnly',
        marker = 'heli',
        permission = 'helipa.permissao',
        points = {
            vector4(281.7626, 1885.015, 207.2476, 102.0472)
        },
    },
    -- --
    -- [Camorra] --
    {
        coords = vector3(136.3385, -1278.818, 29.34729), 
        rule = 'carOnly',
        marker = 'car',
        permission = 'camorra.permissao',
        points = {
            vector4(142.7077, -1277.341, 29.26306, 209.7638)
        },
    },
    -- --
    -- [Polonia] --
    {
        coords = vector3(2886.936, 2745.204, 70.00586), 
        rule = 'carOnly',
        marker = 'car',
        permission = 'polonia.permissao',
        points = {
            vector4(2884.154, 2742.989, 69.88794, 42.51968)
        },
    },
    -- --
    {
        coords = vector3(506.1494, -2746.299, 3.061523), 
        rule = 'carOnly',
        permission = 'deic.permissao',
        points = {
            vector4(496.3253, -2741.842, 3.061523, 53.85827),
            vector4(487.4769, -2756.334, 3.061523, 51.02362)
        },
        vehicles = { 'ndbmws1000', 'wra45', 'wrm5', 'wrsubaru' }
    },
    {
        coords = vector3(560.0308, -2799.204, 6.077637), 
        rule = 'carOnly',
        permission = 'deic.permissao',
        points = {
            vector4(570.8571, -2800.18, 6.077637, 243.7795)
        }
    },
    {
        coords = vector3(44.33407, -842.2154, 31.1333), 
        rule = 'carOnly',
        points = {
            vector4(53.48572, -847.2396, 30.83008, 153.0709),
            vector4(56.7033, -848.2813, 30.81323, 153.0709),
            vector4(59.68352, -849.5077, 30.79639, 150.2362),
            vector4(63.01978, -850.9583, 30.79639, 161.5748)
        }
    },
    {
        coords = vector3(-281.3011, -888.8439, 31.30188), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-285.5736, -887.1429, 31.06592, 167.2441),
            vector4(-289.2396, -886.4044, 31.06592, 167.2441),
            vector4(-292.8528, -885.3231, 31.06592, 164.4095),
            vector4(-298.3912, -900.0396, 31.06592, 348.6614)
        }
    },
    {
        coords = vector3(-348.8571, -874.0879, 31.30188), 
        rule = 'carOnly',
        points = {
            vector4(-343.6352, -875.2615, 31.06592, 167.2441),
            vector4(-340.0879, -876.1978, 31.06592, 164.4095),
            vector4(-336.4352, -877.1077, 31.06592, 167.2441),
            vector4(-338.4264, -891.5472, 31.06592, 348.6614)
        }
    },
    {
        coords = vector3(214.0088, -808.4835, 30.99854), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(219.5604, -808.9055, 30.67834, 249.4488),
            vector4(220.8264, -806.5582, 30.67834, 246.6142),
            vector4(222.1582, -804.3033, 30.6615, 246.6142),
            vector4(215.6176, -804.3428, 30.79639, 68.03149)
        }
    },
    {
        coords = vector3(101.2484, -1073.552, 29.36414), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(104.4396, -1078.431, 29.17871, 340.1575),
            vector4(107.8813, -1079.947, 29.17871, 342.9921),
            vector4(111.3363, -1081.121, 29.17871, 340.1575),
            vector4(106.0484, -1063.279, 29.17871, 243.7795)
        }
    },
    {
        coords = vector3(85.18681, -1192.391, 29.54944), 
        rule = 'carOnly',
        points = {
            vector4(88.04836, -1200.369, 29.27991, 274.9606),
            vector4(90.51429, -1204.22, 29.27991, 272.126),
            vector4(97.34506, -1194, 29.27991, 93.5433),
            vector4(96.58022, -1191.534, 29.27991, 93.5433)
        }
    },
    {
        coords = vector3(-1159.596, -739.5428, 19.87769), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-1141.081, -740.4, 20.04614, 291.9685),
            vector4(-1146.527, -745.9648, 19.60803, 104.8819),
            vector4(-1138.523, -743.2615, 19.89453, 289.1339),
            vector4(-1144.8, -749.0769, 19.43958, 104.8819)
        }
    },
    {
        coords = vector3(-609.8769, -2238.303, 6.246094), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-604.1934, -2221.332, 5.976562, 187.0866),
            vector4(-609.2044, -2216.624, 5.993408, 181.4173),
            vector4(-614.0044, -2213.051, 5.993408, 178.5827)
        }
    },
    {
        coords = vector3(-340.6022, 266.0703, 85.67615), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-329.6703, 274.2857, 86.28284, 90.70866),
            vector4(-329.222, 277.9253, 86.31653, 96.37794),
            vector4(-348.8967, 272.2418, 85.13696, 272.126),
            vector4(-348.3692, 275.9868, 85.08643, 272.126)
        }
    },
    {
        coords = vector3(362.1231, 297.8242, 103.874), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(361.3187, 293.4725, 103.5033, 252.2835),
            vector4(359.8813, 289.8593, 103.4865, 252.2835),
            vector4(374.7956, 293.7099, 103.2675, 164.4095),
            vector4(371.4857, 285.8374, 103.2506, 342.9921)
        }
    },
    {
        coords = vector3(596.5846, 90.68571, 93.12378), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(599.6308, 98.10989, 92.90479, 249.4488),
            vector4(600.2637, 101.9868, 92.90479, 252.2835),
            vector4(608.1627, 104.0308, 92.80371, 70.86614),
            vector4(609.6528, 107.6044, 92.85425, 68.03149)
        }
    },
    {
        coords = vector3(983.6044, -206.8088, 71.06738), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(983.0374, -211.8857, 70.78101, 240.9449),
            vector4(993.3362, -211.9385, 70.41028, 59.52755),
            vector4(988.8264, -217.6483, 70.20801, 53.85827),
            vector4(986.3209, -221.0901, 69.98901, 53.85827)
        }
    },
    {
        coords = vector3(1156.101, -453.7451, 66.9729), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(1151.354, -462.3033, 66.7876, 161.5748),
            vector4(1155.204, -462.4352, 66.82129, 164.4095),
            vector4(1158.382, -463.8593, 66.75391, 164.4095),
            vector4(1161.956, -464.9934, 66.61902, 167.2441)
        }
    },
    {
        coords = vector3(-73.33186, -2004.936, 18.26013), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-77.48571, -2004.527, 18.00732, 351.4961),
            vector4(-81.27032, -2003.683, 18.00732, 351.4961),
            vector4(-84.96263, -2003.235, 18.00732, 357.1653),
            vector4(-78.63297, -2012.268, 18.00732, 170.0787)
        }
    },
    {
        coords = vector3(-2030.031, -465.8769, 11.58752), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-2024.295, -472.378, 11.38538, 138.8976),
            vector4(-2022.277, -474.5011, 11.38538, 138.8976),
            vector4(-2037.534, -461.1692, 11.38538, 138.8976),
            vector4(-2039.881, -459.2703, 11.38538, 138.8976)
        }
    },
    {
        coords = vector3(317.3539, 2623.108, 44.46155), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(336.1582, 2620.127, 44.47839, 31.1811),
            vector4(342.356, 2623.345, 44.49524, 19.84252),
            vector4(348.7253, 2625.481, 44.49524, 22.67716),
            vector4(354.6461, 2627.881, 44.49524, 11.33858)
        }
    },
    {
        coords = vector3(1408.655, 3621.204, 34.89087), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(1416.554, 3622.246, 34.85718, 198.4252),
            vector4(1420.589, 3623.512, 34.85718, 204.0945),
            vector4(1424.229, 3624.053, 34.85718, 201.2598),
            vector4(1429.727, 3616.655, 34.94141, 107.7165)
        }
    },
    {
        coords = vector3(-102.3824, 6344.004, 31.57141), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-95.12967, 6344.018, 31.48718, 223.937),
            vector4(-92.16264, 6346.562, 31.48718, 223.937),
            vector4(-100.2725, 6338.624, 31.48718, 226.7717),
            vector4(-86.24176, 6339.943, 31.48718, 42.51968)
        }
    },
    {
        coords = vector3(-772.6945, 5597.499, 33.59338), 
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-773.789, 5578.338, 33.47546, 87.87402),
            vector4(-773.9868, 5575.345, 33.47546, 90.70866),
            vector4(-774.0527, 5572.365, 33.47546, 90.70866),
            vector4(-774.0132, 5569.319, 33.47546, 87.87402)
        }
    },
    {
        coords = vector3(-1644.158, -989.4989, 13.00293), 
        rule = 'carOnly',
        marker = 'bike',
        points = {
            vector4(-1641.996, -990.6857, 13.00293, 232.4409),
            vector4(-1640.44, -989.011, 13.00293, 232.4409),
            vector4(-1638.857, -987.3099, 13.00293, 232.4409),
            vector4(-1637.591, -985.9648, 13.00293, 235.2756)
        },
        vehicles = { 'bmx' }
    },
    {
        coords = vector3(-309.6132, -731.1033, 28.01611), 
        rule = 'carOnly',
        home = 'Cobertura',
        points = {
            vector4(-314.7692, -734.2681, 28.01611, 342.9921),
            vector4(-312.633, -728.3472, 27.35901, 340.1575),
        }
    },
    {
        coords = vector3(-1653.758, -1001.407, 13.00293), 
        rule = 'carOnly',
        marker = 'bike',
        points = {
            vector4(-1652.057, -1002.778, 13.00293, 232.4409),
            vector4(-1653.574, -1004.624, 13.00293, 232.4409),
            vector4(-1655.051, -1006.602, 13.00293, 232.4409),
            vector4(-1656.633, -1008.554, 13.00293, 229.6063)
        },
        vehicles = { 'bmx' }
    },
    -- ESPANHA
    {
        coords = vector3(376.7341, -13.88571, 82.98022),
        rule = 'carOnly',
        permission = 'espanha.permissao',
        points = {
            vector4(370.7868, -9.639557, 83.06445, 36.85),
            vector4(366.5538, -11.76263, 83.06445, 36.85)
        },
    },
    -- ECLIPSE
    {
        coords = vector3(-788.5978, 305.367, 85.69299),
        rule = 'carOnly',
        home = 'Eclipse',
        points = {
            vector4(-797.9604, 305.9209, 85.69299, 175.748),
            vector4(-794.0571, 305.6967, 85.69299, 178.5827)
        },
    },
    -- JETTY
    {
        coords = vector3(-2006.651, -322.7736, 48.10107),
        rule = 'carOnly',
        home = 'Jetty',
        points = {
            vector4(-2009.921, -326.9406, 48.10107, 240.9449),
            vector4(-2011.556, -329.3143, 48.10107, 238.1102)
        },
    },
    -- RICHMAN
    {
        coords = vector3(-1301.604, 275.7099, 64.20947),
        rule = 'carOnly',
        home = 'Richman',
        points = {
            vector4(-1305.442, 275.8549, 64.02417, 147.4016),
            vector4(-1309.187, 278.1231, 63.99048, 147.4016)
        },
    },
    -- TINSEL
    {
        coords = vector3(-619.8989, 56.41319, 43.73694),
        rule = 'carOnly',
        home = 'Tinsel',
        points = {
            vector4(-621.6263, 53.78902, 43.72009, 82.20473),
            vector4(-621.3494, 59.45934, 43.72009, 93.5433)
        },
    },
    -- ELGIN
    {
        coords = vector3(-60.0923, 162.778, 81.48059),
        rule = 'carOnly',
        home = 'Elgin',
        points = {
            vector4(-59.09011, 159.5868, 81.34583, 119.0551),
            vector4(-62.37362, 165.2835, 81.34583, 127.5591)
        },
    },
    -- GENTRY
    {
        coords = vector3(-50.66373, 347.5648, 112.3663),
        rule = 'carOnly',
        home = 'Gentry',
        points = {
            vector4(-55.63516, 343.5824, 112.1135, 153.0709),
        },
    },
    -- GARDEN
    {
        coords = vector3(358.6945, -81.62637, 67.74805),
        rule = 'carOnly',
        home = 'Garden',
        points = {
            vector4(365.3539, -80.2945, 67.34363, 249.4488),
        },
    },
    -- Banner
    {
        coords = vector3(-277.0945, -1052.967, 27.20728),
        rule = 'carOnly',
        home = 'Banner',
        points = {
            vector4(-271.6088, -1059.191, 26.31433, 158.7402),
        },
    },
    -- Works
    {
        coords = vector3(713.3143, -976.8132, 24.12378),
        rule = 'carOnly',
        points = {
            vector4(712.7077, -981.3758, 24.14062, 223.937),
            vector4(708.3824, -981.7319, 24.10693, 221.1024)
        },
        vehicles = {
            'bison3'
        }
    },
    {
        coords = vector3(1189.912, -3249.455, 6.060791),
        rule = 'carOnly',
        points = {
            vector4(1188.343, -3245.96, 6.0271, 87.87402),
            vector4(1188.079, -3242.651, 6.0271, 85.03937)
        },
        vehicles = {
            'boxville4'
        }
    },
    {
        coords = vector3(116.0176, 102.7516, 81.1604),
        rule = 'carOnly',
        points = {
            vector4(116.0176, 96.8044, 80.73926, 141.7323),
            vector4(112.3516, 98.18901, 80.58752, 164.4095)
        },
        vehicles = {
            'boxville2'
        }
    },
    {
        coords = vector3(1998.738, 3056.769, 47.03955),
        rule = 'carOnly',
        points = {
            vector4(2000.11, 3060.791, 47.03955, 223.937)
        },
        vehicles = {
            'boxville'
        }
    },
    {
        coords = vector3(916.2593, 3560.506, 33.79565),
        rule = 'carOnly',
        points = {
            vector4(923.7495, 3564.026, 33.79565, 172.9134)
        },
        vehicles = {
            'bison2'
        }
    },
    {
        coords = vector3(-333.244, -1518.25, 27.52747),
        rule = 'carOnly',
        points = {
            vector4(-329.2879, -1518.185, 27.52747, 175.748),
            vector4(-325.9648, -1518.488, 27.52747, 175.748)
        },
        vehicles = {
            'caddy'
        }
    },
    {
        coords = vector3(745.622, 136.2989, 80.16626),
        rule = 'carOnly',
        points = {
            vector4(749.2615, 129.4022, 78.93628, 235.2756)
        },
        vehicles = {
            'utillitruck'
        }
    },

    -- [ FACS ] --
    {
        coords = vector3(1370.558, -725.6703, 67.17505),
        rule = 'carOnly',
        points = {
            vector4(1370.44, -730.6813, 66.43372, 99.21259),
            vector4(1378.022, -729.0066, 66.40002, 93.5433)
        }
    },
    {
        coords = vector3(499.411, -3126.659, 6.060791),
        rule = 'carOnly',
        points = {
            vector4(489.5868, -3127.45, 6.060791, 0),
            vector4(489.8901, -3141.178, 6.060791, 0)
        }
    },
    {
        coords = vector3(1666.167, -2064.818, 100.959),
        rule = 'carOnly',
        points = {
            vector4(1669.899, -2065.411, 100.8242, 342.9921),
            vector4(1667.512, -2076.409, 101.0432, 348.6614) 
        }
    },
    {
        coords = vector3(1217.301, -1040.413, 47.3429),
        rule = 'carOnly',
        points = {
            vector4(1215.56, -1036.127, 47.19116, 96.37794),
            vector4(1224.396, -1035.719, 46.31506, 93.5433)
        }
    },
    {
        coords = vector3(-1526.571, 892.8395, 182.1919),
        rule = 'carOnly',
        points = {
            vector4(-1530.91, 889.4374, 181.8718, 201.2598),
            vector4(-1534.853, 889.0945, 181.7876, 201.2598)
        }
    },
    {
        coords = vector3(-1788.897, 410.9407, 113.4447),
        rule = 'carOnly',
        points = {
            vector4(-1798.207, 399.8506, 112.8718, 102.0472),
            vector4(-1795.754, 391.7538, 112.855, 102.0472)
        }
    },
    {
        coords = vector3(1436.479, -2613.785, 48.20215),
        rule = 'carOnly',
        points = {
            vector4(1440.804, -2609.406, 48.25281, 342.9921),
            vector4(1444.431, -2609.116, 48.32019, 345.8268)
        }
    },
    {
        coords = vector3(-272.6374, 1527.442, 337.8843),
        rule = 'carOnly',
        points = {
            vector4(-277.0154, 1529.064, 337.4967, 141.7323),
            vector4(-270.5934, 1536.369, 337.3114, 136.063) 
        }
    },
    {
        coords = vector3(-250.7868, -306.567, 30.22339),
        rule = 'carOnly',
        points = {
            vector4(-259.1209, -315.1253, 30.08862, 8.503937),
            vector4(-256.8923, -330.0527, 29.80225, 8.503937) 
        }
    },
    {
        coords = vector3(973.5297, -143.8681, 74.23511),
        rule = 'carOnly',
        points = {
            vector4(970.4835, -135.4022, 74.35315, 59.52755),
            vector4(967.1473, -141.033, 74.40369, 59.52755)
        }
    },
    {
        coords = vector3(1782.857, 426.0659, 172.9246),
        rule = 'carOnly',
        points = {
            vector4(1787.736, 426.5011, 172.874, 198.4252),
            vector4(1784.835, 435.2703, 172.8235, 192.7559)
        }
    },
    {
        coords = vector3(241.3055, 1859.974, 191.2572),
        rule = 'carOnly',
        points = {
            vector4(238.8791, 1855.622, 191.6615, 8.503937),
            vector4(236.3473, 1868.479, 189.5048, 11.33858)
        }
    },
    {
        coords = vector3(1273.042, -224.2154, 98.76855),
        rule = 'carOnly',
        points = {
            vector4(1276.127, -223.5297, 98.90332, 189.9213),
            vector4(1277.604, -215.6044, 99.62781, 172.9134) 
        }
    },
    {
        coords = vector3(-374.967, -147.9692, 38.68201),
        rule = 'carOnly',
        points = {
            vector4(-374.4791, -145.0945, 38.68201, 300.4724),
            vector4(-376.6418, -142.1538, 38.68201, 300.4724),
            vector4(-378.2374, -139.0154, 38.68201, 300.4724)
        }
    },
    -- [PRISAO] --
    {
        coords = vector3(1852.365, 2601.706, 45.65784),
        marker = 'bike',
        points = {
            vector4(1854.105, 2607.046, 45.05127, 274.9606),
        },
        vehicles = { 'bmx' }
    },

    {
        coords = vector3(-2300.202, 415.6747, 174.4579),
        rule = 'carOnly',
        points = {
            vector4(-2296.602, 414.3165, 174.4579, 158.7402),
            vector4(-2293.543, 412.5627, 174.4579, 155.9055),
            vector4(-2290.642, 410.3736, 174.4579, 141.7323)
        }
    },
    -- [Mount Hann] --
    {
        coords = vector3(165.0989, 1693.912, 227.3832),
        rule = 'carOnly',
        points = {
            vector4(174.8176, 1683.982, 228.9333, 215.4331)
        }
    },
    -- [Devil] --
    {
        coords = vector3(-2601.481, 1927.094, 167.2968),
        rule = 'carOnly',
        points = {
            vector4(-2595.178, 1930.602, 166.9092, 277.7953)
        }
    },
    {
        coords = vector3(-504.4352, -255.6791, 35.66589),
        showBlip = true,
        rule = 'carOnly',
        points = {
            vector4(-505.978, -259.7407, 35.07617, 110.5512)
        }
    },
    {
        coords = vector3(-574.9583, -248.9143, 35.90186),
        permission = '+Juridico.AdvogadoJunior',
        rule = 'carOnly',
        points = {
            vector4(-579.3362, -247.3187, 35.73328, 209.7638)
        },
        vehicles = { 'xls2' }
    },
    {
        coords = vector3(-577.0813, -245.3539, 36.01978),
        permission = 'juridico.permissao',
        rule = 'carOnly',
        points = {
            vector4(-579.3362, -247.3187, 35.73328, 209.7638)
        },
        vehicles = { 'premier' }
    },
    {
        coords = vector3(-1521.93, 79.95165, 56.76196),
        rule = 'carOnly',
        home = 'Playboy',
        points = {
            vector4(-1520.809, 87.11209, 56.44177, 260.7874)
        },
    },
    {
        coords = vector3(-1391.578, 6746.466, 11.89087),
        rule = 'heliOnly',
        marker = 'heli',
        points = {
            vector4(-1389.27, 6742.615, 12.64905, 257.9528)
        },
    },
}

config.rules = {
    ['carOnly'] = {
        ['show_classes'] = nil,
        ['hide_classes'] = { ['planes'] = true, ['helicopters'] = true, ['boats'] = true }
    },
    ['heliOnly'] = {
        ['show_classes'] = { ['helicopters'] = true },
        ['hide_classes'] = nil
    },
    ['planeOnly'] = {
        ['show_classes'] = { ['planes'] = true },
        ['hide_classes'] = nil
    },
    ['boatsOnly'] = {
        ['show_classes'] = { ['boats'] = true },
        ['hide_classes'] = nil
    },
}

config.hashes = {}

for vname, data in pairs(config.vehicles) do
	if (data.hash) then
		config.hashes[data.hash] = vname
	else		
		local model = GetHashKey(vname)
		config.vehicles[vname].hash = model
		config.hashes[model] = vname
	end
end