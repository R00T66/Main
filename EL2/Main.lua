repeat wait() until game.IsLoaded
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.Players.LocalPlayer.Character

wait(1.5)

local Kiriot = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))(); Kiriot.Boxes = false
local Player = game:GetService("Players").LocalPlayer;
local Camera = workspace.CurrentCamera;

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");

local Killbricks = {"ArdorianKillbrick", "KillBrick", "Lava", "Killbrickeeee"}

local Trinkets = {
 ["Goblet"] = false,
 ["Old Amulet"] = false
}

local Settings = {
 ["TrinketESP"] = false,
 ["PlayerESP"] = {
     Enabled = false
 },
 ["AutoPickup"] = false,
 ["EyeESP"] = false,
 ["NoFall"] = false,
 ["RemoveKB"] = false
}

local FlyEnabled = false
local FlySpeed = 40
local Noclip = false

local HttpService = game:GetService("HttpService")
local SaveSettingsLOL = function()
   writefile("EL2.Settings", HttpService:JSONEncode({
      MainSettings = Settings,
      TrinketSettings = Trinkets
   }))
end
local LoadSettingsLOL = function()
   if isfile("EL2.Settings") then
       local LoadSettings = HttpService:JSONDecode(readfile("EL2.Settings"))
       
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

LoadSettingsLOL();
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

-- page esp

local PAGE_SECTION_TOGGLES = PAGE_ESP:addSection("TOGGLES")
local PAGE_SECTION_TRINKET = PAGE_ESP:addSection("TRINKET-SETTINGS")

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

for i, v in pairs(Trinkets) do
   PAGE_SECTION_TRINKET:addToggle(i, Trinkets[i], function(value)
       Trinkets[i] = value
       SaveSettingsLOL()
   end)
end

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
		               
		               --if (Trinkets[TrinketName] == true) then
		                  Kiriot:Add(
		                   TrinketPart,
		                   {Name = TrinketName}
		                  )
		               --end
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
