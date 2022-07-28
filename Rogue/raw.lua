-- if you find this i don't care, its just because i hate the devs

repeat wait() until game.IsLoaded

if game.PlaceId ~= 6152116144 and game.PlaceId ~= 7447158459 then
   game:GetService("StarterGui"):SetCore("SendNotification", {
     Title = "ERROR",
     Text = "INCORRECT GAME?",
     Duration = 30
   })
   
   return;
end

local UI_LIBRARY = loadstring(
    game:HttpGet("https://raw.githubusercontent.com/slf0Dev/Goat-poop/main/Windows%2010%20UI%20Library")
)()
local ESP_LIBRARY = loadstring(
    game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/EL2/Kiriot22.lua")
)(); ESP_LIBRARY.Boxes = false;

local UI_WINDOW = UI_LIBRARY.Main(
    "XENA   |   Project Slayers   |   [RIGHT SHIFT]   |   (V1.4)",
    "RightShift"
)

local UI_CATEGORY = UI_WINDOW.Category(
    "PROJECT SLAYERS",
    "10237843681",
    "Crop",
    0.5
)

--// TABLES

local Katanas = {
 "Green Katana",
 "Lightning Katana",
 "Golden Katana",
 "Water Katana",
 "Giyu's Water Katana",
 "Wind Katana"
}

local Haories = {
 "Zenitsu Haorie",
 "Shinobu Haorie",
 "Tanjiro Haorie",
 "Giyu Haorie"
}

local Settings = {
 ["AC"] = { 
  ["Enabled"] = false,
  ["PingForMythic"] = false,
  ["PingForNew"] = false,
  ["Count"] = 0,
  ["Webhook"] = nil
 },
 ["AG"] = {
  ["Enabled"] = false
 },
 ["CLIENT"] = {
  ["AS"] = false,
  ["FB"] = false,
  ["ESP"] = false
 }
}

