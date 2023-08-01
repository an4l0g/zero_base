local webhook = config.webhooks

zero.webhook = function(link, message)
    if (message and link) and link ~= '' then
        if (webhook[link]) then
            PerformHttpRequest(webhook[link], function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
        end
    end
end
exports('webhook', zero.webhook)

zero.formatWebhook = function(url, title, body)
    local currentBody = '```prolog\n['..string.upper(title)..']\n'
    for k,v in ipairs(body) do
        currentBody = currentBody..'\n['..string.upper(v[1])..']: '..string.upper(v[2])
    end
    currentBody = currentBody..os.date('\n\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'```'
    if (currentBody and url) and url ~= '' then
        if (webhook[url]) then
		    PerformHttpRequest(webhook[url], function(err, text, headers) end, 'POST', json.encode({ content = currentBody }), { ['Content-Type'] = 'application/json' })
	    end
    end
end