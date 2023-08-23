local vCLIENT = Tunnel.getInterface('Cam')

RegisterCommand('cam', function(source)
	local user_id = zero.getUserId(source)
	if (user_id) and zero.hasPermission(user_id, 'cam.permissao') or zero.hasPermission('+Staff.COO') then
		vCLIENT.openCam(source)
	end
end)