local Teleports = {
 ["Kiribating Village"] = {
     Position = CFrame.new(123.877998, 282.207642, -1624.75195, 0.999820411, 4.16962713e-08, 0.0189506207, -4.28440501e-08, 1, 6.01607439e-08, -0.0189506207, -6.09618667e-08, 0.999820411),
     Playing = false,
     Current = nil
 },
 ["Kabiwaru Village"] = {
     Position = CFrame.new(1995.31104, 315.908813, -2971.81006, 0.999716341, 1.90288834e-08, -0.0238157064, -2.02716866e-08, 1, -5.1942763e-08, 0.0238157064, 5.24108152e-08, 0.999716341),
     Playing = false,
     Current = nil 
 },
 ["Ushumaru Village"] = {
     Position = CFrame.new(4307.15381, 342.214478, -4256.16113, 0.957107544, 1.97568539e-09, -0.289732844, -2.11284878e-09, 1, -1.60623903e-10, 0.289732844, 7.65896013e-10, 0.957107544),
     Playing = false,
     Current = nil 
 },
 ["Butterfly Mansion"] = {
     Position = CFrame.new(2990.1438, 316.000549, -3872.85864, -0.999811351, -4.68872097e-09, -0.0194238424, -4.60860061e-09, 1, -4.16958956e-09, 0.0194238424, -4.07928624e-09, -0.999811351),
     Playing = false,
     Current = nil
 },
 ["Final Selection"] = {
     Position = CFrame.new(5161.06396, 365.874878, -2425.24414, 0.0206445958, -2.3372305e-08, -0.999786854, -7.51860512e-08, 1, -2.4929804e-08, 0.999786854, 7.56846887e-08, 0.0206445958),
     Playing = false,
     Current = nil
 },
 ["Dangerous Woods"] = {
     Position = CFrame.new(4022.73193, 342.914246, -3956.33105, -0.931558847, 1.6238408e-08, -0.363590658, 1.59389693e-08, 1, 3.82385901e-09, 0.363590658, -2.23311059e-09, -0.931558847),
     Playing = false,
     Current = nil
 },
 ["Ouwbayashi Home"] = {
     Position = CFrame.new(1582.92102, 315.908813, -4607.25879, 0.271734774, 4.14331183e-08, 0.962372184, -1.27321895e-08, 1, -3.94580617e-08, -0.962372184, -1.53097779e-09, 0.271734774),
     Playing = false,
     Current = nil
 },
 ["Zapiwara Mountain"] = {
     Position = CFrame.new(-340.773285, 426.857788, -2394.69116, -0.999974966, 6.34594102e-08, -0.00707402267, 6.37504343e-08, 1, -4.09143155e-08, 0.00707402267, -4.13642667e-08, -0.999974966),
     Playing = false,
     Current = nil
 },
 ["Zapiwara Cave"] = {
     Position = CFrame.new(28.51227, 275.869537, -2419.09985, 0.216436952, 2.82154158e-08, 0.976296604, -1.08528894e-07, 1, -4.84048801e-09, -0.976296604, -1.04908729e-07, 0.216436952),
     Playing = false,
     Current = nil
 },
 ["Wind Trainer"] = {
     Position = CFrame.new(1800.71399, 334.338989, -3522.95337, -0.990997434, -2.0051802e-08, 0.133880824, -1.81391968e-08, 1, 1.55056057e-08, -0.133880824, 1.29375257e-08, -0.990997434),
     Playing = false,
     Current = nil 
 },
 ["Slasher Demon"] = {
     Position = CFrame.new(1800.71399, 334.338989, -3522.95337, -0.990997434, -2.0051802e-08, 0.133880824, -1.81391968e-08, 1, 1.55056057e-08, -0.133880824, 1.29375257e-08, -0.990997434),
     Playing = false,
     Current = nil 
 },
 ["Abubu Cave"] = {
     Position = CFrame.new(1074, 276.115601, -3553.104, -0.994289756, 0, -0.106713973, 0, 1, 0, 0.106713973, 0, -0.994289756),
     Playing = false,
     Current = nil 
 },
 ["Waroru Cave"] = {
     Position = CFrame.new(603.616028, 278.168274, -2562.02295, -0.397938579, -5.76645789e-08, 0.917412043, 9.47733669e-10, 1, 6.32667962e-08, -0.917412043, 2.60457611e-08, -0.397938579),
     Playing = false,
     Current = nil 
 }
}

---// SERVICES

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

--// HANDLER FUNCS

local CreateError = function(MSG)
   StarterGui:SetCore("SendNotification", {
     Title = "ERROR",
     Text = MSG,
     Duration = 15
   })
end

local CreateSuccess = function(MSG)
   StarterGui:SetCore("SendNotification", {
     Title = "SUCCESS",
     Text = MSG,
     Duration = 10
   })
end

local SaveSettings = function()
   writefile("XENAPSS.JSON", HttpService:JSONEncode(Settings))
end

--// SETTINGS

local GetSettings,Response = pcall(
 function(...)
    if isfile("XENAPSS.JSON") then
       local Data = HttpService:JSONDecode(readfile("XENAPSS.JSON"))
       local CheckAgainst;
       
       local AC_CHECK, RESPONSE = pcall(function(...)
           CheckAgainst = Data["AC"]["Enabled"]
       end)
       
       if not AC_CHECK and CheckAgainst == nil then
          writefile("XENAPSS.JSON", HttpService:JSONEncode(Settings))
       else
          for i, v in pairs(Data) do
             if type(v) == "table" then
                for x, z in pairs(v) do
                   Settings[i][x] = z
                end
             end
          end
       end
    else
       writefile("XENAPSS.JSON", HttpService:JSONEncode(Settings))
    end
 end
)

ESP_LIBRARY:Toggle(Settings["CLIENT"]["ESP"])
ESP_LIBRARY.Color = Color3.fromRGB(0, 128, 255)

