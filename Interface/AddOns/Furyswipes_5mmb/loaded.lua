
	-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
local ModName, Sequences = ...
local GSE = GSE
---- PRINT MISSING GSE
	if GSE == nil then
	print("Addon requires GSE3. You can get it from Curseforge @https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros")
	return;
	end
local L = GSE.L
local Statics = GSE.Static
local GSEPlugin = LibStub("AceAddon-3.0"):NewAddon(ModName, "AceEvent-3.0")
-----------------------------------------------------------------------------

if GSE.isEmpty(Sequences) then
  local Sequences = {}
end

-----------------------------------------------------------------------------

---- Put the macros here [[MACRO HERE]]
---- We are storing more detail to give more control.
---- To find the ClassID - /gse showspec will tell you what the ClassID and SpecID is for your character

Sequences["SINGLE_FS_ELE"] = {
  ["Macro"] = [[dmJIbaWAvvntHmBumFK0nPu9lvPUTQIDsXEHDlY(LOFkvL)Iu9BPmqvbdwQsdhHoOK6yKSqKYIrILRIhIOEQYYKKNlQjkbtfvtwvLPtCru6QsvCzsDDPYgrGTkGnRQ02Lq(Oa9vvHMgc6XuYHPA0QsgMqDsbDAv6AiY5vf9mkLXjH6Bsv1qbomkSfAcgXsNGrNnIfMkWXS7wNwgCyuGJfWpxNcJodognWHrH9ol(rCrCR)qGGvBj3wkdomkWHrHvsTKkTsQLuHPc7TLNLYEjm2gg)jrnwTLCBjiqWctu6Umsa)CDkm6m4qGablYZspe)5I(hwvCfHXQysQITrsvH9O2)x3D8m4qWSRfVGlo4yCNrNKmg5O6TqYy1DYR2bBU0EG)YzsTmwWXgqFY3wcgBkskm7EQZzctI(uKoj3wc0Wm(hn2cnbJyPtWOZgXIXM(2owAYTpeDXPCzUYtqdBe1wHfGPFmEFKHrPifhJvq)17yeyuqGaba]],
  ["SpecID"] = 262,
  ["ClassID"] = 7
}
Sequences["SINGLE_FS_PROT"] = {
  ["Macro"] = [[duZIbaWAeXmrkZgvnFK0nfKFHG(Mkj7KI9c7wK9lj)uG(lk53szGQegks0GvjA4ivhusDmswik1sruwmkA5Q4HOWtvwgQ45IAIKstvvtgrA6exev6QcvUmLUUe2iIQTsk2msy7cv9rb8vvsnneQhtQomvJgHmoHYjfYPLQRjOopcmmj6zQuDBvkdfEyuylYeGgxwKpwuswWhgo4Xc56Nwgpmk8yA8t3zYBZ4XyJhgfgHzXpIlIRtceiy16sVLY4HrHhgfwf1kQSROwrfgoyeQ7zP6YRIH9eq3IvRl9wcceSOeZIoVOXpDNjVnJhceiy08SehDsDXskgNsoexQkdRIPIDNySRToj1fhpJhcwiR4ADXXJ9oVnjzmg0Q3IyGvxie1oyACPDXtKZNAzSaJRg7j3BjyURcRWc5PcNpkj2t82K0BjWgZ43SylYeGgxwKpwuswWhJBII2r3YODJUloZoFxiaSXgDREKwyuyFqgWOuHllX0APWl4fyuqGaba]],
  ["SpecID"] = 73,
  ["ClassID"] = 1
}
Sequences["SINGLE_FS_FIRE"] = {
  ["Macro"] = [[dmJzbaWAPkntqz2aUjf6xsQCBfyNuzVODtv7xQKFkv0Fvu)wIbkvQbdQA4kPdkIJb1cvKwQIyXkLLd0dvINQAzI0Zf1ejktLWKvOMoPlsrxvsXLHCDjzJkvBLi2mOY2Lu6JePVkvyAsQAKsv8ykz0svDyHtcYZiQUgfCEf0PLYWOuJtHmXuqhM)qoPWmN3)8o0et6sPG3yybwYuqhMcEjbyl2aqzkOYNyPTIptbDykOdZxNvK1UGhlxoVy4kIpXsBfpvQ8q(TQgGkjaBXgaktbvQu5HfzTM1XHIgZNANwVn22aEuQDkMVdu0BsfyKPGkVrKgYcnOGxeaiVM5xGL8dTWNuP9lG89eAPBr)aWxY8sVPeeyUv80jhBaZBm8vbaKxrG1I8AR45uExmaXFiNuyMZ7FEhAIjVPhUcOfAPmyn0yRb00HCk)xrwqYOBeVOZf6Wyd228YqWfvakDyQuPsca]],
  ["SpecID"] = 63,
  ["ClassID"] = 8
}

-----------------------------------------------------------------------------

---- Because we know the names earlier we can dynamically figure out the names.
local macroNames = {}
-- For each k ("MACRO NAME") and v (the macro string and classid) do this loop
for k,v in pairs(Sequences) do
---- Add the name to the list of macroNames
    table.insert(macroNames, k)
end

-----------------------------------------------------------------------------

local function loadSequences(event, arg)
  if arg == ModName then
---- Force overwrite of macros ignoring the players merge preference
    for k,v in pairs(Sequences) do
        local localsuccess, uncompressedVersion = GSE.DecodeMessage(v.Macro)
        GSE.ReplaceMacro(v.ClassID, k, uncompressedVersion[2])
    end


---- Tell GSE to reload the new stuff
    GSE.PerformReloadSequences()


---- Print Success Message
    GSE.Print("Hello, " .. UnitName("player") .. " " .. UnitLevel("player") .. "  - Furyswipes_5mmb Macro Set has been loaded.", ModName)
  end
end


if GSE.RegisterAddon(ModName, GetAddOnMetadata(ModName, "Version"), macroNames) then
  loadSequences("Load", ModName)
end

GSEPlugin:RegisterMessage(Statics.ReloadMessage,  loadSequences)

