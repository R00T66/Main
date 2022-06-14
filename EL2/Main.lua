-- EL2 METAWARE VERSION 2!!!!
-- Auto Execute Friendly

repeat wait() until game.IsLoaded
repeat wait() until game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.Character

-- Services

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Locales

local Client = Players["LocalPlayer"]
local TrinketFolder = workspace:WaitForChild("MouseIgnore")
local EyeFolder = workspace:WaitForChild("EyeList")
local PlayerGUI = Client:WaitForChild("PlayerGui")
local Leaderboard = PlayerGUI:WaitForChild("LeaderboardGui")
local Main = Leaderboard:WaitForChild("MainFrame"):WaitForChild("ScrollingFrame")
local Camera;
local ESP;

repeat wait() pcall(function() Camera = workspace.CurrentCamera; end) until Camera ~= nil

-- Tables

local Settings = {
 ["Save"] = {
  ["ESP"] = {
   ["Enabled_Player"] = true,
   ["Enabled_Trinket"] = true,
   ["Enabled_Eyes"] = true
  },
  ["ESP_Settings"] = {
   ["Color_Player"] = {75, 0, 130}, 
   ["Color_Trinket"] = {255, 170, 0},
   ["Color_Eyes"] = {255, 170, 0}
  },
  ["Misc"] = {
   ["AP"] = false,
   ["RKB"] = false,
   ["NF"] = false
  } 
 },
 ["General"] = {
  ["Flying"] = false,
  ["Speed"] = false,
  ["Noclip"] = false,
  ["Flyspeed"] = 40,
  ["WalkSpeed"] = 50,
 },
 ["Information"] = {
  ["MODS"] = {
   ["UNDETECTED"] = {147536033},
   ["ROLES"] = {"admin", "god", "dev", "owner"}
  },
  ["KILLBRICKS"] = {
   "ArdorianKillbrick", 
   "KillBrick", 
   "Lava", 
   "Killbrickeeee"
  },
  ["BOX_HOLDER"] = {
   ["Trinkets"] = { },
   ["Eyes"] = { }
  }
 }
}
local Keys = {
    W = 0, 
    S = 0, 
    A = 0, 
    D = 0
}

-- Assets

local KBHolder = Instance.new("Folder");

-- Settings Functions

local SaveFile = "EL2.Settings"

local Save_Settings = function()
   writefile("EL2.Settings", HttpService:JSONEncode({
      Settings = Settings["Save"]
   }))
end
local Load_Settings = function()
   if isfile(SaveFile) then

      local Contents;
      local Success, Error = pcall(function()
          Contents = HttpService:JSONDecode(readfile(SaveFile)).Settings
      end)
   
      if not Success or Contents == nil then
         
         writefile(SaveFile, HttpService:JSONEncode({
            Settings = Settings["Save"]
         }))

         return
      end

      if Contents ~= nil then
	 if Contents["MainSettings"] ~= nil then
	    Save_Settings()
	
	    StarterGui:SetCore("SendNotification", {Title = "WELCOME", Text = "Welcome to META WARE V2!", Duration = 15})
	    return
	 end
			
         if Contents["Misc"] == nil then
            Save_Settings()
            
	    StarterGui:SetCore("SendNotification", {Title = "ERROR", Text = "INVALID SETTINGS! They have been reset.", Duration = 30})
            return
         end
      end 
 
      if Success then
         Settings["Save"] = Contents
      end
   else
      writefile("EL2.Settings", HttpService:JSONEncode({
         Settings = Settings["Save"]
      }))
   end
end

-- Functions

local SKB = function(Value)
   if Value then
      for i, v in pairs(workspace:GetDescendants()) do
         if table.find(Settings["Information"]["KILLBRICKS"], v.Name) then
            
	        local Obj = Instance.new("ObjectValue", v);
	        Obj.Name = "OriginalParent"
            Obj.Value = v.Parent; 

            v.Parent = KBHolder
         end 
      end
   else
      for i, v in pairs(KBHolder:GetChildren()) do
         v.Parent = v:FindFirstChild("OriginalParent").Value;
         v:FindFirstChild("OriginalParent"):Destroy()
      end
   end
