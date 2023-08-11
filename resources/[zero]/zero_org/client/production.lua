RegisterNUICallback('orderProducts', function(data, cb)
    cb(json.encode(gbProduction.orderProducts(data.fac, data.product, data.qtd)))
end)
