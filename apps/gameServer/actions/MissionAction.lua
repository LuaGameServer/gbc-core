
--[[
Copyright (c) 2015 gameboxcloud.com
Permission is hereby granted, free of chargse, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 
]]

local gbc = cc.import("#gbc")
local MissionAction = cc.class("MissionAction", gbc.ActionBase)
local dbConfig = cc.import("#dbConfig")
local parse = cc.import("#parse")
local ParseConfig = parse.ParseConfig

MissionAction.ACCEPTED_REQUEST_TYPE = "websocket"

--新增任务
function MissionAction:add(args, _redis)
    local instance = self:getInstance()
    if not args.cid or args.cid == 0 then
        --cc.printerror("not Mission id set")
        instance:sendError("NoneConfigID")
        return
    end
    local cid = args.cid
    
    local player = instance:getPlayer()
    local role = player:getRole()
    local missions = player:getMissions()
    local mission = missions:getOriginal(cid)
    if mission then
        cc.printerror("mission is all ready added:"..cid)
        return
    end
    
    mission = missions:get()
    local dt = mission:get()
    dt.rid = role:getID()
    dt.cid = cid
    local query = mission:insertQuery(dt)
    mission:pushQuery(query, instance:getConnectId(), "mission.onMissionNew")
end

function MissionAction:deleteMission(id)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local missions = player:getMissions()
    missions:delete(id)
    local mission = missions:get(id)
    local query = mission:deleteQuery({id = id})
    mission:pushQuery(query, instance:getConnectId())
end

function MissionAction:finishAction(args, redis)
    local instance = self:getInstance()
    local id = args.id
    if not id then
        instance:sendError("NoneID")
        return
    end
    
    local player = instance:getPlayer()
    local missions = player:getMissions()
    local mission = missions:get(id)
    if not mission then
        instance:sendError("NoneMission")
        return
    end
    
    local mission_data = mission:get()
    local cfg_mission = dbConfig.get("cfg_mission", mission_data.cid)
    if not cfg_mission then
        instance:sendError("NoneConfig")
        return
    end
    
    if mission_data.progress < cfg_mission.count then
        instance:sendError("Unfinished")
        return
    end
    
    --任务完成
    --1.增加奖励
    local rewardids = ParseConfig.ParseIDList(cfg_mission.rewardID)
    cc.dump(rewardids)
    --删除当前任务
    self:deleteMission(mission_data.id)
    --2.解锁下一个任务
    local nextids = ParseConfig.ParseIDList(cfg_mission.nextID)
    for _, cid in ipairs(nextids) do
        self:add({cid = cid}, redis)
    end
end

function MissionAction:onMissionNew(args, _redis)
    if args.err or not args.insert_id or args.insert_id <= 0 then
        return
    end
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local missions = player:getMissions()
    local mission = missions:get()
    local query = mission:selectQuery({id = args.insert_id})
    mission:pushQuery(query, instance:getConnectId(), "mission.onMission", {
        update = true,
    })
end

function MissionAction:onMission(args, _redis, params)
    if args.err then
        return
    end
    if params and params.update then
        local instance = self:getInstance()
        local player = instance:getPlayer()
        local missions = player:getMissions()
        local bupdate = missions:updates(args)
        if bupdate then
            instance:sendPack("Missions", {
                values = args,
            })
        end
    end
end

return MissionAction