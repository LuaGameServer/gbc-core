
local BaseList = cc.import(".BaseList")
local Talents = cc.class("Talents", BaseList)
local Talent = cc.import(".Talent", ...)

local parse = cc.import("#parse")
local ParseConfig = parse.ParseConfig
local dbConfig = cc.import("#dbConfig")

function Talents:createItem()
    return Talent:new()
end

function Talents:Login(connectid, action, lastTime, loginTime, roleid)
    if not connectid or not lastTime or not loginTime or not roleid then
        return false, "NoParam"
    end
    local talent = self:get()
    local query = talent:selectQuery({rid = roleid})
    talent:pushQuery(query, connectid, action)
    return true
end

function Talents:LoadOne(connectid, action, id)
    if not connectid or not id then
        return false, "NoParam"
    end
    local talent = self:get()
    local query = talent:selectQuery({id = id})
    talent:pushQuery(query, connectid, action)
    return true
end

function Talents:UnlockItem(connectid, action, cid, level, role, props)
    if not connectid or not cid or not level or not role or not props then
        return false, "NoParam"
    end
    
    local cfg = dbConfig.get("cfg_talent", {
        id = cid,
        level = level,
    })
    if cfg == nil then
        return false, "NoneConfig"
    end
    
    local role_data = role:get()
    --检查消耗道具
    if role_data.diamond < cfg.diamond then
        return false, "LessDiamond"
    end
    if role_data.techPoint < cfg.tech then
        return false, "LessTech"
    end
    
    local items = ParseConfig.ParseProps(cfg.props)
    
    if not props:HasItems(items) then
        return false, "LessProp"
    end
    local talent = self:getByCID(cid)
    
    if talent then
        local _level = talent:get("level")
        if cfg.prelevel == _level then
            talent:set("level", cfg.level)
            local query = talent:updateQuery({id = talent:get("id")}, {level = cfg.level})
            talent:pushQuery(query, connectid, action, {update_id = talent:get("id")})
            role:AddData(connectid, nil, -cfg.tech, -cfg.diamond, 0)
            return props:UseItems(connectid, nil, items)
        end
    else
        if cfg.preId == 0 then
            talent = self:get()
            local query = talent:insertQuery({cid = cid, level = level, rid = role_data.id})
            talent:pushQuery(query, connectid, action)
            role:AddData(connectid, nil, -cfg.tech, -cfg.diamond, 0)
            return props:UseItems(connectid, nil, items)
        else
            talent = self:getByCID(cfg.preId)
            if talent then
                local _level = talent:get("level")
                local _cid = talent:get("cid")
                if cfg.prelevel == _level and cfg.preId == _cid then
                    local query = talent:insertQuery({cid = cid, level = level, rid = role_data.id})
                    talent:pushQuery(query, connectid, action)
                    role:AddData(connectid, nil, -cfg.tech, -cfg.diamond, 0)
                    return props:UseItems(connectid, nil, items)
                end
            else
                return false, "NoneID"
            end
        end
    end
    
    return false, "OperationNotPermit"
end

return Talents
