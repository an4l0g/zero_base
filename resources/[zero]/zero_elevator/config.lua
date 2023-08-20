cfg = {}

cfg.elevatorsConfiguration = {
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
    ['ORDEM'] = {
        elevatorName = 'Elevador Ordem',
        permission = 'ordem.permissao',
        locations = {
            {coord = vec3(5012.32,-5749.0,28.95), heading = 32.71, name = 'Escritório'},
            {coord = vec3(5012.76,-5746.9,15.49), heading = 219.92, name = 'Porão'}
        }
    },  
    ['LUX'] = {
        elevatorName = 'Elevador Lux',
        permission = nil,
        locations = {
            {coord = vec3(-326.967, 185.5648, 87.91724), heading = 32.71, name = 'Apartamento'},
            {coord = vec3(-338.3077, 191.5121, 103.6886), heading = 219.92, name = 'Porão'}
        }
    } 
}

cfg.elevatorsLocation = {
    {coord = vec3(-326.967, 185.5648, 87.91724), config = 'LUX'},
    {coord = vec3(-338.3077, 191.5121, 103.6886), config = 'LUX'},

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