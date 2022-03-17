repeat wait() until game.IsLoaded
repeat wait() until game:GetService("Players").LocalPlayer

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Client = Players.LocalPlayer
local Enchants = { }

local Decode_JSON = function(Table)
   return HttpService:JSONDecode(Table) 
end

local Get_Data = function(Str)
   return syn.crypt.base64.decode(Str)
end

local Adjust_Data = function(String)
   local STRING_FORMATTED = String:gsub("(.*)%@.*$","%1")

   return STRING_FORMATTED
end

local Adjust_Name = function(String)
   local STRING_FORMATTED = String:gsub("(.*)%$.*$","%1")

   return STRING_FORMATTED
end

local Exists = function(Data)
   
   local Bool = false;
   
   for i, v in pairs(Enchants) do
      if v.Data == Data then
         Bool = true;
      end
   end
   
   return Bool
end

local Debounce = false
local Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbstractPoo/Main/main/Notifications.lua"))()
local Make_Sound = function(ID)
   local Sound = Instance.new("Sound", game:GetService("CoreGui"));
   Sound.SoundId = "rbxassetid://" .. ID;
   Sound.Volume = 2;
   Sound:Play()
   
   Sound.Stopped:Connect(function()
       Sound:Destroy() 
   end) 
end
local Notify_Enchant = function(Enchant, Weapon, SoulBound)

   if SoulBound == "YES" then
       Make_Sound("9123201396")
   else
       Make_Sound("9123218218")
   end
   
   repeat wait() until Debounce == false 
   
   Debounce = true 
   
   local Ex = "\n\n"
   local Line_One = "ENCHANT: <font color='rgb(60, 40, 200)'>" .. Enchant .. "</font>\n"
   local Line_Two = "WEAPON: <font color='rgb(60, 40, 200)'>" .. Weapon .. "</font>\n"
   local Line_Three = "SOULBOUND: <font color='rgb(60, 40, 200)'>" .. SoulBound .. "</font>\n"
   
   local String = Ex .. Line_One .. Line_Two .. Line_Three
   
   Notifications:notification{
    Title = "<font color='rgb(60, 40, 200)'>ENCHANT FOUND</font>",
    Description = String,
    Icon = 6023426926,
    Accept = {
     Text = "THX",
     Callback = function()
        Debounce = false        
     end
    }
   } 
end

RunService.RenderStepped:Connect(function(...)
    for i, v in pairs(Players:GetPlayers()) do
       if v:FindFirstChild("Backpack") then
          for i, x in pairs(v.Backpack:GetChildren()) do
             if x:IsA("Tool") then
                if x:FindFirstChild("WeaponData") then
                  
                  local WeaponData = x:WaitForChild("WeaponData").Value
                  local JSON = Decode_JSON(Adjust_Data(Get_Data(WeaponData)))
                
                  if v.Character then
                  
                      for i, table_check in pairs(Enchants) do 
                         if Players:FindFirstChild(table_check.Player) then
                            
                            local Player = Players:FindFirstChild(table_check.Player)
                            
                            if Player.Character then
                                if table_check.Tool.Parent == Player.Character then
                                   table.remove(Enchants, i)
                                end
                            end
                         else
                            table.remove(Enchants, i)
                         end
                      end
                      
                      if not Exists(WeaponData) and JSON.Enchant ~= nil then 
                           table.insert(Enchants, {Data = WeaponData, Tool = x, Player = v.Name});
                            
                           local Information = {
                             WeaponName = Adjust_Name(x.Name),
                             WeaponID = "$" .. string.split(x.Name, "$")[2],
                             Soulbound = nil,
                             Enchant = JSON.Enchant                     
                           }
                           
                           if JSON.SoulBound ~= nil then
                              Information.Soulbound = "YES"
                           else
                              Information.Soulbound = "NO"
                           end
                            
                           Notify_Enchant(Information.Enchant, Information.WeaponName .. " [ " .. Information.WeaponID .. " ]", Information.Soulbound)
                      else
                         -- NOTHING!!
                      end
                   end     
                end
             end
          end               
       end
    end
end)