if not GetSettings then
   CreateError("INCOMPATIBLE EXPLOIT, SORRY!");
   CreateError(Response)
   
   return;
end

--// HOOKS

local NCHook;
local BlockedNC = {"moddelteasdasd123", "reporthackerasdasd"}

NCHook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Args = { ... }
    local Method = getnamecallmethod()
    
    if Method == "FireServer" or Method:lower() == "fireserver" then
       if table.find(BlockedNC, self.Name) then
          return;
       end
         
       if Settings["CLIENT"]["AS"] then       
          if self.Name == "Sun_Damage" or self.Name:lower() == "sun_damage" then
             return;  
          end
          
          if self.Name == "Handle_Initiate_C" or self.Name:lower() == "handle_initiate_c" then
             if (Args[3] ~= nil) then
                if Args[3]:lower() == "sun_damage_eff" then
                   
                   return;
                end
             end
          end          
       end
         
    end
    
    if Method == "Kick" or Method:lower() == "kick" then
       return;
    end
    
    return NCHook(self, ...)
end))
local HookSun,ResponseSun = pcall(function()
    for i,v in pairs(getrenv()._G) do
        if i == "Initiate_C" then
      
            local Hook;

            Hook = hookfunction(v, function(...)
                local Args = { ... }
                
                if Args[2] == "SUN_Damage_EFF" and Settings["CLIENT"]["AS"] then
                   return;
                end
                
                return Hook(...)
            end)
        end
    end
end)

if not HookSun then
   CreateError("EXPLOIT DOESN'T SUPPORT GETRENV(), script will run anyway.")
end

--// VARIABLES

local Player = Players.LocalPlayer
local Debree = workspace:WaitForChild("Debree")

local PlayerData = game:GetService("ReplicatedStorage"):WaitForChild("Player_Data")
local ClientData = PlayerData:WaitForChild(Player.Name)
local ClientName = Player.Name

local PlayerCProperties = ClientData:WaitForChild("Custom_Properties")
local PlayerBProgress = ClientData:WaitForChild("BreathingProgress")
local PlayerInventory = ClientData:WaitForChild("Inventory")
local PlayerItems = PlayerInventory:WaitForChild("Items")

local RequestMethod = request or http_request or (http and http.request) or syn.request

local Tweening = false
local CheckingTeleportStatus = false
local SelectedTeleport = nil

--// TELEPORTS

local TeleportTo = function(String)
   if Teleports[String] and not CheckingTeleportStatus then
      CheckingTeleportStatus = true
      
      if Tweening then
         Tweening = false
      end
      
      for i, x in pairs(Teleports) do
         if x.Playing then
            if i ~= String then
               if Current ~= nil then
                  Current:Cancel();
                  Current = nil
                  x.Playing = false
               end
            end
         end
      end
      
      local function GetDistanceOfCFrames(cf,cf2)
         local axis,theta = cf:ToAxisAngle()
         local axis2,theta2 = cf2:ToAxisAngle()
         
         return (cf.Position-cf2.Position).Magnitude,((axis*theta)-(axis2*theta2)).Magnitude
      end

      if Player.Character then
         if Player.Character:FindFirstChild("HumanoidRootPart") then
            
            local ToTween = Player.Character:FindFirstChild("HumanoidRootPart")
            local Speed = GetDistanceOfCFrames(ToTween.CFrame, Teleports[String].Position) / 150
            
            Teleports[String].Playing = true
            Teleports[String].Current = TweenService:Create(
             ToTween,
             TweenInfo.new(
              Speed,
              Enum.EasingStyle.Quad,
              Enum.EasingDirection.In,
              0,
              false,
              0
             ),
             {
              CFrame = Teleports[String].Position
             }
            )
            Tweening = true
            Teleports[String].Current.Completed:Connect(function(...)
                Tweening = false
            end)
            Teleports[String].Current:Play()
         end
      end
      CheckingTeleportStatus = false
   end
end

--// FOLDERS

