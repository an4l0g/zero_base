local cli = {}
Tunnel.bindInterface('Cam', cli)

local cam = nil

local offsetRotX = 0.0
local offsetRotY = 0.0
local offsetRotZ = 0.0

local offsetCoords = {}
offsetCoords.x = 0.0
offsetCoords.y = 0.0
offsetCoords.z = 0.0

local counter = 0
local precision = 1.0
local currPrecisionIndex
local precisions = {}
for i = Cam.minPrecision, Cam.maxPrecision + 0.01, Cam.incrPrecision do
    table.insert(precisions, tostring(i))
    counter = counter + 1
    if (tostring(i) == "1.0") then
        currPrecisionIndex = counter
    end
end

local speed = 1.0

local currFilter = 1
local currFilterIntensity = 10
local filterInten = {}
for i=0.1, 2.01, 0.1 do table.insert(filterInten, tostring(i)) end

local freeFly = false

local charControl = false

local isAttached = false
local entity
local camCoords

local pointEntity = false

-- menu variables
local _menuPool = NativeUI.CreatePool()
local camMenu

local itemCamPrecision

local itemFilter
local itemFilterIntensity

local itemAttachCam

local itemPointEntity

-- permissions
local whitelisted = nil

camMenu = NativeUI.CreateMenu('Zero Cam', 'Controle a Câmera Cinemática')
_menuPool:Add(camMenu)

local CamThread = function()
    Citizen.CreateThread(function()
        while (_menuPool:IsAnyMenuOpen()) do
            _menuPool:ProcessMenus()

            if (cam) then
                ProcessCamControls()
            end
            Citizen.Wait(1) 
        end
        _menuPool:Remove()
        ResetFilter()
        EndFreeCam()
        LocalPlayer.state.Cam = false
        TriggerServerEvent('zero_cam:disableCam')
    end)

    Citizen.CreateThread(function()
        while (_menuPool:IsAnyMenuOpen()) do
            if (camMenu:Visible() and cam) then
                local tempEntity = GetEntityInFrontOfCam()
                local txt = "-"
                if (DoesEntityExist(tempEntity)) then
                    txt = tostring(GetEntityModel(tempEntity))
                    if (IsEntityAVehicle(tempEntity)) then
                        txt = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(tempEntity)))
                    end
                end
                itemAttachCam:RightLabel(txt)

                if (isAttached and not DoesEntityExist(entity)) then
                    isAttached = false

                    ClearFocus()

                    StopCamPointing(cam)
                end
            end
            Citizen.Wait(500)
        end
    end)
end

