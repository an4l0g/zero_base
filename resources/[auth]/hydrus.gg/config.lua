ENV = {}

-- GlobalState is an easy way to share with the client
GlobalState['hydrus:lang'] = 'pt'

ENV.debug = false
ENV.token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXAiOiJzdG9yZSIsInN1YiI6MjEyNCwiZ2VuIjoxfQ.y3aTQK22-AYk-gMGM9migGO9NoAgUn2T3Q1-7Jl-43o'

-- Be careful when adding more workers, your commands must support concurrency and race condition
-- By default, the script handles race conditions just fine
ENV.workers = 4

-- D = Digit (0-9)
-- L = Letter (A-Z)
ENV.plate_format = 'LLL DLDD'

-- Loads the intelisense from the github using load()
ENV.enhanced_intelisense = false
ENV.products = {}
ENV.testdrive = true

-- Delete or comment this to disable the chat broadcast.
ENV.chat_styles = {
    'padding: 10px',
    'margin: 5px 0',
    'background-image: linear-gradient(to right, #0099ff 3%, #099fff19 95%)',
    'border-radius: 5px',
    'color: snow',
    'display: flex',
    'align-items:d center',
    'justify-content: center',
    'font-weight: bold',
}
-- Styles for the /vip command
ENV.vip_styles = ENV.chat_styles
ENV.vip_command = 'vip'

