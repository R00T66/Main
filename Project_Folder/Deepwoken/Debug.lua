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

RunService.RenderStepped:Connect(function(...)
    for i, v in pairs(Players:GetPlayers()) do
       if v:FindFirstChild("Backpack") then
          for i, x in pairs(v.Backpack:GetChildren()) do
             if x:IsA("Tool") then
                if x:FindFirstChild("WeaponData") then
                  
                  local WeaponData = x:WaitForChild("WeaponData").Value
                  local JSON = Decode_JSON(Adjust_Data(GetData(WeaponData)))
                
                  if v.Character then
                      if table.find(Enchants, WeaponData) and JSON.Enchant ~= nil then 
                           table.insert(Enchants, WeaponData);
                            
                           local Information = {
                             WeaponName = Adjust_Name(v.Name),
                             WeaponID = "$" .. string.split(v.Name, "$")[2],
                             Soulbound = tostring(JSON.SoulBound),
                             Enchant = JSON.Enchant                     
                           }
                            
                           print(Enchant, WeaponName, WeaponID, Soulbound)
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
