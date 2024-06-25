local screenX, screenY = guiGetScreenSize()

login = {}

login.font = {
	["RB"] = guiCreateFont("RB.ttf", 12),
	["RL"] = guiCreateFont("RL.ttf", 11),
	["RR"] = guiCreateFont("RR.ttf", 10),
	["chek_r"] = guiCreateFont("RR.ttf", 10),
	["chek_b"] = guiCreateFont("RB.ttf", 10),
	["RL_warning"] = guiCreateFont("RL.ttf", 10),
	["RR_editbox"] = guiCreateFont("RR.ttf", 12)
}

function outputChatBox (msg, pl)
exports.dpChat:message (pl, "global", msg)
end

login.back_ground1 = guiCreateStaticImage(0, 0, screenX, screenY, "assets/main.png", false)
login.back_ground = guiCreateStaticImage(screenX/2-600/2, screenY/2-360/2, 600, 360, "assets/bg.png", false,login.back_ground1)
login.logo = guiCreateStaticImage(0, 0, 240, 360, "assets/logo.png", false, login.back_ground)


login.label_nickname = guiCreateLabel(290, 90, 100, 20, "ʟᴏɢɪɴ:", false, login.back_ground)
login.label = guiCreateLabel(305, 40, 400, 300, "sᴇʀᴠᴇʀɪᴍɪᴢə xᴏs ɢəʟᴍɪsɪɴɪᴢ !", false, login.back_ground)
guiSetFont(login.label_nickname, login.font["RB"] )
guiSetFont(login.label, login.font["RB"] )
guiLabelSetColor(login.label_nickname, 255, 255, 255)
guiLabelSetColor(login.label, 255, 255, 255)
createEditBox(1, 290, 110, "", login.back_ground, false)

login.label_password = guiCreateLabel(290, 150, 100, 20, "ᴘᴀʀᴏʟ:", false, login.back_ground)
guiSetFont(login.label_password, login.font["RB"] )
guiLabelSetColor(login.label_password, 255, 255, 255)
createEditBox(2, 290, 170, "", login.back_ground, true)

login.button_login = guiCreateStaticImage(280, 235, 280, 50, "assets/button_login.png", false, login.back_ground)

login.label_first = guiCreateLabel(340, 290, 200, 20, "ʏᴇɴɪsəɴsə, ǫᴇʏᴅɪʏʏᴀᴛ ᴏʟ", false, login.back_ground)
guiSetFont(login.label_first, login.font["RL"] )
guiLabelSetColor(login.label_first, 255, 255, 255)

--guiCreateStaticImage(415, 290, 15, 10, "assets/iarrow.png", false, login.back_ground)
login.button_reg = guiCreateLabel(375, 310, 100, 20, "ǫᴇʏᴅɪʏʏᴀᴛ", false, login.back_ground)
guiSetFont(login.button_reg, login.font["RB"] )
guiLabelSetColor(login.button_reg, 255, 255, 255)

createChekBox(1, 290, 210, login.back_ground)
login.label_chek = guiCreateLabel(310, 210, 200, 20, "ʏᴀᴅᴅᴀ sᴀxʟᴀ", false, login.back_ground)
guiSetFont(login.label_chek, login.font["chek_r"] )
guiLabelSetColor(login.label_chek, 255, 255, 255)
--login.label_chek_two = guiCreateLabel(385, 170, 200, 20, "login ve parol", false, login.back_ground)
--guiSetFont(login.label_chek_two, login.font["chek_b"] )
--guiLabelSetColor(login.label_chek_two, 255, 0, 0)

guiSetVisible(login.back_ground, false)
guiSetVisible(login.back_ground1, false)

addEventHandler("onClientMouseEnter", getRootElement(), function()
	if (source == login.button_reg) then
		guiLabelSetColor(login.button_reg, 255, 0, 0)
	elseif (source == login.button_login) then
		guiStaticImageLoadImage(source, "assets/button_login_a.png")
	end
end)
	
addEventHandler("onClientMouseLeave", getRootElement(), function()
	if (source == login.button_reg) then
		guiLabelSetColor(login.button_reg, 153, 156, 175)
	elseif (source == login.button_login) then
		guiStaticImageLoadImage(source, "assets/button_login.png")
	end
end)

addEventHandler ("onClientGUIClick", getRootElement(), function(button)
	if button == "left" then
		if source == login.button_login then
			triggerServerEvent("onRequestLogin", getLocalPlayer(), editBox[1].text, editBox[2].text, chekBox[1].active)
		elseif source == login.button_reg then
			guiSetVisible(login.back_ground, false)
			guiSetVisible(reg.back_ground, true)
		end
	end 
end)

local function showWarning(id, chek, message)
	setEditBoxWarning(id, message, chek)
end
addEvent("showWarning", true)
addEventHandler("showWarning", getRootElement(), showWarning)


state = true
guiSetVisible(login.back_ground, state)
toggleControl ( "chatbox", false )
guiSetVisible(login.back_ground1, state)
local sound = playSound("assets/loading.mp3") --Play wasted.mp3 from the sounds folder
setSoundVolume(sound, 0.3) -- set the sound volume to 50%
showCursor(state)

function onSoundStopped ( reason )
    if ( reason == "finished" ) and source == sound then
    	sound = playSound("assets/loading.mp3")
    	setSoundVolume(sound, 0.3)
    end
end
addEventHandler ( "onClientSoundStopped", getRootElement(), onSoundStopped )

local function loginPanelVisible(state) 
	guiSetVisible(login.back_ground, state)
	guiSetVisible(login.back_ground1, state)
	if state == false then
		stopSound(sound)
		toggleControl ( "chatbox", true )
	end
	showCursor(state)
end
addEvent ("setLoginPanelVisible", true)
addEventHandler ( "setLoginPanelVisible", getRootElement(), loginPanelVisible)

-- Загрузка данных
function loadLoginFromXML() --Загрузка логина и пароля из XML
	local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
    end
    local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
		return "", ""
    end
    xmlUnloadFile ( xml_save_log_File )
end

function saveLoginToXML(username, password) --Сохрание логина и пароля в XML
    local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end		
		xmlNodeSetValue (passwordNode, tostring(password))
	end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile (xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

function resetSaveXML() --Сохрание логина и пароля в XML
	local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
	end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end		
		xmlNodeSetValue (passwordNode, "")
	end
	xmlSaveFile(xml_save_log_File)
	xmlUnloadFile(xml_save_log_File)
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

local username, password = loadLoginFromXML()
if not( username == "" or password == "") then
	setChekBoxActive(1, true)
	setEditBoxText(1, tostring(username))
	setEditBoxText(2, tostring(password))
else
	setChekBoxActive(1, false)
end