AddEventHandler('hydrus:products-ready', function(scope)

    -- scope.addHomeProduct({
    --     name = 'Temporary Home', 
    --     credit = 'temporary_home',
    --     -- image = 'https://i.imgur.com/SMxEwXT.png', (Default)
    --     homes = 'Homes:1-1000',
    --     days = 30,
    -- })
    -- scope.addHomeProduct({
    --     name = 'Permanent Home',
    --     credit = 'permanent_home',
    --     -- image = 'https://i.imgur.com/SMxEwXT.png', (Default)
    --     homes = 'Homes:1-70,FH:1-100,Middle:1-100-3',
    -- })
    --==================================================================================================================
    -- local ignorevehs =  { ["mule3"] = true }
    -- local dealer_vehicles = {}
    -- local dealer_query = SQL('SELECT model FROM dealership WHERE stock > 0')
    -- for _,row in pairs(dealer_query) do
    --     if (not ignorevehs[row.model]) then
    --         local vehicleName = exports['vrp']:vehicleMaker(row.model)..' - '..exports['vrp']:vehicleName(row.model)
    --         dealer_vehicles[row.model] = vehicleName
    --     end
    -- end
    -- scope.addVehicleProduct({
    --     name = 'Veículo Temporário',
    --     credit = 'vehicle_temp',
    --     image = 'http://189.127.164.170/vehicles/toros.png',
    --     days = 30,
    --     vehicles = {
    --         ["amarok"] = "VW Amarok",
    --         ["bmwm5f90"] = "BMW M5 F90",
    --         ["bmwm8"] = "BMW M8",
    --         ["bmwr1250rocam"] = "BMW R1250",
    --         ["bmws"] = "BMW S1000",
    --         ["cb500x"] = "Honda CB500",
    --         ["cbr17"] = "Honda CBR 17",
    --         ["celta"] = "Chevrolet Celta",
    --         ["corvettec7"] = "Corvette C7",
    --         ["dodgecharger"] = "Dodge Charger",
    --         ["fk8"] = "Honda FK8",
    --         ["fordfocus"] = "Ford Focus",
    --         ["fordmustang"] = "Ford Mustang",
    --         ["golfmk6"] = "VW Golf MK6",
    --         ["jeepcherokee"] = "Jeep Cherokee",
    --         ["lancerevolution9"] = "Mit. Lancer Evo 9",
    --         ["lancerevolutionx"] = "Mit. Lancer Evo X",
    --         ["mazdarx7"] = "Mazda RX7",
    --         ["ninjazx10"] = "Kawasaki Ninja ZX10",
    --         ["nissangtr"] = "Nissan GTR",
    --         ["nissanskyliner34"] = "Nissan SkylineR34",
    --         ["paredao"] = "Som Paredao",
    --         ["pm19"] = "Porsche Macan",
    --         ["r1"] = "Yamaha YZF R1",
    --         ["rmodrs6"] = "Audi RS6",
    --         ["saveiro"] = "VW Saveiro",
    --         ["teslaprior"] = "Tesla Prior",
    --         ["tiger"] = "Triumph Tiger",
    --         ["toyotasupra"] = "Toyota Supra",
    --         ["urus2018"] = "Lamborghini Urus",
    --         ["xj6"] = "Yamaha XJ-6",
    --         ["z1000"] = "Kawasaki Z1000",
    --     }
    -- })
    -- scope.addVehicleProduct({
    --     name = 'Veículo Carnaval',
    --     credit = 'vehicle_carnaval',
    --     image = 'http://189.127.164.170/vehicles/benson.png',
    --     vehicles = {
    --         ['benson'] = 'Benson 1 Tonelada',
    --     }
    -- })
    --==================================================================================================================
    -- scope.addVehicleProduct({
    --     name = 'Veículos VIP',
    --     credit = 'vehicle_vip',
    --     image = 'https://storage.hydrus.gg/production/packages/YPmkuADimce3G3N7vBzRQc8piOstFlXzo51NFKMd.jpg',
    --     vehicles = {
    --         ["amarok"] = "VW Amarok",
    --         ["bmwm5f90"] = "BMW M5 F90",
    --         ["bmwm8"] = "BMW M8",
    --         ["bmwr1250rocam"] = "BMW R1250",
    --         ["bmws"] = "BMW S1000",
    --         ["cb500x"] = "Honda CB500",
    --         ["cbr17"] = "Honda CBR 17",
    --         ["celta"] = "Chevrolet Celta",
    --         ["corvettec7"] = "Corvette C7",
    --         ["dodgecharger"] = "Dodge Charger",
    --         ["fk8"] = "Honda FK8",
    --         ["fordfocus"] = "Ford Focus",
    --         ["fordmustang"] = "Ford Mustang",
    --         ["golfmk6"] = "VW Golf MK6",
    --         ["jeepcherokee"] = "Jeep Cherokee",
    --         ["lancerevolution9"] = "Mit. Lancer Evo 9",
    --         ["lancerevolutionx"] = "Mit. Lancer Evo X",
    --         ["mazdarx7"] = "Mazda RX7",
    --         ["ninjazx10"] = "Kawasaki Ninja ZX10",
    --         ["nissangtr"] = "Nissan GTR",
    --         ["nissanskyliner34"] = "Nissan SkylineR34",
    --         ["paredao"] = "Som Paredao",
    --         ["pm19"] = "Porsche Macan",
    --         ["r1"] = "Yamaha YZF R1",
    --         ["rmodrs6"] = "Audi RS6",
    --         ["saveiro"] = "VW Saveiro",
    --         ["teslaprior"] = "Tesla Prior",
    --         ["tiger"] = "Triumph Tiger",
    --         ["toyotasupra"] = "Toyota Supra",
    --         ["urus2018"] = "Lamborghini Urus",
    --         ["xj6"] = "Yamaha XJ-6",
    --         ["z1000"] = "Kawasaki Z1000",
    --     }
    -- })
    -- scope.addVehicleProduct({
    --     name = 'Veículos BR',
    --     credit = 'vehicle_br',
    --     image = 'https://storage.hydrus.gg/production/packages/YPmkuADimce3G3N7vBzRQc8piOstFlXzo51NFKMd.jpg',
    --     vehicles = {
    --         ["punto"] = "Fiat Punto",
    --         ["focusrs"] = "Ford Focus RS",
    --         ["up"] = "VW Up"
    --     }
    -- })
    -- --==================================================================================================================
    scope.addVehicleProduct({
        name = 'Veículos Premium',
        credit = 'vehicle_premium',
        image = 'https://storage.hydrus.gg/production/packages/G1dNjKNE2erfMKY4cPUxq6gAtam8zIe0fD5HULI5.jpg',
        vehicles = {
            ['nissanskyliner34'] = 'Skyline R34',
            ['lancerevolution9'] = 'Lancer Evo 9',
            ['lancerevolutionx'] = 'Lancer Evo X',
            ['21Charscat'] = 'Dodge Charger',
            ['a80'] = 'Toyota Supra',
            ['bmwm4gts'] = 'Bmw M4',
            ['bmwe39'] = 'Bmw e39',
            ['amarok'] = 'Amarok',
            ['maxima22'] = 'Nissan Maxima',
            ['nis15'] = 'Silvia S15',
            ['fk8'] = 'Honda Civic TypeR',
            ['golfrebaixado'] = 'Golf Gti Rebaixado',
            ['auditt'] = 'Audi TT',
            ['rmodr8c'] = 'Audi R8',
            ['q820'] = 'Audi Q8',
            ['rmodgt63'] = 'Mercedes Amg Gt 63s',
            ['zn20'] = 'Zenvo',
            -- ['xj6'] = 'Xj6',
            ['rmodrs6'] = 'Audi RS6',
            ['hornet'] = 'Hornet',
            ['911r'] = 'Porshe 911R',
            ['r1200'] = 'Bmw R1200',
            ['h2carb'] = 'Kawasaki Ninja H2',
            ['merc23'] = 'Mercedes E-class',
            ['mt09black'] = 'Yamaha Mt09',
            ['africat'] = 'Africat',
            ['nissanr33tbk'] = 'Skyline R33',
            ['z1000'] = 'Kawasaki Z1000',
            ['bmws'] = 'Bmw S1000RR',
            ['tiger1200'] = 'Tiger 1200',
            ['tenere1200'] = 'Yamaha Ténéré',
            ['ram1500'] = 'Dodge Ram',
            ['velar'] = 'Range Rover Velar',
            ['urus'] = 'Lamborghini Urus',
            ['19raptor'] = 'Ford Raptor',
            ['tiger'] = 'Tiger',
            ['cbb'] = 'Cbr1000'    
        }
    })
    scope.addVehicleProduct({
        name = 'Veículos Hyper',
        credit = 'vehicle_hypercar ',
        image = 'https://storage.hydrus.gg/production/packages/G1dNjKNE2erfMKY4cPUxq6gAtam8zIe0fD5HULI5.jpg',
        vehicles = {
            ['rmodskyline34'] = 'Skyline R34',
            ['silvia'] = 'Silvia',
            ['rmodbolide'] = 'Bugatti Bolide',
            ['718b'] = 'Porshe 718B',
            ['rmodgtr50'] = 'Nissan Gtr 50',
            ['sennagtr'] = 'Mclaren senna',
            ['458spider'] = 'Ferrari 458 Spider',
            ['720s18'] = 'Mclaren 720s',
            ['teslaprior'] = 'Tesla Prior',
            ['gxlaferrari'] = 'Laferrari',
            ['jeslbwk'] = 'Koenigsegg Jesko',
            ['ferrariitalia'] = 'Ferrari Italia',
        }
    })
    --==================================================================================================================
    table.insert(ENV.products, {
        name = 'Troca de Telefone',
        consume = { 'phone_number', 1 },
        image = '',
        form = {
            {
                label = _('insert.phone'),
                placeholder = '000-000',
                name = 'phone',
                pattern = '000-000'
            },
        },
        -- Look at server/ext/products.lua for the reference
        is_allowed = phone_is_allowed,
        execute = phone_execute
    })
    --==================================================================================================================
end)