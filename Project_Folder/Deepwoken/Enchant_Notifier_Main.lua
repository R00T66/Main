--// ENCHANT NOTIFIER \\--
--// MADE BY METACALLED \\--

--// YOU MAY BE BLACKLISTED AT ANY TIME \\--
--//   (FOR ANY REASON THAT I SEE FIT)   \\--

if _G.EnchantConfig == nil then
 
   _G.EnchantConfig = {
    Webhook = "",
    DiscordID = 1
   }
 
end

local Deepwoken_Locations = {
 ["OVERWORLD"] = 6032399813,
 ["DEPTHS"] = 5735553160
}

local Library_Status = {
 ["Base64"] = false,
 ["Notifications"] = false,
 ["Events"] = false
}

-- LOADING --

local GameLoaded = game.IsLoaded
local Game = " "

if not GameLoaded then
   game.IsLoaded:Wait()
end

for i, PlaceID in pairs(Deepwoken_Locations) do
   if game.PlaceId == PlaceID then
      Game = i
   end 
end

if Game == " " then return end

-- SERVICES --

local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- LIBARIES LOADING --

local Directory = "https://raw.githubusercontent.com/R00T66/Main/main/Project_Folder/Deepwoken/Dependancies/"

local SuccessBase64,ReturnsBase64,Base64_Library = pcall(game.HttpGet, game, Directory .. "Base64_Library")
local SuccessNotification,ReturnsNotification,Notification_Library = pcall(game.HttpGet, game, Directory .. "Notifications_Library")
local SuccessEvents,ReturnsEvents,Events_Library = pcall(game.HttpGet, game, Directory .. "Events_Library")

-- LIBRARY FUNCTIONS --

local Success = function(Type, Misc)
   if Type == "Library" then
      Library_Status[Misc] = true
   end 
end

local Failed = function(Type, Misc)
   if Type == "Library" then
      Library_Status[Misc] = false

      game:GetService("Players").LocalPlayer:Kick("The following library ran into an error: '" .. Misc .. "'")
   end    
end

-- LIBARIES INIT --

if SuccessBase64 then
   Success("Library", "Base64")
 
   Base64_Library = loadstring(ReturnsBase64)()
else  
   Failed("Library", "Base64")

   return
end

if SuccessNotification then
   Success("Library", "Notifications")

   Notification_Library = loadstring(ReturnsNotification)()
else
   Failed("Library", "Notifications")

   return
end

if SuccessEvents then
   Success("Library", "Events")

   Events_Library = loadstring(ReturnsEvents)()
else
   Failed("Library", "Events")

   return
end

-- MAIN --

local Desert_Enchant = function(String)
   local STRING_FORMATTED = String:gsub("(.*)%@.*$","%1")

   return STRING_FORMATTED
end

local Desert_Name = function(String)
   local STRING_FORMATTED = String:gsub("(.*)%$.*$","%1")

   return STRING_FORMATTED
end

local Desert_Display = function(String)
   local STRING_FORMATTED = String:gsub("(.*){.*$","%1")

   return STRING_FORMATTED
end

local Template_String = function(Enchant, Tool, SoulBound, Player)
   
   local String = "Enchant: ENCHANT_NAME_THING\nTool: TOOL_NAME_THING\nSOULBOUND: SOUL_BOUND_THING\nPlayer: PLAYER_NAME_THING"

   String = String:gsub("ENCHANT_NAME_THING", Enchant)
   String = String:gsub("TOOL_NAME_THING", Tool)
   String = String:gsub("SOUL_BOUND_THING", tostring(SoulBound))
   String = String:gsub("PLAYER_NAME_THING", Player)

   return String
end

local GetGameName = function(Player_String)
   if Players:FindFirstChild(Player_String) then
     
      local Player = Players:FindFirstChild(Player_String)
  
      if Player.Character then
         if Player.Character:FindFirstChild("Humanoid") then
            return Desert_Display(Player.Character:FindFirstChild("Humanoid").DisplayName):gsub("\n", "")
         else
            repeat wait() until Player.Character:FindFirstChild("Humanoid")
         
            return Desert_Display(Player.Character:FindFirstChild("Humanoid").DisplayName):gsub("\n", "")
         end
      else
         repeat wait() until Player.Character
         repeat wait() until Player.Character:FindFirstChild("Humanoid")
         
         return Desert_Display(Player.Character:FindFirstChild("Humanoid").DisplayName):gsub("\n", "")
      end
   end
end

