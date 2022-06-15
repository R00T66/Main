-- EL2 METAWARE VERSION 2!!!! (LAG FIX??)
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

-- ???

local WL = { 1,2,3,4 }

if not WL[1] == WL[2] then
   Client:KIck("\n\n[WHITELIST DENIED]")
end