local UI_FOLDER_FARM = UI_CATEGORY.Folder("FARMING")
local UI_FOLDER_CLIENT = UI_CATEGORY.Folder("CLIENT")

if game.PlaceId == 7447158459 then
   local UI_FOLDER_FINAL = UI_CATEGORY.Folder("FINAL SELECTION")
   
   
else
   local UI_FOLDER_TELEPORTS = UI_CATEGORY.Folder("TELEPORTS")
   local TELEPORTS_LABEL_L = UI_FOLDER_TELEPORTS.Label("LOCATIONS")
   local TELEPORTS_DROPDOWN_L = UI_FOLDER_TELEPORTS.Dropdown("LOCATIONS", false)
   
   local TELEPORTS_BUTTON = UI_FOLDER_TELEPORTS.Button("TELEPORT", function()
       if SelectedTeleport == nil then
          CreateError("SELECT A LOCATION!")
       else
          TeleportTo(SelectedTeleport)
       end
   end)
   
   for i, x in pairs(Teleports) do
      TELEPORTS_DROPDOWN_L.Choice(i, function()
         warn(i)
         SelectedTeleport = i
      end, false)
   end
   
   
end

--// AUTO CHEST

local CHEST_TAG = UI_FOLDER_FARM.Label("CHEST FARM")
local CHEST_TOGGLE = UI_FOLDER_FARM.Toggle("AUTO CHEST", function(Bool)
     Settings["AC"]["Enabled"] = Bool
     SaveSettings()
end, Settings["AC"]["Enabled"])
local CHEST_PINGM = UI_FOLDER_FARM.Toggle("PING (MYTHIC ITEMS)", function(Bool)
     Settings["AC"]["PingForMythic"] = Bool
     SaveSettings()
end, Settings["AC"]["PingForMythic"])
local CHEST_PINGN = UI_FOLDER_FARM.Toggle("PING (NEW ITEMS)", function(Bool)
     Settings["AC"]["PingForNew"] = Bool
     SaveSettings()
end, Settings["AC"]["PingForNew"])
local CHEST_RESETC = UI_FOLDER_FARM.Button("RESET COUNT", function()
    Settings["AC"]["Count"] = 0
    SaveSettings()
    CreateSuccess("Count, RESET! (0)")
end)
local CHEST_RESET = UI_FOLDER_FARM.Button("RESET WEBHOOK", function()
    Settings["AC"]["Webhook"] = nil
    SaveSettings()
    CreateSuccess("Webhook, RESET!")
end)
local CHEST_HOOK;
CHEST_HOOK = UI_FOLDER_FARM.TextBox("SET WEBHOOK", function(Text)
    
    local Response;
    
    Response = RequestMethod({
      Url = Text,
      Method = "POST",
      Headers = {
       ["Content-Type"] = "application/json"
      },
      Body = game:GetService("HttpService"):JSONEncode({
        content = "This is a test to ensure that this webhook is correct! - XENA"
      })
    })
    
    if Response.StatusCode ~= 204 then
       CreateError("Invalid Webhook, RETRY!")
    else
       Settings["AC"]["Webhook"] = Text
       CHEST_HOOK.Text = ""
       SaveSettings()
       CreateSuccess("Webhook, SAVED!")
    end
end)

local GOURD_TAG = UI_FOLDER_FARM.Label("GOURD FARM")
local GOURD_TOGGLE = UI_FOLDER_FARM.Toggle("AUTO GOURD", function(Bool)
    Settings["AG"]["Enabled"] = Bool
    SaveSettings()
end, Settings["AG"]["Enabled"])

--// CLIENT

