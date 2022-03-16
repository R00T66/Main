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
                             Soulbound = tostring(JSON.SoulBound),
                             Enchant = JSON.Enchant                     
                           }
                            
                           print(Information.Enchant, Information.WeaponName, Information.WeaponID, Information.Soulbound)
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
