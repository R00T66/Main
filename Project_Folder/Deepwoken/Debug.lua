repeat wait() until game.IsLoaded
repeat wait() until game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("CoreGui")

local ENCHANT_LOG = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Holder = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")
local Example = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

ENCHANT_LOG.Name = "ENCHANT_LOG"
ENCHANT_LOG.Parent = game:GetService("CoreGui")

Main.Name = "Main"
Main.Parent = ENCHANT_LOG
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BackgroundTransparency = 0.500
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.174590796, 0, 0.264705896, 0)
Main.Size = UDim2.new(0, 352, 0, 187)
Main.Active = true
Main.Draggable = true

Holder.Name = "Holder"
Holder.Parent = Main
Holder.Active = true
Holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Holder.BackgroundTransparency = 0.500
Holder.BorderSizePixel = 0
Holder.Position = UDim2.new(-0.00154555927, 0, 0.184491977, 0)
Holder.Size = UDim2.new(0, 352, 0, 152)
Holder.ScrollBarThickness = 3

UIListLayout.Parent = Holder
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 0.500
Title.BorderSizePixel = 0
Title.Size = UDim2.new(0, 352, 0, 34)
Title.Font = Enum.Font.Sarpanch
Title.Text = "ENCHANT HISTORY"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

Example.Name = "Example"
Example.Parent = Main
Example.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Example.BackgroundTransparency = 1.000
Example.Size = UDim2.new(0, 351, 0, 20)
Example.Font = Enum.Font.SourceSansBold
Example.Text = "PLAYER was seen with a EXAMPLE enchant [SOULBOUND: MYB]"
Example.TextColor3 = Color3.fromRGB(60, 40, 200)
Example.TextScaled = true
Example.TextSize = 10.000
Example.TextWrapped = true
Example.Visible = false

local function JTAKF_fake_script() -- UIListLayout.Update 
	local script = Instance.new('LocalScript', UIListLayout)

	script.Parent:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function(...)
	    local absoluteSize = script.Parent.AbsoluteContentSize
	    
	    script.Parent.Parent.CanvasSize = UDim2.new(0, absoluteSize.X, 0, absoluteSize.Y)
	end)
	
end

coroutine.wrap(JTAKF_fake_script)()

local Create_Log = function(Information, Type)
   if Type == "Weapon" then
       
       local Log = Example:Clone()
      
       Log.Text = Log.Text:gsub("PLAYER", Information.PlayerName)
       Log.Text = Log.Text:gsub("EXAMPLE", Information.Enchant)
       Log.Text = Log.Text:gsub("MYB", Information.Soulbound)
      
       Log.Parent = Holder
       Log.Visible = true
   else
       local Log = Example:Clone()
      
       Log.Text = Log.Text:gsub("PLAYER", Information.PlayerName)
       Log.Text = Log.Text:gsub("EXAMPLE", Information.Enchant)
       Log.Text = Log.Text:gsub("%[SOULBOUND: MYB%]", Information.HatDeclaration)
      
       Log.Parent = Holder
       Log.Visible = true       
   end
end

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
local Notify_Enchant = function(Player, Enchant, Weapon, SoulBound)

   if SoulBound == "YES" then
       Make_Sound("9123201396")
   else
       Make_Sound("9123218218")
   end
   
   repeat wait() until Debounce == false 
   
   Debounce = true 
   
   local Ex = "\n\n"
   local Line_Info = "PLAYER: <font color='rgb(60, 40, 200)'>" .. Player .. "</font>\n"
   local Line_One = "ENCHANT: <font color='rgb(60, 40, 200)'>" .. Enchant .. "</font>\n"
   local Line_Two = "WEAPON: <font color='rgb(60, 40, 200)'>" .. Weapon .. "</font>\n"
   local Line_Three = "SOULBOUND: <font color='rgb(60, 40, 200)'>" .. SoulBound .. "</font>\n"
   
   local String = Ex .. Line_Info .. Line_One .. Line_Two .. Line_Three
   
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
                             PlayerName = v.Name,
                             WeaponName = Adjust_Name(x.Name),
                             WeaponID = "$" .. string.split(x.Name, "$")[2],
                             Soulbound = nil,
                             Enchant = JSON.Enchant         
                           }
                           
                           local Log_Information = {
                            Enchant = JSON.Enchant,
                            Soulbound = nil,
                            PlayerName = v.Name
                           }
                           
                           if JSON.SoulBound ~= nil then
                              Information.Soulbound = "YES"
                              Log_Information.Soulbound = "YES"
                           else
                              Information.Soulbound = "NO"
                              Log_Information.Soulbound = "NO"
                           end
                            
                           Create_Log(Log_Information, "Weapon")
                           Notify_Enchant(Information.PlayerName, Information.Enchant, Information.WeaponName .. " [ " .. Information.WeaponID .. " ]", Information.Soulbound)
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