end
local SMA = function(Name, Role)
   local BindableFunction = Instance.new("BindableFunction")

   BindableFunction.OnInvoke = function(Text)
      if Text:lower() == "ok" then
          return
      else
	    Client:Kick("\n[HOPPING]"); wait(1);
          loadstring(game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/EL2/Hop.lua"))()
      end
   end

   StarterGui:SetCore("SendNotification", {
     Title = "MOD ALERT",
     Text = Name .. " [ " .. Role .. " ]",
     Button1 = "OK",
     Button2 = "SERVER HOP",
     Duration = 3000000,
     Callback = BindableFunction
   })   
end
local MRGB = function(Number)
   return math.floor(Number * 255)
end
local UpdateFlight = function()
    if (Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")) then 
        Dir = (Camera.CFrame.RightVector * (Keys.D - Keys.A) + Camera.CFrame.LookVector * (Keys.W - Keys.S));
        Client.Character.HumanoidRootPart.Velocity = (Dir * Settings["General"]["Flyspeed"]);
    end;
end
local FlyIB = function(inp, g)
    if g then return end
    
    if (inp.KeyCode == Enum.KeyCode.W) then 
        Keys.W = 1
    end;
    if (inp.KeyCode == Enum.KeyCode.A) then 
        Keys.A = 1
    end;
    if (inp.KeyCode == Enum.KeyCode.S) then 
        Keys.S = 1
    end;
    if (inp.KeyCode == Enum.KeyCode.D) then 
        Keys.D = 1
    end;
end
local FlyIE = function(inp, g)
    if g then return end
    
    if (inp.KeyCode == Enum.KeyCode.W) then 
        Keys.W = 0
    end;
    if (inp.KeyCode == Enum.KeyCode.A) then 
        Keys.A = 0
    end;
    if (inp.KeyCode == Enum.KeyCode.S) then 
        Keys.S = 0
    end;
    if (inp.KeyCode == Enum.KeyCode.D) then 
        Keys.D = 0
    end;
end
local FullyLoaded = false
local SecondService = function(...)
 
   local Noclip = Settings["General"]["Noclip"]
   
   if (Noclip == true and FullyLoaded and Client.Character) then
	  for i,v in pairs(Client.Character:GetDescendants()) do
	     if (v:IsA("BasePart")) then v.CanCollide = false end
	  end
   end
end
local MainService = function(...)
   
   local TrnktT = Settings["Save"]["ESP_Settings"]["Color_Trinket"] 
   local TrnktH = Settings["Information"]["BOX_HOLDER"]["Trinkets"]
   local EyeCOL = Settings["Save"]["ESP_Settings"]["Color_Eyes"] 
   local EyeHOL = Settings["Information"]["BOX_HOLDER"]["Eyes"]
   local AutoPI = Settings["Save"]["Misc"]["AP"]
   local TriESP = Settings["Save"]["ESP"]["Enabled_Trinket"]
   local Flying = Settings["General"]["Flying"]

   if (Flying == true and Client.Character and Client.Character:FindFirstChild("Torso") and Client.Character:FindFirstChild("HumanoidRootPart")) then 
      UpdateFlight()
   end
   
   for i, v in pairs(TrinketFolder:GetChildren()) do
     if (AutoPI or TriESP) then
          
      if (v:GetChildren()[1] ~= nil and v:GetChildren()[1]:FindFirstChild("ClickPart")) then
            
         local v = v:GetChildren()[1]:FindFirstChild("ClickPart"):WaitForChild("Clicker")
         local TrinketPart = v.Parent
         local TrinketName = TrinketPart.Parent.Name
         local TrinketColor = Color3.fromRGB(TrnktT[1], TrnktT[2], TrnktT[3])
 
          
         if AutoPI then
            if Client.Character:FindFirstChild("HumanoidRootPart") then
                  
               local Root = Client.Character:FindFirstChild("HumanoidRootPart")

               if (Root.Position - TrinketPart.Position).magnitude < 25 then
                  fireclickdetector(v)
               end
            end
         end

         if not v:FindFirstChild("TrinketLol") and TriESP then            
            Instance.new("BoolValue", v).Name = "TrinketLol"
               
            local Box = ESP:Add(TrinketPart, {
              Name = TrinketName,
              Color = TrinketColor
            })

            TrnktH[#TrnktH + 1] = Box
         end
      end
   end
end

      for i, v in pairs(EyeFolder:GetDescendants()) do
         if v:IsA("ClickDetector") and Settings["Save"]["ESP"]["Enabled_Eyes"] then
                
            local Model = v.Parent
            local PrimaryPart;

            if Model:FindFirstChild("Part") then
               PrimaryPart = Model:FindFirstChild("Part")
            end


            if Model:FindFirstChild("Union") then
               PrimaryPart = Model:FindFirstChild("Union")
            end

            if PrimaryPart ~= nil then
               if PrimaryPart.Transparency == 0 then
                  if not v:FindFirstChild("EyeLol") then
                     local Tag = Instance.new("BoolValue", v)
                     Tag.Name = "EyeLol"

                     local Box = ESP:Add(PrimaryPart, {
                       Name = Model.Name:upper() .. " EYE",
                       Color = Color3.fromRGB(EyeCOL[1], EyeCOL[2], EyeCOL[3])
                     })
                     
                     table.insert(EyeHOL, Box)

                     local Signal;

                     Signal = PrimaryPart:GetPropertyChangedSignal("Transparency"):Connect(function(...)
                         if PrimaryPart.Transparency ~= 0 then
                            Box:Remove()
                            Signal:Disconnect()
                         end
                     end)
                  end
               end
            end
         end
      end
   end

local Hook;
local MainHook = function(self, ...)
   local Method = getnamecallmethod()

   if Method == "FireServer" then
      if self.Parent.Name == "FallDamage" then
         return
      end
   end

   return Hook(self, ...)
end
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
       
       if table.find(Settings["Information"]["MODS"]["ROLES"], Role:lower()) then return Role:upper() else return false end
    else
       return false
    end
end
local MainCheck = function(Player)
   if Check(Player) ~= false then
      SMA(Player, Check(Player))
   end
   
   if table.find(Settings["Information"]["MODS"]["UNDETECTED"], Player.userId) then
      SMA(Player, "SILENT")
   end
end
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

-- Setup

Load_Settings();

local PlayerColor = Settings["Save"]["ESP_Settings"]["Color_Player"]

ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/EL2/Kiriot22.lua"))();
ESP.Boxes = false;
ESP.Tracers = false;
ESP.Color = Color3.fromRGB(PlayerColor[1], PlayerColor[2], PlayerColor[3])

ESP:Toggle(true)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local GUIPage = Library.new("META WARE [ EL2 ]", 5013109572)

local MAIN = GUIPage:addPage("MAIN")
local ESP = GUIPage:addPage("ESP")

local MAIN_MOVEMENT = MAIN:addSection("MOVEMENT")
local MAIN_MSETTINGS = MAIN:addSection("MOVEMENT SETTINGS")
local MAIN_MISC = MAIN:addSection("MISC")
local MAIN_GENERAL_TABLE = Settings["General"]
local MAIN_MISC_TABLE = Settings["Save"]["Misc"]

local ESP_ENABLE = ESP:addSection("TOGGLE")
local ESP_SETTINGS = ESP:addSection("SETTINGS")
local ESP_ENABLE_TABLE = Settings["Save"]["ESP"]
local ESP_COLOR_TABLE = Settings["Save"]["ESP_Settings"]

-- MOVEMENT

local FlyToggle = MAIN_MOVEMENT:addToggle("FLY", false, function(Value)
    MAIN_GENERAL_TABLE["Flying"] = Value
end)

local NoclipToggle = MAIN_MOVEMENT:addToggle("NOCLIP", false, function(Value)
    MAIN_GENERAL_TABLE["Noclip"] = Value
end)

local SpeedToggle = MAIN_MOVEMENT:addToggle("SPEED", false, function(Value)
    MAIN_GENERAL_TABLE["Speed"] = Value
end)

-- MOVEMENT SETTINGS

local FlySpeed = MAIN_MSETTINGS:addSlider("FLY SPEED", 60, 10, 100, function(Value)
    MAIN_GENERAL_TABLE["Flyspeed"] = Value
end)

local WSSpeed = MAIN_MSETTINGS:addSlider("WALK SPEED", 60, 10, 100, function(Value)
    MAIN_GENERAL_TABLE["WalkSpeed"] = Value
end)

-- MISC

local AP = MAIN_MISC:addToggle("AUTO PICKUP", Settings["Save"]["Misc"]["AP"], function(Value)
    MAIN_MISC_TABLE["AP"] = Value
    Save_Settings()
end)

local NF = MAIN_MISC:addToggle("NO FALL", Settings["Save"]["Misc"]["AP"], function(Value)
    MAIN_MISC_TABLE["NF"] = Value
    Save_Settings()
end)

local NF = MAIN_MISC:addToggle("REMOVE KILLBRICKS", Settings["Save"]["Misc"]["RKB"], function(Value)
    MAIN_MISC_TABLE["RKB"] = Value
    SKB(Value)
    Save_Settings()
end)

-- ENABLES

ESP_ENABLE:addToggle("Players", ESP_ENABLE_TABLE["Enabled_Player"], function(Value)
    ESP_ENABLE_TABLE["Enabled_Player"] = Value
    Save_Settings()
end)

ESP_ENABLE:addToggle("Trinkets", ESP_ENABLE_TABLE["Enabled_Trinket"], function(Value)
    ESP_ENABLE_TABLE["Enabled_Trinket"] = Value
    
    Save_Settings()
    
    for i, v in pairs(Settings["Information"]["BOX_HOLDER"]["Trinkets"]) do
       if v ~= nil then v:Remove() end
    end
    
    for i, v in pairs(TrinketFolder:GetDescendants()) do
       if v.Name == "TrinketLol" then
          v:Destroy()
       end
    end
end)

ESP_ENABLE:addToggle("Eyes", ESP_ENABLE_TABLE["Enabled_Eyes"], function(Value)
    ESP_ENABLE_TABLE["Enabled_Eyes"] = Value

    Save_Settings()
    
    for i, v in pairs(Settings["Information"]["BOX_HOLDER"]["Eyes"]) do
       if v ~= nil then v:Remove() end
    end
    
    for i, v in pairs(EyeFolder:GetDescendants()) do
       if v.Name == "EyeLol" then
          v:Destroy()
       end
    end
end)

-- ESP SETTINGS

local PLRColor = ESP_COLOR_TABLE["Color_Player"]
local TRNColor = ESP_COLOR_TABLE["Color_Trinket"]
local EYEColor = ESP_COLOR_TABLE["Color_Eyes"]

ESP_SETTINGS:addColorPicker("PLAYER COLOR", Color3.fromRGB(PLRColor[1], PLRColor[2], PLRColor[3]), function(Value)
    ESP_COLOR_TABLE["Color_Player"][1] = MRGB(Value.R)
    ESP_COLOR_TABLE["Color_Player"][2] = MRGB(Value.G)
    ESP_COLOR_TABLE["Color_Player"][3] = MRGB(Value.B)
    
    ESP.Color = Color3.fromRGB(ESP_COLOR_TABLE["Color_Player"][1], ESP_COLOR_TABLE["Color_Player"][2], ESP_COLOR_TABLE["Color_Player"][3])
    Save_Settings()
end)

ESP_SETTINGS:addColorPicker("TRINKET COLOR", Color3.fromRGB(TRNColor[1], TRNColor[2], TRNColor[3]), function(Value)
    ESP_COLOR_TABLE["Color_Trinket"][1] = MRGB(Value.R)
    ESP_COLOR_TABLE["Color_Trinket"][2] = MRGB(Value.G)
    ESP_COLOR_TABLE["Color_Trinket"][3] = MRGB(Value.B) 
    
    Save_Settings()
    
    for i, v in pairs(Settings["Information"]["BOX_HOLDER"]["Trinkets"]) do
       if v ~= nil then v:Remove() end
    end
    
    for i, v in pairs(TrinketFolder:GetDescendants()) do
       if v.Name == "TrinketLol" then
          v:Destroy()
       end
    end
end)

ESP_SETTINGS:addColorPicker("EYES COLOR", Color3.fromRGB(EYEColor[1], EYEColor[2], EYEColor[3]), function(Value)
    ESP_COLOR_TABLE["Color_Eyes"][1] = MRGB(Value.R)
    ESP_COLOR_TABLE["Color_Eyes"][2] = MRGB(Value.G)
    ESP_COLOR_TABLE["Color_Eyes"][3] = MRGB(Value.B) 

    Save_Settings()
    
    for i, v in pairs(Settings["Information"]["BOX_HOLDER"]["Eyes"]) do
       if v ~= nil then v:Remove() end
    end
    
    for i, v in pairs(EyeFolder:GetDescendants()) do
       if v.Name == "EyeLol" then
          v:Destroy()
       end
    end
end)

-- Connects

RunService.Stepped:Connect(SecondService);
RunService.RenderStepped:Connect(MainService);
UserInputService.InputBegan:Connect(FlyIB);
UserInputService.InputEnded:Connect(FlyIE);
Players.PlayerAdded:Connect(MainCheck);
SKB(Settings["Save"]["Misc"]["RKB"]);
Main.ChildAdded:Connect(SpectateFunction);

coroutine.resume(
 coroutine.create(
  function()
      
     pcall(function(...)
         for i, v in pairs(Main:GetChildren()) do SpectateFunction(v) end
         for i, v in pairs(Players:GetPlayers()) do MainCheck(v) end   
     end)
     
     wait(1)
     
     FullyLoaded = true
     
     StarterGui:SetCore("SendNotification", {
       Title = "INFO",
       Text = "SCRIPT FULLY LOADED",
       Duration = 10
     })
  end
 )
)

-- Hooks

Hook = hookmetamethod(game, "__namecall", MainHook)

-- FINALIZE

GUIPage:SelectPage(GUIPage.pages[1], true)
