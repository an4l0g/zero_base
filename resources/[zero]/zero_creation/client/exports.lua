IsMale = function(ped)
	if IsPedModel(ped, 'mp_m_freemode_01') then
		return true
    end
	return false
end
exports('IsMale', IsMale)