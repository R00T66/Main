repeat wait() until game.IsLoaded
repeat wait() until game:GetService("Players").LocalPlayer

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Client = Players.LocalPlayer

local Enchants = { }

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
          if v:IsA("Tool") then
             if v:FindFirstChild("WeaponData") then
                local WeaponData = v:WaitForChild("WeaponData").Value
                local JSON = Decode_JSON(Adjust_Data(WeaponData))
                
                if table.find(Enchants, WeaponData) and JSON.Enchant ~= nil then 
                    table.insert(Enchants, WeaponData);
                            
                    local Information = {
                     WeaponName = Adjust_Name(v.Name),
                     WeaponID = "$" .. string.split(v.Name, "$")[2],
                     Soulbound = tostring(JSON.SoulBound),
                     Enchant = JSON.Enchant                     
                    }
                            
                    
                else
                            
                end          
             end
          end
       end
    end
end)