local CreateHook = function(Enchant_String, Enchant_Tool, Player_Name, SoulBound)
    
    local Data;
    
    if _G.EnchantConfig.Webhook ~= "" and _G.EnchantConfig.Webhook ~= nil then
        Data = {
            content = nil,
            embeds = {{
                title = "ENCHANT FOUND [ SOULBOUND: " .. SoulBound .. " ]",
                color = 65515,
                fields = {
                    {
                     name = "ENCHANT:",
                     value = "**" .. Enchant_String .. "**",
                     inline = false
                    },
                    {
                     name = "WEAPON:",
                     value = "**" .. Enchant_Tool .. "**",
                     inline = false
                    },
                    {
                     name = "PLAYER:",
                     value = "**" .. Player_Name .. "**",
                     inline = false
                    },       
                    {
                     name = "SERVER ID:",
                     value = "**" .. game["JobId"] .. "**",
                     inline = false
                    }               
                }
            }}
        } 
    else
       return "DISABLED"
    end
    
    if _G.EnchantConfig.DiscordID ~= 1 and _G.EnchantConfig.DiscordID ~= nil then
        Data.content = "<@" .. tostring(_G.EnchantConfig.DiscordID) .. ">"
    else
        Data.content = "@everyone"
    end
    
    return Data
end

local SendHook = function(Data)
    coroutine.resume(
        coroutine.create(function()
         if Data ~= "DISABLED" then
            local Request = syn.request({
              Url = _G.EnchantConfig.Webhook,
              Method = "POST",
              Headers = {
               ["Content-Type"] = "application/json"
              },
              Body = Events_Library:JSONEncode(Data)
            })
        
            print(Request.StatusCode)
         end
    end))
end

local CheckTool = function(Object, PlayerName)
   if Object:IsA("Tool") then      
      if Object:FindFirstChild("WeaponData") then
         
         local WeaponValue = Object:FindFirstChild("WeaponData").Value; WeaponValue = Desert_Enchant(Base64_Library:Decode(WeaponValue))
         local WeaponData = Events_Library:JSONDecode(WeaponValue)

         if WeaponData.Enchant ~= nil then
            
            if not WeaponData.SoulBound then
 
                local Enchant_String = tostring(WeaponData.Enchant)
                local Enchant_Tool = tostring(Desert_Name(Object.Name) .. " ( " .. string.split(Object.Name, "$")[2] .. ")")
                local Player_Name = PlayerName .. " [ " .. GetGameName(PlayerName) .. " ]"
                local SoulBound = tostring(false)
                local Data = CreateHook(Enchant_String, Enchant_Tool, Player_Name, SoulBound)
                
                SendHook(Data)
                Notifications_Library:SendNotification("Enchant Notifier", Template_String(Enchant_String, Enchant_Tool, SoulBound, PlayerName), UDim2.new(.5, -650, .5, 0), 9061754547)
            end
            
            if WeaponData.SoulBound then
                local Enchant_String = tostring(WeaponData.Enchant)
                local Enchant_Tool = tostring(Desert_Name(Object.Name)  .. " ( $" .. string.split(Object.Name, "$")[2] .. " )")
                local Player_Name = PlayerName .. " [ " .. GetGameName(PlayerName) .. " ]"
                local SoulBound = tostring(true)
                local Data = CreateHook(Enchant_String, Enchant_Tool, Player_Name, SoulBound)
          
      
                SendHook(Data)
                Notification_Library:SendNotification("Enchant Notifier", Template_String(Enchant_String, Enchant_Tool, SoulBound, PlayerName), UDim2.new(.5, -650, .5, 0), 8904888220)
            end
            
            return
         end
      end
   end
end

Events_Library:PlayerAdded():Connect(function(self)
    repeat wait() until self:FindFirstChild("Backpack")

    local Backpack = self:FindFirstChild("Backpack")
   
    for i, tool in pairs(Backpack:GetChildren()) do
       if self.UserId ~= Players.LocalPlayer.UserId then CheckTool(tool, self.Name) end
    end

    if self.UserId ~= Players.LocalPlayer.UserId then Backpack.ChildAdded:Connect(function(tool)
        if tool ~= nil then
           coroutine.resume(
               coroutine.create(function()
                   local yield = 0;
                   
                   repeat wait() until tool:FindFirstChild("WeaponData") or yield > 50 
                   
                   CheckTool(tool, self.Name)
               end)
           )
        end
    end) end
end)

for i, self in pairs(Players:GetPlayers()) do
    
    repeat wait() until self:FindFirstChild("Backpack")

    local Backpack = self:FindFirstChild("Backpack")
   
    for i, tool in pairs(Backpack:GetChildren()) do
       if self.UserId ~= Players.LocalPlayer.UserId then CheckTool(tool, self.Name) end
    end

    if self.UserId ~= Players.LocalPlayer.UserId then Backpack.ChildAdded:Connect(function(tool)
        if tool ~= nil then
           coroutine.resume(
               coroutine.create(function()
                   local yield = 0;
                   
                   repeat wait() until tool:FindFirstChild("WeaponData") or yield > 50 
                   
                   CheckTool(tool, self.Name)
               end)
           )
        end
    end) end
end

Notification_Library:SendNotification(
 "Enchant Notifier", 
 "SUCCESSFULLY LOADED [" .. Game .. "]", 
 UDim2.new(.5, -650, .5, 0), 
 0
)

local Information = [[ ]]