function GenerateCamMenu()
    _menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    collectgarbage()
    
    camMenu = NativeUI.CreateMenu('Zero Cam', 'Controle a Câmera Cinemática')
    _menuPool:Add(camMenu)
    CamThread()

    local itemToggleCam = NativeUI.CreateCheckboxItem(Cam.strings.toggleCam, DoesCamExist(cam), Cam.strings.toggleCamDesc)
    camMenu:AddItem(itemToggleCam)

    itemCamPrecision = NativeUI.CreateListItem(Cam.strings.precision, precisions, currPrecisionIndex, Cam.strings.precisionDesc)
    camMenu:AddItem(itemCamPrecision)

    local submenuFilter = _menuPool:AddSubMenu(camMenu, Cam.strings.filter, Cam.strings.filterDesc)
    camMenu.Items[#camMenu.Items]:SetLeftBadge(15)
    itemFilter = NativeUI.CreateListItem(Cam.strings.filter, Cam.filterList, currFilter, Cam.strings.filterDesc)
    submenuFilter:AddItem(itemFilter)

    itemFilterIntensity = NativeUI.CreateListItem(Cam.strings.filterInten, filterInten, currFilterIntensity, Cam.strings.filterIntenDesc)
    submenuFilter:AddItem(itemFilterIntensity)

    local itemDelFilter = NativeUI.CreateItem(Cam.strings.delFilter, Cam.strings.delFilterDesc)
    submenuFilter:AddItem(itemDelFilter)

    local itemToggleFreeFlyMode = NativeUI.CreateCheckboxItem(Cam.strings.freeFly, freeFly, Cam.strings.freeFlyDesc)
    camMenu:AddItem(itemToggleFreeFlyMode)

    itemAttachCam = NativeUI.CreateItem(Cam.strings.attachCam, Cam.strings.attachCamDesc)
    camMenu:AddItem(itemAttachCam)
    
    local itemToggleCharacterControl = NativeUI.CreateCheckboxItem(Cam.strings.charControl, charControl, Cam.strings.charControlDesc)
    camMenu:AddItem(itemToggleCharacterControl)


    itemToggleCam.CheckboxEvent = function(menu, item, checked)
        ToggleCam(checked, GetGameplayCamFov())
    end

    itemCamPrecision.OnListChanged = function(menu, item, newindex)
        ChangePrecision(newindex)
    end
    
    itemToggleFreeFlyMode.CheckboxEvent = function(menu, item, checked)
        ToggleFreeFlyMode(checked)
    end

    camMenu.OnItemSelect = function(menu, item, index)
        if (item == itemAttachCam) then
            ToggleAttachMode()
        end
    end
    
    itemToggleCharacterControl.CheckboxEvent = function(menu, item, checked)
        ToggleCharacterControl(checked)
    end

    itemFilter.OnListChanged = function(menu, item, newindex)
        ApplyFilter(newindex)
    end

    itemFilterIntensity.OnListChanged = function(menu, item, newindex)
        ChangeFilterIntensity(newindex)
    end

    submenuFilter.OnItemSelect = function(menu, item, index)
        if (item == itemDelFilter) then
            ResetFilter()
        end
    end


    _menuPool:ControlDisablingEnabled(false)
    _menuPool:MouseControlsEnabled(false)

    _menuPool:RefreshIndex()
end



--------------------------------------------------
------------------- FUNCTIONS --------------------
--------------------------------------------------

-- initialize camera
function StartFreeCam(fov)
    ClearFocus()

    local playerPed = PlayerPedId()
    
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, fov * 1.0)

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, false)
    
    SetCamAffectsAiming(cam, false)

    if (isAttached and DoesEntityExist(entity)) then
        offsetCoords = GetOffsetFromEntityGivenWorldCoords(entity, GetCamCoord(cam))

        AttachCamToEntity(cam, entity, offsetCoords.x, offsetCoords.y, offsetCoords.z, true)
    end
end

-- destroy camera
function EndFreeCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    
    offsetRotX = 0.0
    offsetRotY = 0.0
    offsetRotZ = 0.0

    isAttached = false

    speed       = 1.0
    precision   = 1.0
    currFov     = GetGameplayCamFov()

    cam = nil
end

-- process camera controls
function ProcessCamControls()
    local playerPed = PlayerPedId()

    -- disable 1st person as the 1st person camera can cause some glitches
    DisableFirstPersonCamThisFrame()
    -- block weapon wheel (reason: scrolling)
    BlockWeaponWheelThisFrame()
    -- disable character/vehicle controls
    if (not charControl) then
        if (not LocalPlayer.state.Control) then LocalPlayer.state.Control = true; end;
        for k, v in pairs(Cam.disabledControls) do
            DisableControlAction(0, v, true)
        end
    else
        if (LocalPlayer.state.Control) then LocalPlayer.state.Control = false; end;
    end

    if (isAttached) then
        -- calculate new position
        offsetCoords = ProcessNewPosition(offsetCoords.x, offsetCoords.y, offsetCoords.z)
        
        -- focus entity
        SetFocusEntity(entity)

        -- set coords
        AttachCamToEntity(cam, entity, offsetCoords.x, offsetCoords.y, offsetCoords.z, true)

        if (Vdist(0.0, 0.0, 0.0, offsetCoords.x, offsetCoords.y, offsetCoords.z) > 40.0) then
            TriggerEvent('notify', 'Zero Cam', 'Você se <b>afastou</b> do seu personagem!')
            AttachCamToEntity(cam, entity, offsetCoords.x, offsetCoords.y, offsetCoords.z, true)
        end
        
        -- set rotation
        local entityRot = GetEntityRotation(entity, 2)
        SetCamRot(cam, entityRot.x + offsetRotX, entityRot.y + offsetRotY, entityRot.z + offsetRotZ, 2)
    else
        local camCoords = GetCamCoord(cam)
        local newPos = ProcessNewPosition(camCoords.x, camCoords.y, camCoords.z)

        SetFocusArea(newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0)
        SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
        SetCamRot(cam, offsetRotX, offsetRotY, offsetRotZ, 2)

        local distance = #(GetEntityCoords(PlayerPedId()) - camCoords)
        if (distance > 40) then
            TriggerEvent('notify', 'Zero Cam', 'Você se <b>afastou</b> do seu personagem!')
            EndFreeCam()
        end
    end
