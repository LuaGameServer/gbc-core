
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
-- local dbConfig = cc.import("#dbConfig")
-- local parse = cc.import("#parse")
-- local ParseConfig = parse.ParseConfig

MissionAction.ACCEPTED_REQUEST_TYPE = "websocket"

--登陆初始化
function MissionAction:login(args, redis)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local role = player:getRole()
    local role_data = role:get()
    local missions = player:getMissions()
    
    local lastTime = args.lastTime
    local loginTime = args.loginTime
    
    if not missions:Login(instance:getConnectId(), "mission.onLogin", lastTime, loginTime, role_data.id) then
        self:onLogin(args, redis)
    end
    return true
end

function MissionAction:onLogin(_args, _redis)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local role = player:getRole()
    local role_data = role:get()
    local missions = player:getMissions()
    missions:LoadAll(instance:getConnectId(), "mission.onLoad", role_data.id)
end

function MissionAction:onLoad(args, _redis)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local missions = player:getMissions()
    missions:updates(args)
    instance:sendPack("MissionList", {
        items = args
    })
end

function MissionAction:deleteAction(_args, _redis)
    
end

function MissionAction:finishAction(_args, _redis)
    
end

return MissionAction
