cfg = {}

cfg.elevatorsConfiguration = {
    ['PM'] = {
        elevatorName = 'Elevador Polícia',
        permission = nil,
        locations = {
            {coord = vec3(2497.42,-349.15,94.1), heading = 312.81, name = 'Andar 1°'},
            {coord = vec3(2497.41,-349.29,101.9), heading = 309.71, name = 'Andar 3°'},
            {coord = vec3(2497.18,-349.32,105.7), heading = 313.05, name = 'Andar 4°'}
        }
    },
    ['HP'] = {
        elevatorName = 'Elevador Hospital',
        permission = nil,
        locations = {
            {coord = vec3(-777.84,-1219.09,7.34), heading = 43.73, name = 'Andar 1°'},
            {coord = vec3(-777.15,-1220.3,15.56), heading = 309.71, name = 'H'}
        }
    },
    ['PREDIO'] = {
        elevatorName = 'Elevador Apartamento',
        permission = 'rooftop.permissao',
        locations = {
            {coord = vec3(-770.94,319.73,85.67), heading = 171.82, name = 'Andar 1°'},
            {coord = vec3(-768.69,336.85,243.38), heading = 84.96, name = 'Andar 2°'}
        }
    },
    ['PREDIO2'] = {
        elevatorName = 'Elevador Apartamento',
        permission = 'rooftop2.permissao',
        locations = {
            {coord = vec3(-305.24,-721.37,28.03), heading = 156.39, name = 'Andar 1°'},
            {coord = vec3(-288.02,-722.61,125.48), heading = 247.23, name = 'Andar 2°'}
        }
    },
    ['CASSINO'] = {
        elevatorName = 'Elevador Cassino',
        permission = nil,
        locations = {
            {coord = vec3(973.09,31.21,71.85), heading = 139.07, name = 'Andar 1°'},
            {coord = vec3(965.04,58.56,112.56), heading = 50.87, name = 'Terraço'}
        }
    },
    ['CASSINO2'] = {
        elevatorName = 'Elevador Cassino',
        permission = nil,
        locations = {
            {coord = vec3(967.32,7.48,81.16), heading = 53.91, name = 'Garagem'},
            {coord = vec3(953.41,58.46,75.44), heading = 249.22, name = 'Escritório'}
        }
    },
    ['MILICIA'] = {
        elevatorName = 'Elevador Milicia',
        permission = 'milicia.permissao',
        locations = {
            {coord = vec3(380.98,-15.89,83.0), heading = 32.71, name = 'Garagem'},
            {coord = vec3(414.15,-14.7,99.65), heading = 219.92, name = 'Escritório'}
        }
    },
    ['ORDEM'] = {
        elevatorName = 'Elevador Ordem',
        permission = 'ordem.permissao',
        locations = {
            {coord = vec3(5012.32,-5749.0,28.95), heading = 32.71, name = 'Escritório'},
            {coord = vec3(5012.76,-5746.9,15.49), heading = 219.92, name = 'Porão'}
        }
    }   
}

cfg.elevatorsLocation = {
    {coord = vec3(2497.42,-349.15,94.1), config = 'PM'},
    {coord = vec3(2497.41,-349.29,101.9), config = 'PM'},
    {coord = vec3(2497.18,-349.32,105.7), config = 'PM'},
    {coord = vec3(2494.97,-347.02,94.1), config = 'PM'},
    {coord = vec3(2495.08,-346.93,101.9), config = 'PM'},
    {coord = vec3(2494.93,-346.93,105.7), config = 'PM'},
    {coord = vec3(2502.02,-339.81,94.1), config = 'PM'},
    {coord = vec3(2502.02,-339.82,101.9), config = 'PM'},
    {coord = vec3(2501.89,-339.7,105.69), config = 'PM'},
    {coord = vec3(2504.36,-342.16,94.1), config = 'PM'},
    {coord = vec3(2504.32,-342.2,101.9), config = 'PM'},
    {coord = vec3(2504.21,-342.21,105.69), config = 'PM'},

    {coord = vec3(-777.84,-1219.09,7.34), config = 'HP'},
    {coord = vec3(-777.15,-1220.3,15.56), config = 'HP'},

    {coord = vec3(-770.94,319.73,85.67), config = 'PREDIO'},
    {coord = vec3(-768.69,336.85,243.38), config = 'PREDIO'},

    {coord = vec3(-305.24,-721.37,28.03), config = 'PREDIO2'},
    {coord = vec3(-288.02,-722.61,125.48), config = 'PREDIO2'},

    {coord = vec3(973.09,31.21,71.85), config = 'CASSINO'},
    {coord = vec3(965.04,58.56,112.56), config = 'CASSINO'},

    {coord = vec3(967.32,7.48,81.16), config = 'CASSINO2'},
    {coord = vec3(953.41,58.46,75.44), config = 'CASSINO2'},
    
    {coord = vec3(380.98,-15.89,83.0), config = 'MILICIA'},
    {coord = vec3(414.15,-14.7,99.65), config = 'MILICIA'},

    {coord = vec3(5012.32,-5749.0,28.95), config = 'ORDEM'},
    {coord = vec3(5012.76,-5746.9,15.49), config = 'ORDEM'},
}