Proxy = module("zero","lib/Proxy")
Tunnel = module("zero", "lib/Tunnel")
zero = Proxy.getInterface('zero')
config = {}
config.serviceBlipCoords = vec3(-2070.085205, -1019.913269, 11.910712)

config.webhooks = {
    requestService = 'https://discord.com/api/webhooks/1129418939345158144/m3rLq64OGPNzIa7rIdMXcFYHDaOybiXDXrnV7-tDoIoLHVXKAl2cITaEox7iju-hPx--',
    cancelService = 'https://discord.com/api/webhooks/1129419277234094200/4XNrs8a7BCDxO_D79CZ4DEpyflei8mZq_yfyPa5yYGmKa4PU7D35cf_NHNA0RCIWu9ip',
    registerService = 'https://discord.com/api/webhooks/1129419440149233744/NGjVmYIHQunsgRFsJx6F3U6evAxaZ2RsCnWcfE4z3XF6x_Ky6JxjNn8fcNtZDdZOSE3s',
    acceptService = 'https://discord.com/api/webhooks/1129422834213601352/Hm7TCN9lescGJJCTGX7lINuhyn45MA08qe-exQMm4t947Sq46zQA6BXErWLuMqnDb8PD',
}