local MISCTAG = UI_FOLDER_CLIENT.Label("Misc")
local CLIENT_INVIS = UI_FOLDER_CLIENT.Button("INVISIBLE", function(...)
    if Player.Character then
       for i, v in pairs(Player.Character:GetDescendants()) do
          local RF = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
          local TS = RF:WaitForChild("To_Server")
          
          TS:WaitForChild("Handle_Initiate_S"):FireServer(
              "Change_Transparency",
              {
               {
                [1] = v,
                [2] = 1
               }
              }
           )
       end
    end
end)
local CLIENT_GETPASSES = UI_FOLDER_CLIENT.Button("GET GAMEPASSES", function(...)
    local Passes = {
        "15101943",
        "17958345",
        "18589360",
        "18710993",
        "19241624",
        "19270529",
        "19270563",
        "19300397",
        "19340032",
        "19426240",
        "19516845",
        "21698004",
        "42670615",
        "46503236"
    }
    
    for i, v in pairs(Passes) do
       if not Player:WaitForChild("gamepasses"):FindFirstChild(v) then
          local Gamepass = Instance.new("StringValue")
          Gamepass.Name = v
          Gamepass.Parent = Player:WaitForChild("gamepasses")
       end
    end
    
    CreateSuccess("GIVEN ALL GAMEPASSES, CLIENT ONLY")
end)
local CLIENT_ANTISUN = UI_FOLDER_CLIENT.Toggle("ANTI SUN", function(Bool)
     Settings["CLIENT"]["AS"] = Bool 
     SaveSettings()
end, Settings["CLIENT"]["AS"])

local MOVTag = UI_FOLDER_CLIENT.Label("Movement")
local CurrentWS = 16
local CurrentJP = 50

local CLIENT_WS = UI_FOLDER_CLIENT.Slider("WALKSPEED", 16, 250, function(Value)
     CurrentWS = Value
end, 16, false)
local CLIENT_JP = UI_FOLDER_CLIENT.Slider("JUMPPOWER", 50, 300, function(Value)
     CurrentJP = Value
end, 50, false)

local VISTag = UI_FOLDER_CLIENT.Label("Visual")
local CLIENT_FB_ORIGINAL = {
 ["Brightness"] = 1.6,
 ["FogStart"] = 90,
 ["FogEnd"] = 1500,
 ["FogColor"] = Color3.fromRGB(188, 255, 216),
 ["GlobalShadows"] = true
}
local CLIENT_FB_NEW = {
 ["Brightness"] = 10,
 ["FogStart"] = 300,
 ["FogEnd"] = 10000,
 ["FogColor"] = Color3.fromRGB(188, 255, 216),
 ["GlobalShadows"] = false
}
local CLIENT_FB_ATMO = Lighting:WaitForChild("Atmosphere"):Clone()
local CLIENT_FB = UI_FOLDER_CLIENT.Toggle("FULLBRIGHT", function(Bool)
     Settings["CLIENT"]["FB"] = Bool
     SaveSettings()
     if Bool then
        Lighting:WaitForChild("Atmosphere"):Destroy()
     else
        CLIENT_FB_ATMO:Clone().Parent = Lighting
     end
end, Settings["CLIENT"]["FB"])
local CLIENT_ESP = UI_FOLDER_CLIENT.Toggle("ESP", function(Bool)
     Settings["CLIENT"]["ESP"] = Bool
     SaveSettings()
end, Settings["CLIENT"]["ESP"])

--// FUNCTIONS

