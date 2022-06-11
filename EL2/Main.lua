repeat wait() until game.IsLoaded
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.Players.LocalPlayer.Character

wait(1)

local Kiriot = loadstring(game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/EL2/Kiriot22.lua"))(); Kiriot.Boxes = false;
local Player = game:GetService("Players").LocalPlayer;
local Camera = workspace.CurrentCamera;

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players")

local Killbricks = {"ArdorianKillbrick", "KillBrick", "Lava", "Killbrickeeee"}
local TrinketESPHolder = { }
local Settings = {
 ["TrinketESP"] = true,
 ["TrinketEspColor"] = {255, 170, 0},
 ["PlayerESP"] = {
     Enabled = true,
     Color = {75, 0, 130}
 },
 ["AutoPickup"] = false,
 ["EyeESP"] = false,
 ["NoFall"] = false,
 ["RemoveKB"] = false
}
local UndetectedMods = {147536033}

local FlyEnabled = false
local FlySpeed = 40
local Noclip = false

local HttpService = game:GetService("HttpService")
local MakeRGB = function(Number)
   return math.floor(Number * 255)
end
local SaveSettingsLOL = function()
   writefile("EL2.Settings", HttpService:JSONEncode({
      MainSettings = Settings,
      TrinketSettings = Trinkets
   }))
end
local LoadSettingsLOL = function()
   if isfile("EL2.Settings") then
       
       local LoadSettings = HttpService:JSONDecode(readfile("EL2.Settings"))
       
       if LoadSettings.MainSettings["PlayerESP"].Color == nil then
          SaveSettingsLOL()
          
          return
       end
       
       if LoadSettings.MainSettings["TrinketEspColor"] == nil then
          SaveSettingsLOL()
          
          return
       end
       
       Settings = LoadSettings.MainSettings
       Trinkets = LoadSettings.TrinketSettings
   else
      writefile("EL2.Settings", HttpService:JSONEncode({
         MainSettings = Settings,
         TrinketSettings = Trinkets
      }))     
   end
end
local KillbrickHolder = Instance.new("Folder")
local KB = function(value)
   if not value then for i, v in pairs(KillbrickHolder:GetChildren()) do v.Parent = workspace end end
   if value then for i, v in pairs(workspace:GetDescendants()) do if table.find(Killbricks, v.Name) then
          v.Parent = KillbrickHolder
   end end end
end
local AdminRoles = {"admin", "dev", "god", "owner"}
local Check = function(Player)
    local InGroup;
    local Role;
    
    pcall(function()
        InGroup = Player:IsInGroup(12832629)
    end)
    
    if InGroup ~= false and InGroup ~= nil then
       pcall(function()
           Role = Player:GetRoleInGroup(12832629)
       end) 
       
       repeat wait() 
              pcall(function()
               Role = Player:GetRoleInGroup(12832629)
           end) 
       until Role ~= nil
       
       if table.find(AdminRoles, Role:lower()) then return Role:upper() else return false end
    else
       return false
    end
end
local ModAlert = function(Name, Role)
    
   local Func = Instance.new("BindableFunction")
   
   Func.OnInvoke = function(Text)
       if Text == "OK" then 
	       return
	    else
	       Player:Kick("\n[HOPPING]")
	       wait(1)
           loadstring(game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/EL2/Hop.lua"))()
       end
   end
   
   game:GetService("StarterGui"):SetCore("SendNotification", {
     Title = "MOD ALERT",
     Text = Name .. " [ " .. Role .. " ]",
     Button1 = "OK",
     Button2 = "HOP",
     Duration = 3000000,
     Callback = Func
   })
end

LoadSettingsLOL();

local SetColor = Settings["PlayerESP"].Color

Kiriot.Color = Color3.fromRGB(SetColor[1], SetColor[2], SetColor[3]);
Kiriot:Toggle(true);

local LIB = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local VEN = LIB.new("META-WARE [EL2]", 5013109572)

local PAGE_MAIN = VEN:addPage("MAIN", 5012544693)
local PAGE_ESP = VEN:addPage("ESP", 5012544693)

-- page main

local PAGE_SECTION_MOVEMENT = PAGE_MAIN:addSection("MOVEMENT")
local PAGE_SECTION_MOVEMENTSETTINGS = PAGE_MAIN:addSection("MOVEMENT-SETTINGS")
local PAGE_SECTION_MISC = PAGE_MAIN:addSection("MISC")

PAGE_SECTION_MOVEMENT:addToggle("FLY", false, function(value)
    FlyEnabled = value
end)
PAGE_SECTION_MOVEMENT:addToggle("NOCLIP", false, function(value)
    Noclip = value
end)
PAGE_SECTION_MOVEMENT:addToggle("NO-FALL", Settings["NoFall"], function(value)
    Settings["NoFall"] = value
    SaveSettingsLOL()
end)

PAGE_SECTION_MOVEMENTSETTINGS:addSlider("FLY-SPEED", 40, 1, 100, function(value)
    FlySpeed = value
end)

PAGE_SECTION_MISC:addToggle("REMOVE-KILLBRICKS", Settings["RemoveKB"], function(value)
    Settings["RemoveKB"] = value
    KB(value)
    SaveSettingsLOL()
end)


PAGE_SECTION_MISC:addToggle("AUTO-PICKUP", Settings["AutoPickup"], function(value)
    Settings["AutoPickup"] = value
    SaveSettingsLOL()
end)
PAGE_SECTION_MISC:addButton("WIPE", function(...)
    
    local Humanoid;
    local Fire = game:GetService("Workspace"):WaitForChild("Fires")
    
    if Player.Character then
       if Player.Character:FindFirstChild("Humanoid") then
          Humanoid = Player.Character:FindFirstChild("Humanoid")
       end
    end
     
    if Humanoid ~= nil then Humanoid.Health = 0 end
end)


-- page esp

local PAGE_SECTION_TOGGLES = PAGE_ESP:addSection("SETTINGS")
local PAGE_SECTION_CONFIGS = PAGE_ESP:addSection("CONFIG")

PAGE_SECTION_TOGGLES:addToggle("TRINKET ESP", Settings["TrinketESP"], function(value)
   Settings["TrinketESP"] = value
   SaveSettingsLOL()
end)
PAGE_SECTION_TOGGLES:addToggle("EYE ESP", Settings["EyeESP"], function(value)
   Settings["EyeESP"].Enabled = value
   Kiriot:Toggle(value)
   SaveSettingsLOL()
end)
PAGE_SECTION_TOGGLES:addToggle("PLAYER ESP", Settings["PlayerESP"], function(value)
   Settings["PlayerESP"].Enabled = value
   Kiriot.Players = value
   SaveSettingsLOL()
end)

-- Settings P1 2

PAGE_SECTION_CONFIGS:addColorPicker("Player-ESP", Color3.fromRGB(SetColor[1], SetColor[2], SetColor[3]), function(value)
    local Table = Settings["PlayerESP"].Color
    
    Table[1] = MakeRGB(value.R)
    Table[2] = MakeRGB(value.G)
    Table[3] = MakeRGB(value.B)
    
    SaveSettingsLOL()
    
    Kiriot.Color = Color3.fromRGB(Table[1], Table[2], Table[3])
end)

PAGE_SECTION_CONFIGS:addColorPicker("Trinkets-ESP", Color3.fromRGB(Settings["TrinketEspColor"][1], Settings["TrinketEspColor"][2], Settings["TrinketEspColor"][3]), function(value)
    local Table = Settings["TrinketEspColor"]
    
    Table[1] = MakeRGB(value.R)
    Table[2] = MakeRGB(value.G)
    Table[3] = MakeRGB(value.B)
    
    SaveSettingsLOL()
    
    local TrinketFolder = workspace.MouseIgnore
    
    for i, v in pairs(TrinketESPHolder) do
       pcall(function() v:Remove() end)
    end

    for i, v in pairs(TrinketFolder:GetDescendants()) do
       if v.Name == "TRINKETLOL" then v:Destroy() end
    end 
end)

local Keys = {W = 0, S = 0, D = 0, A = 0};

local function UpdateFlight()
    if (Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")) then 
        Dir = (Camera.CFrame.RightVector * (Keys.D - Keys.A) + Camera.CFrame.LookVector * (Keys.W - Keys.S));
        Player.Character.HumanoidRootPart.Velocity = (Dir * FlySpeed);
    end;
end;

UserInputService.InputBegan:Connect(function(inp, g)
    
    if g then return end
    
    if (inp.KeyCode == Enum.KeyCode.W) then 
        Keys.W = 1;
    end;
    if (inp.KeyCode == Enum.KeyCode.A) then 
        Keys.A = 1;
    end;
    if (inp.KeyCode == Enum.KeyCode.S) then 
        Keys.S = 1;
    end;
    if (inp.KeyCode == Enum.KeyCode.D) then 
        Keys.D = 1;
    end;
end)

UserInputService.InputEnded:Connect(function(inp, g)
    
    if g then return end
    
    if (inp.KeyCode == Enum.KeyCode.W) then 
        Keys.W = 0;
    end;
    if (inp.KeyCode == Enum.KeyCode.A) then 
        Keys.A = 0;
    end;
    if (inp.KeyCode == Enum.KeyCode.S) then 
        Keys.S = 0;
    end;
    if (inp.KeyCode == Enum.KeyCode.D) then 
        Keys.D = 0;
    end;
end)

RunService.Stepped:Connect(function()
    if (Noclip == true and Player.Character) then
		for i,v in pairs(Player.Character:GetDescendants()) do
			if (v:IsA('BasePart')) then v.CanCollide = false; end;
	    end;
    end;

    if (FlyEnabled == true and Player.Character and Player.Character:FindFirstChild("Torso") and Player.Character:FindFirstChild("HumanoidRootPart")) then 
        UpdateFlight();
    end;
    	if (Player.Character) then
		if Player.Character:FindFirstChild("HumanoidRootPart") then
		   
		   local TrinketFolder = workspace.MouseIgnore
		   
		   for i, v in pairs(TrinketFolder:GetDescendants()) do
		      if v.Name == "ClickPart" then
		       
		         if (Settings["AutoPickup"] == true) then
		            if (v.Position - Player.Character:FindFirstChild("HumanoidRootPart").Position).magnitude < 25 then
		               if v:FindFirstChildOfClass("ClickDetector") then
		                  fireclickdetector(v:FindFirstChildOfClass("ClickDetector"))
		               end
		            end
		         end
	            
		         if not v:FindFirstChild("TRINKETLOL") then
		            Instance.new("Folder", v).Name = "TRINKETLOL"
		            
		            if (Settings["TrinketESP"] == true) then
		                
		               local TrinketName = v.Parent.Name
		               local TrinketPart = v.Parent
		               local TrinketTab = Settings["TrinketEspColor"]
		               local TrinketColor = Color3.fromRGB(TrinketTab[1], TrinketTab[2], TrinketTab[3])

		               local Box = Kiriot:Add(
		                TrinketPart,
		                {
		                 Name = TrinketName, 
		                 Color = TrinketColor
		                }
		               )
		                
		               TrinketESPHolder[#TrinketESPHolder + 1] = Box
		            end
		            
		         end
		      end
		   end
		end
	end;
end)
local HKS;

HKS = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if method == ("FireServer") then
       if (Settings["NoFall"] == true and self.Parent.Name == ("FallDamage")) then
          return;
       end
    end
    
    return HKS(self, ...)
end)

-- INIT

VEN:SelectPage(VEN.pages[1], true)

-- EXTRA

local Client = Player
local PlayerGUI = Client:WaitForChild("PlayerGui")
local Leaderboard = PlayerGUI:WaitForChild("LeaderboardGui")
local Main = Leaderboard:WaitForChild("MainFrame"):WaitForChild("ScrollingFrame")

local SpectateFunction = function(Label)
   
   local Button;
   local Player;
   
   repeat wait() 
                pcall(function()
                    Button = Label:FindFirstChild("TextButton")
                end)
   until Button ~= nil
   
   repeat wait() 
                pcall(function()
                    ColorButton = Label:FindFirstChild("ActualPlayerLabel")
                end)
   until ColorButton ~= nil   
   
   repeat wait()
                pcall(function(...)
                    Player = Button.Parent:FindFirstChild("Player").Value
                end)
   until Player ~= nil
   
   Button.Visible = true
   Button.Transparency = 1
   
   Button.MouseButton1Down:Connect(function(...)
       local Humanoid;
       local Count = 0;
       
       for i, v in pairs(Main:GetDescendants()) do
          if v.Name == "PlayerLabel" then
             v.TextColor3 = Color3.fromRGB(107, 107, 107);
          end
          
          if v.Name == "ActualPlayerLabel" then
             v.TextColor3 = Color3.fromRGB(255, 255, 255)
          end
       end
       
       if Client.Character then
          repeat wait() 
                       pcall(function()
                           Count = Count + 1
                           Humanoid = Client.Character.Humanoid
                       end)
          until Humanoid ~= nil or Count > 350
       end
       
       if Humanoid == nil then 
           return 
       end
       
       if Camera.CameraSubject == Humanoid then
          if Player == Client then
             Camera.CameraSubject = Humanoid
          elseif Player ~= Client then 
             if Player.Character then
                if Player.Character:FindFirstChild("Head") then
                   ColorButton.TextColor3 = Color3.fromRGB(75, 0, 130)
                   Label.TextColor3 = Color3.fromRGB(75, 0, 130)
                   
                   Camera.CameraSubject = Player.Character:FindFirstChild("Head")
                end
             end
          end
       else
          Camera.CameraSubject = Humanoid
       end
   end)
end

Main.ChildAdded:Connect(function(v)
    SpectateFunction(v)
end)

for i, v in pairs(Main:GetChildren()) do
   SpectateFunction(v)
end

for i, v in pairs(Players:GetPlayers()) do
   if Check(v) ~= false then
      ModAlert(v.Name, Check(v))
   end
	
   if table.find(UndetectedMods, v.UserId) then
      ModAlert(v.Name, "UNDETECTED MOD")
   end
end

Players.PlayerAdded:Connect(function(v)
    if Check(v) ~= false then
       ModAlert(v.Name, Check(v))
    end
	
   if table.find(UndetectedMods, v.UserId) then
      ModAlert(v.Name, "UNDETECTED MOD")
   end
end)
