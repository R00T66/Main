--[[ MADE BY METACALLED ]]--

local Dictionary = {};

Dictionary["a"] = ",."
Dictionary["b"] = ",.."
Dictionary["c"] = ",..."
Dictionary["d"] = ",...."
Dictionary["e"] = ",....."
Dictionary["f"] = ",......"
Dictionary["g"] = ",......."
Dictionary["h"] = ",........"
Dictionary["i"] = ",........."
Dictionary["j"] = ",.........."
Dictionary["k"] = ",..........."
Dictionary["l"] = ",............"
Dictionary["m"] = ",............."
Dictionary["n"] = ",.............."
Dictionary["o"] = ",..............."
Dictionary["p"] = ",................"
Dictionary["q"] = ",................."
Dictionary["r"] = ",.................."
Dictionary["s"] = ",..................."
Dictionary["t"] = ",...................."
Dictionary["u"] = ",....................."
Dictionary["v"] = ",......................"
Dictionary["w"] = ",......................."
Dictionary["x"] = ",........................"
Dictionary["y"] = ",........................."
Dictionary["z"] = ",.........................."

Dictionary["A"] = ",.C"
Dictionary["B"] = ",..C"
Dictionary["C"] = ",...C"
Dictionary["D"] = ",....C"
Dictionary["E"] = ",.....C"
Dictionary["F"] = ",......C"
Dictionary["G"] = ",.......C"
Dictionary["H"] = ",........C"
Dictionary["I"] = ",.........C"
Dictionary["J"] = ",..........C"
Dictionary["K"] = ",...........C"
Dictionary["L"] = ",............C"
Dictionary["M"] = ",.............C"
Dictionary["N"] = ",..............C"
Dictionary["O"] = ",...............C"
Dictionary["P"] = ",................C"
Dictionary["Q"] = ",.................C"
Dictionary["R"] = ",..................C"
Dictionary["S"] = ",...................C"
Dictionary["T"] = ",....................C"
Dictionary["U"] = ",.....................C"
Dictionary["V"] = ",......................C"
Dictionary["W"] = ",.......................C"
Dictionary["X"] = ",........................C"
Dictionary["Y"] = ",.........................C"
Dictionary["Z"] = ",..........................C"

Dictionary["0"] = ",~"
Dictionary["1"] = ",#"
Dictionary["2"] = ",##"
Dictionary["3"] = ",###"
Dictionary["4"] = ",####"
Dictionary["5"] = ",#####"
Dictionary["6"] = ",######"
Dictionary["7"] = ",#######"
Dictionary["8"] = ",########"
Dictionary["9"] = ",#########"

Dictionary[" "] = ",_"
Dictionary["="] = ",="

Dictionary["{"] = ",BRACKET_PAREN_RIGHT"
Dictionary["}"] = ",BRACKET_PAREN_LEFT"

Dictionary["["] = ",BRACKET_RIGHT_RIGHT"
Dictionary["]"] = ",BRACKET_RIGHT_LEFT"

Dictionary["("] = ",BRACKET_NORMAL_RIGHT"
Dictionary[")"] = ",BRACKET_NORMAL_LEFT"

Dictionary[","] = ",COM_GB_SPLIT"
Dictionary["'"] = ",COM_GB_SPEECH"
Dictionary['"'] = ",COM_DOUBLE_GB_SPEECH"
Dictionary["#"] = ",**#**=(define.hash)"

Dictionary["\n"] = ",NEW_LINE_FUNC"
Dictionary["-"] = ",**#**=(define.comment)"
Dictionary["~"] = ",**#**=(define.squiggle)"
Dictionary["+"] = ",**#**=(define.plus)"
Dictionary["*"] = ",**#**=(define.star)"
Dictionary["."] = ",**#**=(define.dot)"
Dictionary["%"] = ",**#**=(define.percent)"
Dictionary["$"] = ",**#**=(define.dollar)"
Dictionary[";"] = ",**#**=(define.semicolon)"
Dictionary[":"] = ",**#**=(define.colon)"
Dictionary["@"] = ",**#**=(define.AT_SIGN)"
Dictionary["/"] = ",**#**=(define.Slash)"
Dictionary["!"] = ",**#**=(define.Exclaim)"
Dictionary["_"] = ",**#**=(define.Underline_Symbol)"
Dictionary[">"] = ",**#**=(define.Right_Crocco)"
Dictionary["<"] = ",**#**=(define.Left_Crocco)"
Dictionary["?"] = ",**#**=(define.QUESTIONMARKKKK)"
Dictionary["&"] = ",**#**=(define.ANDDIDIASKLOL)"

Dictionary["\\"] = ",**#**=(define.BackSlash)"

Dictionary["Split"] = function(s, pattern, maxsplit)
  local pattern = pattern or ' '
  local maxsplit = maxsplit or -1
  local s = s
  local t = {}
  local patsz = #pattern
  while maxsplit ~= 0 do
    local curpos = 1
    local found = string.find(s, pattern)
    if found ~= nil then
      table.insert(t, string.sub(s, curpos, found - 1))
      curpos = found + patsz
      s = string.sub(s, curpos)
    else
      table.insert(t, string.sub(s, curpos))
      break
    end
    maxsplit = maxsplit - 1
    if maxsplit == 0 then
      table.insert(t, string.sub(s, curpos - patsz - 1))
    end
  end
  return t
end

Dictionary["Encode"] = function(String)
   local TemporaryDictionary = { }
   local InvalidDictionaries = { }

   for i = 1,string.len(String) do

      local DicFound = false
     
      for z, x in pairs(Dictionary) do  
         if String:sub(i, i) == z then
            TemporaryDictionary[#TemporaryDictionary + 1] = x
            DicFound = true
         end
      end

      if not DicFound then

         local Exists = false;

         for z, x in pairs(InvalidDictionaries) do
            if String:sub(i, i) == x then
               Exists = true
            end
         end
      
         if not Exists then
            table.insert(InvalidDictionaries, String:sub(i, i))
         end
      end
   end

   if #InvalidDictionaries ~= 0 then
      print("Invalid Dictionaries:", table.concat(InvalidDictionaries, " "))
   end
  
   return table.concat(TemporaryDictionary, "")
end

Dictionary["Decode"] = function(EncodedString)
   local TemporaryDictionary = { }
   local EncodedDictionary = Dictionary["Split"](EncodedString, ",")
   
   for i, v in pairs(EncodedDictionary) do

      for z, x in pairs(Dictionary) do         
         if "," .. v == x then
            TemporaryDictionary[#TemporaryDictionary + 1] = z
         end
      end
   end

   return "\n" .. table.concat(TemporaryDictionary, "")
end

Dictionary["Writefile"] = function(filename, extension, input)
   writefile(filename .. "." .. extension, input)
end

local Encode_Function = Dictionary["Encode"]
local Decode_Function = Dictionary["Decode"]
local Write_Function = Dictionary["Writefile"]

return {
        Encode = Encode_Function, 
        Decode = Decode_Function, 
        Write = Write_Function
}
