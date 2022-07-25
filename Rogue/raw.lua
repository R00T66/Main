-- if you find this i don't care, its just because i hate the devs

repeat wait() until game.IsLoaded

if game.PlaceId ~= 6152116144 then
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

local UI_WINDOW = UI_LIBRARY.Main(
    "XENA   |   Project Slayers   |   [RIGHT SHIFT]   |   (V1.0)",
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
 }
}
--// HOOKS

local NCHook;
local INHook;
local BlockedNC = {"moddelteasdasd123", "reporthackerasdasd"}

NCHook = hookmetamethod(game, "__namecall", function(self, ...)
    local Args = { }
    local Method = getnamecallmethod()
    
    if Method == "FireServer" or Method:lower() == "fireserver" then
       if table.find(BlockedNC, self.Name) then
          return;
       end
    end
    
    if Method == "Kick" or Method:lower() == "kick" then
       return;
    end
    
    return NCHook(self, ...)
end)

---// SERVICES

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

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
          Settings = Data
       end
    else
       writefile("XENAPSS.JSON", HttpService:JSONEncode(Settings))
    end
 end
)

if not GetSettings then
   CreateError("INCOMPATIBLE EXPLOIT, SORRY!");
   CreateError(Response)
   
   return;
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

--// FOLDERS

local UI_FOLDER_CHEST = UI_CATEGORY.Folder("AUTO CHEST")
local UI_FOLDER_GOURD = UI_CATEGORY.Folder("AUTO GOURD")

local UI_FOLDER_CLIENT = UI_CATEGORY.Folder("CLIENT")
--local UI_FOLDER_MISC = UI_CATEGORY.Folder("MISC")

--// AUTO CHEST

local CHEST_TOGGLE = UI_FOLDER_CHEST.Toggle("AUTO CHEST", function(Bool)
                 Settings["AC"]["Enabled"] = Bool
                 SaveSettings()
end, Settings["AC"]["Enabled"])
local CHEST_PINGM = UI_FOLDER_CHEST.Toggle("PING (MYTHIC ITEMS)", function(Bool)
                 Settings["AC"]["PingForMythic"] = not Settings["AC"]["PingForMythic"]
                 SaveSettings()
end, Settings["AC"]["PingForMythic"])
local CHEST_PINGN = UI_FOLDER_CHEST.Toggle("PING (NEW ITEMS)", function(Bool)
                 Settings["AC"]["PingForNew"] = not Settings["AC"]["PingForNew"]
                 SaveSettings()
end, Settings["AC"]["PingForNew"])
local CHEST_HOOK;
CHEST_HOOK = UI_FOLDER_CHEST.TextBox("SET WEBHOOK", function(Text)
    
    warn(Text)
    
    local Response;
    local RequestMethod = request or http_request or (http and http.request) or syn.request
    
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
local CHEST_RESET = UI_FOLDER_CHEST.Button("RESET WEBHOOK", function()
    Settings["AC"]["Webhook"] = nil
    SaveSettings()
    CreateSuccess("Webhook, RESET!")
end)
local CHEST_RESETC = UI_FOLDER_CHEST.Button("RESET COUNT", function()
    Settings["AC"]["Count"] = 0
    SaveSettings()
    CreateSuccess("Count, RESET! (0)")
end)

--// AUTO GOURD

local GOURD_TOGGLE = UI_FOLDER_GOURD.Toggle("AUTO GOURD", function(Bool)
    Settings["AG"]["Enabled"] = Bool
    SaveSettings()
    warn(Settings["AG"]["Enabled"])
end, Settings["AG"]["Enabled"])

--// CLIENT

local CLIENT_INVIS = UI_FOLDER_CLIENT.Button("INVISIBLE", function()
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

local CurrentWS = 16
local CurrentJP = 16

local CLIENT_WS = UI_FOLDER_CLIENT.Slider("WALKSPEED", 16, 250, function(Value)
               CurrentWS = Value
end, 16, false)

local CLIENT_JP = UI_FOLDER_CLIENT.Slider("JUMPPOWER", 50, 300, function(Value)
               CurrentJP = Value
end, 50, false)

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
      
      local Request = request or http_request or (http and http.request) or syn.request

      Request({
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

CreateSuccess("LOADED, MADE BY '''#9129")
local SRE,RES = pcall(function(...)
    syn.request({Url = "https://www.google.com", Method = "GET"})
end)

if not SRE then
   CreateSuccess("MADE FOR SYNAPSE X, BE CAUTIOUS")  
end