local CollectChest = function(Chest)
    
   local SendHook = false
   local MythicCollected = false
   local ItemCollected = false
   
   if not Chest:FindFirstChild("CC") then
      Instance.new("Folder", Chest).Name = "CC"
      SendHook = true
      Settings["AC"]["Count"] = Settings["AC"]["Count"] + 1
      SaveSettings()
   end
   
   local Drops = Chest:WaitForChild("Drops")
   local Collect = Chest:WaitForChild("Add_To_Inventory")
   
   local Collected = { }
   local AllItems = { }
   
   for i, v in pairs(Drops:GetChildren()) do
      
      table.insert(AllItems, v.Name)
      
      if v.Value:lower() == "mythic" then
         if v.Name:lower() == "ore" then
            Collect:InvokeServer(v.Name)
            table.insert(Collected, v.Name)
            
            MythicCollected = true
            ItemCollected = true
         elseif not PlayerItems:FindFirstChild(v.Name) then
            Collect:InvokeServer(v.Name)
            table.insert(Collected, v.Name)  
            
            MythicCollected = true
            ItemCollected = true
         end
      end
      
      if table.find(Katanas, v.Name) then
         if not PlayerItems:FindFirstChild(v.Name) then
            Collect:InvokeServer(v.Name)
            table.insert(Collected, v.Name)
            
            ItemCollected = true
         end
      end
      
      if table.find(Haories, v.Name) then
         if not PlayerItems:FindFirstChild(v.Name) then
            Collect:InvokeServer(v.Name)
            table.insert(Collected, v.Name)
            
            ItemCollected = true
         end
      end
      
   end
   
   local CollectedValue;
   local ItemsValue;
   
   if #Collected == 0 then
       CollectedValue = "**NONE**"
   else
       CollectedValue = "**" .. table.concat(Collected, ", ") .. "**"
   end
   
   if #AllItems == 0 then
       ItemsValue = "**NONE**"
   else
       ItemsValue = "**" .. table.concat(AllItems, ", ") .. "**"
   end
   
   if SendHook and Settings["AC"]["Webhook"] ~= nil then
       
      local ContentHandle = nil
      
      if MythicCollected and Settings["AC"]["PingForMythic"] then
         ContentHandle = "@everyone"
      end
      
      if ItemCollected and Settings["AC"]["PingForNew"] then
         ContentHandle = "@everyone"    
      end

      RequestMethod({
        Url = Settings["AC"]["Webhook"],
        Method = "POST",
        Headers = {
         ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({
          content = ContentHandle,
          embeds = {{
            color = 664010,
            fields = {
             {
              name = "**ITEM DROPS:**",
              value = ItemsValue
             },
             {
              name = "**COLLECTED DROPS:**",
              value = CollectedValue
             }
            },
            author = {
             name = "CHEST LOG #" .. tostring(Settings["AC"]["Count"]) .. " - " .. tostring("(" .. game.JobId .. ")")
            }           
          }}
        })
      })  
   end
end

local GetYen = function()
   return ClientData.Yen.Value
end

local BuyGourd = function(Gourd, Price)
    
    if GetYen() < Price then
       return false,"Not Enough Wen"
    end
    
    local ohString1 = "buysomething"
    local ohInstance2 = game:GetService("Players").LocalPlayer
    local ohString3 = Gourd
    local ohInstance4 = game:GetService("ReplicatedStorage").Player_Data[ClientName].Yen
    local ohInstance5 = game:GetService("ReplicatedStorage").Player_Data[ClientName].Inventory

    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohString3, ohInstance4, ohInstance5)   
    
    return true
end