end

function ProcessNewPosition(x, y, z)
    local _x = x
    local _y = y
    local _z = z

    -- keyboard
    if (IsInputDisabled(0) and not charControl) then
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.forwards)) then
            local multX = Sin(offsetRotZ)
            local multY = Cos(offsetRotZ)
            local multZ = Sin(offsetRotX)

            _x = _x - (0.1 * speed * multX)
            _y = _y + (0.1 * speed * multY)
            if (freeFly) then
                _z = _z + (0.1 * speed * multZ)
            end
        end
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.backwards)) then
            local multX = Sin(offsetRotZ)
            local multY = Cos(offsetRotZ)
            local multZ = Sin(offsetRotX)

            _x = _x + (0.1 * speed * multX)
            _y = _y - (0.1 * speed * multY)
            if (freeFly) then
                _z = _z - (0.1 * speed * multZ)
            end
        end
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.left)) then
            local multX = Sin(offsetRotZ + 90.0)
            local multY = Cos(offsetRotZ + 90.0)
            local multZ = Sin(offsetRotY)

            _x = _x - (0.1 * speed * multX)
            _y = _y + (0.1 * speed * multY)
            if (freeFly) then
                _z = _z + (0.1 * speed * multZ)
            end
        end
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.right)) then
            local multX = Sin(offsetRotZ + 90.0)
            local multY = Cos(offsetRotZ + 90.0)
            local multZ = Sin(offsetRotY)

            _x = _x + (0.1 * speed * multX)
            _y = _y - (0.1 * speed * multY)
            if (freeFly) then
                _z = _z - (0.1 * speed * multZ)
            end
        end
        
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.up)) then
            _z = _z + (0.1 * speed)
        end
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.down)) then
            _z = _z - (0.1 * speed)
        end
        

        if (IsDisabledControlPressed(1, Cam.controls.keyboard.hold)) then
            -- hotkeys for speed
            if (IsDisabledControlPressed(1, Cam.controls.keyboard.speedUp)) then
                if ((speed + 0.1) < Cam.maxSpeed) then
                    speed = speed + 0.1
                else
                    speed = Cam.maxSpeed
                end
            elseif (IsDisabledControlPressed(1, Cam.controls.keyboard.speedDown)) then
                if ((speed - 0.1) > Cam.minSpeed) then
                    speed = speed - 0.1
                else
                    speed = Cam.minSpeed
                end
            end
        else
            -- hotkeys for FoV
            if (IsDisabledControlPressed(1, Cam.controls.keyboard.zoomOut)) then
                ChangeFov(1.0)
            elseif (IsDisabledControlPressed(1, Cam.controls.keyboard.zoomIn)) then
                ChangeFov(-1.0)
            end
        end
        
        -- rotation
        offsetRotX = offsetRotX - (GetDisabledControlNormal(1, 2) * precision * 8.0)
        offsetRotZ = offsetRotZ - (GetDisabledControlNormal(1, 1) * precision * 8.0)
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.rollLeft)) then
            offsetRotY = offsetRotY - precision
        end
        if (IsDisabledControlPressed(1, Cam.controls.keyboard.rollRight)) then
            offsetRotY = offsetRotY + precision
        end
    end

    if (offsetRotX > 90.0) then offsetRotX = 90.0 elseif (offsetRotX < -90.0) then offsetRotX = -90.0 end
    if (offsetRotY > 90.0) then offsetRotY = 90.0 elseif (offsetRotY < -90.0) then offsetRotY = -90.0 end
    if (offsetRotZ > 360.0) then offsetRotZ = offsetRotZ - 360.0 elseif (offsetRotZ < -360.0) then offsetRotZ = offsetRotZ + 360.0 end

    return {x = _x, y = _y, z = _z}
