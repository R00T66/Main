local Body = game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\82\48\48\84\54\54\47\77\97\105\110\47\109\97\105\110\47\80\114\111\106\101\99\116\95\70\111\108\100\101\114\47\68\101\101\112\119\111\107\101\110\47\68\101\112\101\110\100\97\110\99\105\101\115\47\66\121\116\101\67\111\100\101\95\76\105\98\114\97\114\121\10")
local Script = game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\82\48\48\84\54\54\47\77\97\105\110\47\109\97\105\110\47\80\114\111\106\101\99\116\95\70\111\108\100\101\114\47\68\101\101\112\119\111\107\101\110\47\69\110\99\104\97\110\116\95\78\111\116\105\102\105\101\114\10")
local Enc,Dec,Wri = loadstring(Body)()

if Dec ~= nil then
    loadstring(Dec(Script))()
else
    return
end