local UseGourd = function(Type, Price, Dep)
    
    local Character;
    local Backpack;
    local Uses;
    
    if Player.Backpack then
       Backpack = Player.Backpack
    else
       return
    end
    
    if Player.Character then
       Character = Player.Character
    else
       return
    end
    
    if (Type == "Small") then
       Uses = 3
    elseif (Type == "Medium") then
       Uses = 5
    elseif (Type == "Big") then
       Uses = 12
    else
       return false,"Invalid Gourd?"
    end

    if not Backpack:FindFirstChild(Type .. " Gourd") and not Character:FindFirstChild(Type .. " Gourd") then
       local Purchase,Msg = BuyGourd(Type .. " Gourd", Price)
       
       if not Purchase and Msg == nil then
          return false,"Unknown Error" 
       end
       
       if not Purchase then 
           return Purchase,Msg 
       end
       
       local YieldCount = 0
       
       repeat wait() 
        YieldCount = YieldCount + 1
       until Backpack:FindFirstChild(Type .. " Gourd") or YieldCount > 350
       
       if YieldCount > 350 then
          return false,"Too Much Yield!!"
       end
       
       if Backpack:FindFirstChild(Type .. " Gourd") then
          local BG = Backpack:FindFirstChild(Type .. " Gourd")
          
          BG.Parent = Character;

          for i = 1,Uses do
              local ohString1 = "blow_in_gourd_thing"
              local ohInstance2 = game:GetService("Players").LocalPlayer
              local ohInstance3 = game:GetService("Players").LocalPlayer.Character[Type .. " Gourd"]
              local ohNumber4 = Dep

              game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(ohString1, ohInstance2, ohInstance3, ohNumber4) 
          end          
       elseif Character:FindFirstChild(Type .. " Gourd") then
          for i = 1,Uses do
              local ohString1 = "blow_in_gourd_thing"
              local ohInstance2 = game:GetService("Players").LocalPlayer
              local ohInstance3 = game:GetService("Players").LocalPlayer.Character[Type .. " Gourd"]
              local ohNumber4 = Dep

              game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(ohString1, ohInstance2, ohInstance3, ohNumber4) 
          end          
       end       
    else
       if Backpack:FindFirstChild(Type .. " Gourd") then
          local BG = Backpack:FindFirstChild(Type .. " Gourd")
          
          BG.Parent = Character;

          for i = 1,Uses do
              local ohString1 = "blow_in_gourd_thing"
              local ohInstance2 = game:GetService("Players").LocalPlayer
              local ohInstance3 = game:GetService("Players").LocalPlayer.Character[Type .. " Gourd"]
              local ohNumber4 = Dep

              game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(ohString1, ohInstance2, ohInstance3, ohNumber4) 
          end          
       elseif Character:FindFirstChild(Type .. " Gourd") then
          for i = 1,Uses do
              local ohString1 = "blow_in_gourd_thing"
              local ohInstance2 = game:GetService("Players").LocalPlayer
              local ohInstance3 = game:GetService("Players").LocalPlayer.Character[Type .. " Gourd"]
              local ohNumber4 = Dep

              game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(ohString1, ohInstance2, ohInstance3, ohNumber4) 
          end          
       end
    end
end

local UseSmall = function()
    local Bool,Message = UseGourd("Small", 200, 1)
    
    if not Bool then
       CreateError(Message);
       
       return Message
    end
end

local UseMedium = function()
    local Bool,Message = UseGourd("Medium", 450, 2)
    
    if not Bool then
       CreateError(Message);
       
       return Message
    end
end

local UseBig = function()
    local Bool,Message = UseGourd("Big", 200, 3)

    if not Bool then
       CreateError(Message);
       
       return Message
    end
end

--// SETUP

RunService.RenderStepped:Connect(function(...)
    
    if not Settings["AC"]["Enabled"] then
       return;
    end
    
    for i, x in pairs(Debree:GetChildren()) do
       if x.Name == "Loot_Chest" then
          CollectChest(x)
       end
    end
end)

RunService.Stepped:Connect(function(...)
    if Tweening then
       if Player.Character then
          for i, x in pairs(Player.Character:GetDescendants()) do
             if (x:IsA("BasePart")) then
                x.CanCollide = false
             end
          end
       end
    end
end)
RunService.RenderStepped:Connect(function(...)
    if Player.Character then
       if CurrentWS ~= 16 then
          if Player.Character:FindFirstChild("Humanoid") then
             Player.Character:FindFirstChild("Humanoid").WalkSpeed = CurrentWS
          end
       end
       if CurrentJP ~= 50 then
          if Player.Character:FindFirstChild("Humanoid") then
             Player.Character:FindFirstChild("Humanoid").JumpPower = CurrentJP
          end
       end
    end
    
    if Settings["CLIENT"]["ESP"] then
       if not ESP_LIBRARY.Enabled then
          ESP_LIBRARY:Toggle(true)
       end
    elseif (not Settings["CLIENT"]["ESP"] and ESP_LIBRARY.Enabled) then
       ESP_LIBRARY:Toggle(false)
    end
    
    if Settings["CLIENT"]["FB"] then
       for i, v in pairs(CLIENT_FB_NEW) do
          Lighting[i] = v
       end
    else
       for i, v in pairs(CLIENT_FB_NEW) do
          if Lighting[i] == v and i ~= "FogColor" then
             for i, v in pairs(CLIENT_FB_ORIGINAL) do
                Lighting[i] = v
             end
          end
       end
    end
end)

