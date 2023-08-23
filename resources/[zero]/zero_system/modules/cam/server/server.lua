local vCLIENT = Tunnel.getInterface('Cam')

RegisterCommand('cam', function(source)
	local user_id = zero.getUserId(source)
	if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'cam.permissao' }) then
		exports.chat:DisableChat(source, false)
		vCLIENT.openCam(source)
	end
end)