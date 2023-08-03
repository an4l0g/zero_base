local tempCam;

Cam = function(offset, bone)
    if (not DoesCamExist(tempCam)) then
        local ped = PlayerPedId()
        local coordsCam = GetOffsetFromEntityInWorldCoords(ped, offset.x, offset.y, offset.z)
        
        tempCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
        SetCamCoord(tempCam, coordsCam)
        PointCamAtPedBone(tempCam, ped, 31086, bone.x, bone.y, bone.z, false)

        SetCamActive(tempCam, true)
        RenderScriptCams(true, true, 500, true, true)
    end
end
exports('CreateCam', Cam)

DeleteCam = function(render)
    SetCamActive(tempCam, false)
    if (render) then 
        RenderScriptCams(false, true, 0, true, true)
    end
	tempCam = nil
end
exports('DeleteCam', DeleteCam)