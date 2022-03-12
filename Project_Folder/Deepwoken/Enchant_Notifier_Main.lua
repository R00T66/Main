local Body = game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/Project_Folder/Deepwoken/Dependancies/ByteCode_Library")
local Script = game:HttpGet("https://raw.githubusercontent.com/R00T66/Main/main/Project_Folder/Deepwoken/Enchant_Notifier")
local Enc,Dec,Wri = loadstring(Body)()

if Dec ~= nil then
    loadstring(Dec(Script))()
else
    print(Body)
end
