repeat wait() until game.IsLoaded

local Trigger = workspace:WaitForChild("MonsterSpawns"):WaitForChild("Triggers")

local CastleRock = Trigger :WaitForChild("BoundShrieker4") -- 1
local DeepSunken = Trigger:WaitForChild("evileye1") -- 2
local Sunken = Trigger:WaitForChild("evileye2") -- 3
local LavaSnake = Trigger:WaitForChild("MazeSnakes") -- 4

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
   local Acc = {1,3}
   
   if GetTime > 100000 then
      Set[Num].Value = "**INVALID**"
      
      return       
   end
   
   if GetTime >= 3000 and table.find(Acc, Num) then
      WEB.content = "<@" .. _G.discordid .. "> 50+ MINUTES CR or SUNKEN!"
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
   table.insert(plrs, v.Name)
end

table.insert(WEB.embeds[1].fields, {
  name = "Players:",
  value = "**" .. table.concat(plrs, ", ") .. "**"
})

local A = syn.request({
  Url = _G.webhook,
  Method = "POST",
  Headers = {
   ["Content-Type"] = "application/json"
  },
  Body = game:GetService("HttpService"):JSONEncode(WEB)
})