local AutoGourd = coroutine.create(function(...)
    while wait() do
       local S,E =  pcall(function(...)
           if Settings["AG"]["Enabled"] then
              local SmallUses = PlayerCProperties:WaitForChild("Used_Small_Gourd")
              local MediumUses = PlayerCProperties:WaitForChild("Used_Medium_Gourd")
              local BigUses = PlayerCProperties:WaitForChild("Used_Big_Gourd")
              
              if PlayerBProgress:WaitForChild("1").Value == PlayerBProgress:WaitForChild("2").Value then
                 CreateSuccess("AUTO GOURD DISABLED, MAX BREATHING.")
                 Settings["AG"]["Enabled"] = false
                 SaveSettings()
                 
                 return
              end
              
              if SmallUses.Value <= 7 then
                 local Use_Small = UseSmall()
                 
                 if Use_Small == "Not Enough Wen" then
                    Settings["AG"]["Enabled"] = false
                    SaveSettings()
                    CreateError("AUTO GOURD DISABLED, NOT ENOUGH WEN.")
                 else
                    repeat wait() until not Player.Backpack:FindFirstChild("Small Gourd") and not Player.Character:FindFirstChild("Small Gourd")
                 end
              elseif MediumUses.Value <= 7 then
                 local Use_Medium = UseMedium()
                 
                 if Use_Medium == "Not Enough Wen" then
                    Settings["AG"]["Enabled"] = false
                    SaveSettings()
                    CreateError("AUTO GOURD DISABLED, NOT ENOUGH WEN.")
                 else
                    repeat wait() until not Player.Backpack:FindFirstChild("Medium Gourd") and not Player.Character:FindFirstChild("Medium Gourd")
                 end                
              else
                 local Use_Big = UseBig()
                 
                 if Use_Big == "Not Enough Wen" then
                    Settings["AG"]["Enabled"] = false
                    SaveSettings()
                    CreateError("AUTO GOURD DISABLED, NOT ENOUGH WEN.")
                 else
                    repeat wait() until not Player.Backpack:FindFirstChild("Big Gourd") and not Player.Character:FindFirstChild("Big Gourd")
                 end       
              end
           end
       end)
       
       if not S then CreateError(E) end
    end
end)

coroutine.resume(AutoGourd)

CreateSuccess("LOADED, MADE BY '''#9129 - (V1.1)")
local AFK,ARES = pcall(function(...)
    for i,v in pairs(getconnections(Player.Idled)) do
       v:Disable()
    end      
end)
local SRE,SRES = pcall(function(...)
    syn.request({Url = "https://www.google.com", Method = "GET"})
end)

if not SRE then
   CreateSuccess("MADE FOR SYNAPSE X, BE CAUTIOUS")  
end
if not AFK then
   -- HACK INTO THE MAIN FRAME >:)))!!! THANKS FOR YOUR "IP ADDRESS". /Joke/Joke/Joke.
   
   Player.Idled:connect(function(...)
       VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       wait(1)
       VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)  
   end)   
end

RequestMethod({
  Url = "http://127.0.0.1:6463/rpc?v=1",
  Method = "POST",
  Headers = {
   ["Content-Type"] = "application/json",
   ["Origin"] = "https://discord.com"
  },
  Body = HttpService:JSONEncode({
    ["cmd"] = "INVITE_BROWSER",
    ["nonce"] = HttpService:GenerateGUID(false),
    ["args"] = {
     ["code"] = "NfUCw4rt7x"
    }
  })
}) 
