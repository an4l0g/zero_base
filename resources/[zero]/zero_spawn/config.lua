config = {}

config.spawns = {
    ['Praca'] = {
        title = 'Garagem Praça',
        image = 'https://media.discordapp.net/attachments/1059878373737893918/1141215672257495060/image.png?width=914&height=582',
        coord = vector4(39.54726, -897.7846, 29.9707, 345.8268)
    },
    ['Pier'] = {
        title = 'Pier',
        image = 'https://media.discordapp.net/attachments/1059878373737893918/1141215480477122570/image.png?width=1055&height=656',
        coord = vector4(-1648.629, -994.2989, 13.00293, 229.6063)
    },
    ['Paleto'] = {
        title = 'Paleto Bay',
        image = 'https://media.discordapp.net/attachments/1059878373737893918/1141216080182915132/image.png?width=1095&height=689',
        coord = vector4(-767.2352, 5583.521, 33.59338, 82.20473)
    },
    ['Sandy'] = {
        title = 'Sandy Shores',
        image = 'https://media.discordapp.net/attachments/1059878373737893918/1141217250330816512/image.png?width=955&height=620',
        coord = vector4(328.8, 2613.073, 44.47839, 0)
    }
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')