end

function ToggleCam(flag, fov)
    if (flag) then
        StartFreeCam(fov)
        _menuPool:RefreshIndex()
    else
        EndFreeCam()
        _menuPool:RefreshIndex()
    end
end

function ChangeFov(changeFov)
    if (DoesCamExist(cam)) then
        local currFov   = GetCamFov(cam)
        local newFov    = currFov + changeFov

        if ((newFov >= Cam.maxFov) and (newFov <= Cfg.maxFov)) then
            SetCamFov(cam, newFov)
        end
    end
end

function ChangePrecision(newindex)
    precision           = itemCamPrecision.Items[newindex]
    currPrecisionIndex  = newindex
end

function ToggleUI(flag)
    DisplayRadar(flag)
end

function ToggleFreeFlyMode(flag)
    freeFly = flag
end

function GetEntityInFrontOfCam()
    local camCoords = GetCamCoord(cam)
    local offset = {x = camCoords.x - Sin(offsetRotZ) * 100.0, y = camCoords.y + Cos(offsetRotZ) * 100.0, z = camCoords.z + Sin(offsetRotX) * 100.0}

    local rayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, offset.x, offset.y, offset.z, 10, 0, 0)
    local a, b, c, d, entity = GetShapeTestResult(rayHandle)
    return entity
end

function ToggleCharacterControl(flag)
    charControl = flag
end

function ToggleAttachMode()
    if (not isAttached) then
        entity = GetEntityInFrontOfCam()
        
        if (DoesEntityExist(entity)) then
            offsetCoords = GetOffsetFromEntityGivenWorldCoords(entity, GetCamCoord(cam))

            Citizen.Wait(1)
            local camCoords = GetCamCoord(cam)
            AttachCamToEntity(cam, entity, GetOffsetFromEntityInWorldCoords(entity, camCoords.x, camCoords.y, camCoords.z), true)

            isAttached = true
        end
    else
        ClearFocus()

        DetachCam(cam)

        isAttached = false
    end
end

function TogglePointing(flag)
    if (flag and isAttached) then
        pointEntity = true
        PointCamAtEntity(cam, entity, 0.0, 0.0, 0.0, 1)
    else
        pointEntity = false
        StopCamPointing(cam)
    end
end

function ApplyFilter(filterIndex)
    print('Apply', filterIndex)
    SetTimecycleModifier(Cam.filterList[filterIndex])
    currFilter = filterIndex
end

function ChangeFilterIntensity(intensityIndex)
    print('Change', intensityIndex)

    SetTimecycleModifier(Cam.filterList[currFilter])
    SetTimecycleModifierStrength(tonumber(filterInten[intensityIndex]))
    currFilterIntensity = intensityIndex
end

function ResetFilter()
    ClearTimecycleModifier()
    itemFilter._Index   = 1
    currFilter          = 1
    itemFilterIntensity._Index  = 10
    currFilterIntensity         = 10
end

cli.openCam = function()
    if (not _menuPool:IsAnyMenuOpen()) then
        LocalPlayer.state.Cam = true
        GenerateCamMenu()
        camMenu:Visible(true)
    end
end