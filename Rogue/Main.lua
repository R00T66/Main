repeat wait() until game.IsLoaded

local Trigger = workspace:WaitForChild("MonsterSpawns"):WaitForChild("Triggers")

local CastleRock = Trigger :WaitForChild("BoundShrieker4") -- 1
local DeepSunken = Trigger:WaitForChild("evileye1") -- 2
local Sunken = Trigger:WaitForChild("evileye2") -- 3
local LavaSnake = Trigger:WaitForChild("MazeSnakes") -- 4
local CRTrigger = Trigger:WaitForChild("CastleRockSnake") -- 1 EX

local CheckTable = {
 [1] = CastleRock,
 [2] = DeepSunken,
 [3] = Sunken,
 [4] = LavaSnake
}

local Set = {
 [1] = {
  Name = "Castle Rock",
  Value = 0 
 },
 [2] = {
  Name = "Deep Sunken",
  Value = 0 
 },
 [3] = {
  Name = "Sunken",
  Value = 0 
 },
 [4] = {
  Name = "Lava Snake",
  Value = 0 
 }
}

local plrs = {}

local WEB = {
 content = nil,
 embeds = {{
   title = "SERVER STATISTICS - LOOTING ",
   color = nil,
   fields = {
   
   }
 }}
}

local GetTimer = function(Part)

   local Wait = Part:WaitForChild("LastSpawned", 30)

   if Part:FindFirstChild("LastSpawned") and Wait ~= nil then
      return Part.LastSpawned.Value 
   else
      return "Invalid Timer"
   end
end

local GetTimeDifference = function(OS_Time)
   local Difference = os.difftime(os.time(), OS_Time)
   
   return Difference
end

local ToMinutes = function(Seconds)
   return ("%d:%02d"):format(math.floor(Seconds/60),Seconds%60)
end

local Check = function(Part, Num)
  
   local Timer = GetTimer(Part)
  
   if Timer == "Invalid Timer" then
      Set[Num].Value = "Invalid"
      
      return
   end

   local GetTime = GetTimeDifference(Timer)
   local CalcMin = ToMinutes(GetTime)
   
   if GetTime > 100000 then
      Set[Num].Value = "**[NEVER RAN]**"
      
      return       
   end
   
   if Num == 1 then
      
      if GetTime <= 119 then
         Set[Num].Value = "**CURRENTLY BEING RUN!**"
        
         return CalcMin
      end
    
      local TriggerTimer = GetTimer(CRTrigger)
      local TriggerDiff = GetTimeDifference(TriggerTimer)
      local TriggerMin = ToMinutes(TriggerDiff)
   
      if TriggerDiff > 100000 then
         TriggerMin = "UNKNOWN"
      elseif TriggerDiff <= 59 then
         TriggerMin = "NOW"
      end     
  
      if TriggerDiff >= 3000 then
         WEB.content = "<@" .. _G.discordid .. "> **50 MINUTE(S) UNBOTTED CR!**"
      end
      
      if (TriggerDiff / 60) < 40 and TriggerMin ~= "UNKNOWN" and _G.CRBOTTING == true then
     
         local Players = game.Players:GetPlayers()
         local Random = Players[math.random(1, #Players)]
   
         repeat wait() Random = Players[math.random(1, #Players)] until Random ~= game.Players.LocalPlayer
   
         local r = syn.request({Url = "http://localhost:7963/BlockUser?Account=" .. game.Players.LocalPlayer.Name .. "&UserId=" .. Random.UserId, Method = "GET"})
         
         warn(r.StatusCode)
         while wait() do game:GetService("TeleportService"):Teleport(3016661674) end
      end
  
      Set[Num].Value = CalcMin .. " **[ LAST ENTERED: " .. TriggerMin .. " ]**"
  
      return CalcMin
   end
  
   Set[Num].Value = CalcMin
   
   return CalcMin
end

for i, v in pairs(CheckTable) do
   Check(v, i)
end

for i = 1,#Set do
   local Place = Set[i].Name
   local LastRAN = Set[i].Value
   
   table.insert(WEB.embeds[1].fields, {
     name = Place .. ":",
     value = LastRAN
   })
end

for i, v in pairs(game.Players:GetPlayers()) do
   table.insert(plrs, {n = v.Name, i = v.UserId})
end

local LogFix = function(Table)
   return "[" .. Table.n .. "](https://www.roblox.com/users/" .. tostring(Table.i) .. "/profile)"
end

local LogPlayers = function()
   local String = ""
 
   for i = 1,#plrs do
      if i ~= #plrs then String = String .. LogFix(plrs[i]) .. ", " else String = String .. LogFix(plrs[i]) end
   end
   
   return String
end

WEB.embeds[1].description = "Players:\n\n**" .. LogPlayers() .. "**\n========================================================="

local A = syn.request({
  Url = _G.webhook,
  Method = "POST",
  Headers = {
   ["Content-Type"] = "application/json"
  },
  Body = game:GetService("HttpService"):JSONEncode(WEB)
})
