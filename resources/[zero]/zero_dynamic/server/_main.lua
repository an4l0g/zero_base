sDynamic = {}
interactions = {}

Tunnel.bindInterface('zero_dynamic', sDynamic)

sDynamic.handleAction = function(action, value)
    interactions[action](value)
end