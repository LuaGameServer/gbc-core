
local gbc = cc.import("#gbc")
local TalentAction = cc.class("TalentAction", gbc.ActionBase)
-- local dbConfig = cc.import("#dbConfig")
-- local parse = cc.import("#parse")
-- local ParseConfig = parse.ParseConfig

TalentAction.ACCEPTED_REQUEST_TYPE = "websocket"

function TalentAction:OnLoad(args, _redis)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local talents = player:getTalents()
    if args then
        talents:updates(args)
    end
    instance:sendPack("Talents", {
        items = args
    })
end

function TalentAction:login(args)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local role = player:getRole()
    local role_data = role:get()
    local talents = player:getTalents()
    
    local lastTime = args.lastTime
    local loginTime = args.loginTime
    
    return talents:Login(instance:getConnectId(), "talent.OnLoad", lastTime, loginTime, role_data.id)
end

--解锁操作
function TalentAction:unlockAction(args)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local role = player:getRole()
    local talents = player:getTalents()
    local props = player:getProps()
    --正在解锁中
    if talents:IsLocked() then
        return false, "NoAccept"
    end
    
    local ok, err, props = talents:UnlockItem(instance:getConnectId(), "talent.OnUnlock", args.cid, args.level, role, props)
    if ok then
        talents:Lock()
        
        if props then
            instance:sendPack("Props", {
                items = props,
            })
        end
        instance:sendPack("Role", role:get())
    end
    
    return ok, err
end

function TalentAction:OnUnlock(args, _redis, params)
    local id
    if params and params.update_id then
        id = params.update_id
    else
        id = args.insert_id
    end
    
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local talents = player:getTalents()
    
    return talents:LoadOne(instance:getConnectId(), "talent.OnLoadOne", id)
end

function TalentAction:OnLoadOne(args, _redis)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local talents = player:getTalents()
    if args then
        talents:updates(args)
    end
    talents:UnLock()
    instance:sendPack("Talents", {
        items = args
    })
end

return TalentAction
