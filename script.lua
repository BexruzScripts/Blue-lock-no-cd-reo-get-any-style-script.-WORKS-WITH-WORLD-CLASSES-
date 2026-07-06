-- discord.gg/exuso
--[[
  _____                        _   _       _     
| ____|_  ___   _ ___  ___   | | | |_   _| |__  
|  _| \ \/ / | | / __|/ _ \  | |_| | | | | '_ \ 
| |___ >  <| |_| \__ \ (_) | |  _  | |_| | |_) |
|_____/_/\_\\__,_|___/\___/  |_| |_|\__,_|_.__/ 
]]

-- o; hi

local bexwashere = game:GetService("StarterGui");

local niganiga= Instance.new("BindableFunction");

niganiga.OnInvoke = function(exuso)
 if exuso == "pandadev" then
loadstring(game:HttpGet("https://pastefy.app/m3GaJjFC/raw"))()
 elseif exuso == "junkie" then
loadstring(game:HttpGet("https://pastefy.app/WRQ86Keq/raw"))()
 end
end

bexwashere:SetCore("SendNotification", {
 Title = "Exuso Hub",
 Text = "which key system do u want to use?",
 Duration = 27,
 Button1 = "pandadev",
 Button2 = "junkie",
 Callback = niganiga 
})
