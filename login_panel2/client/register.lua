local screenX, screenY = guiGetScreenSize()

reg = {}

reg.back_ground = guiCreateStaticImage(screenX/2-600/2, screenY/2-360/2, 600, 360, "assets/bg.png", false, login.back_ground1)
reg.logo = guiCreateStaticImage(0, 0, 240, 360, "assets/logo.png", false, reg.back_ground)


reg.label_nickname = guiCreateLabel(290, 90, 100, 20, "ʟᴏɢɪɴ:", false, reg.back_ground)
reg.label_chek_two = guiCreateLabel(320, 40, 400, 300, "ǫᴇʏᴅɪʏʏᴀᴛᴅᴀɴ ᴋᴇᴄᴍᴇᴋ ᴜᴄᴜɴ\n ᴀsᴀɢɪ ʟᴏɢɪɴ ᴠᴇ ᴘᴀʀᴏʟ ᴅᴀxɪʟ ᴇᴅɪɴ", false, reg.back_ground)
guiSetFont(reg.label_chek_two, login.font["RB"] )
guiLabelSetColor(reg.label_chek_two, 255, 255, 255)
guiSetFont(reg.label_nickname, login.font["RB"] )
guiLabelSetColor(reg.label_nickname, 255, 255, 255)
createEditBox(3, 290, 110, "", reg.back_ground, false)

reg.label_password = guiCreateLabel(290, 150, 100, 20, "ᴘᴀʀᴏʟ:", false, reg.back_ground)
guiSetFont(reg.label_password, login.font["RB"] )
guiLabelSetColor(reg.label_password, 255, 255, 255)
createEditBox(5, 290, 170, "", reg.back_ground, false)

reg.button_reg = guiCreateStaticImage(280, 235, 280, 50, "assets/button_reg.png", false, reg.back_ground)

reg.label_first = guiCreateLabel(320, 290, 200, 20, "ʜᴇsᴀʙɪɴɪᴢ ᴠᴀʀsᴀ, ɢɪʀɪs ᴇᴅɪɴ", false, reg.back_ground)
guiSetFont(reg.label_first, login.font["RL"])
guiLabelSetColor(reg.label_first, 255, 255, 255)
guiLabelSetHorizontalAlign(reg.label_first, "center")

reg.button_login = guiCreateLabel(320, 310, 200, 20, "ɢɪʀɪsə ǫᴀʏɪᴛ", false, reg.back_ground)
guiSetFont(reg.button_login, login.font["RB"] )
guiLabelSetColor(reg.button_login, 255, 255, 255)
guiLabelSetHorizontalAlign(reg.button_login, "center")

guiSetVisible(reg.back_ground, false)

addEventHandler("onClientMouseEnter", getRootElement(), function()
	if (source == reg.button_login) then
		guiLabelSetColor(reg.button_login, 255, 0, 0)
	elseif (source == reg.button_reg) then
		guiStaticImageLoadImage(source, "assets/button_reg_a.png")
	end
end)
	
addEventHandler("onClientMouseLeave", getRootElement(), function()
	if (source == reg.button_login) then
		guiLabelSetColor(reg.button_login, 255, 255, 255)
	elseif (source == reg.button_reg) then
		guiStaticImageLoadImage(source, "assets/button_reg.png")
	end
end)

function outputChatBox (msg, pl)
exports.dpChat:message (pl, "global", msg)
end

function onAccountCreate()
	guiSetVisible(reg.button_reg, false)
	
	guiCreateStaticImage(415, 300, 15, 10, "assets/iarrow.png", false, reg.back_ground)
	local x, y = guiGetPosition (reg.label_first, false) 
	guiSetPosition (reg.label_first, x, y-20, false)
	
	guiSetText(reg.label_first, "Hesab yaratdi")
	guiSetFont(reg.label_first, login.font["RB"])
	guiLabelSetColor(reg.label_first, 255, 0, 0)
	
	guiSetText(reg.button_login, "Daxil Ol")
	
	setEditBoxWarning(3, "", true)
	setEditBoxWarning(5, "", true)
end
addEvent("onAccountCreate", true)
addEventHandler("onAccountCreate", getRootElement(), onAccountCreate)


addEventHandler ("onClientGUIClick", getRootElement(), function(button)
	if button == "left" then
		if source == reg.button_login then -- назад
			guiSetVisible(reg.back_ground, false)
			guiSetVisible(login.back_ground, true)
		elseif source == reg.button_reg then
			-- Никнейм
			local errorChek = false
			
			local nickname = guiGetText(editBox[3].label_text)
			local password = guiGetText(editBox[5].label_text)
			
			local nicknameLen = nickname:len()
			local passwordLen = password:len()
			
			if (nicknameLen > 2 and nicknameLen < 11) then
				if not string.find(nickname, "^%w+$") then
					errorChek = true
					setEditBoxWarning(3, "xəᴛᴀ! ʏᴀɴʟɪs sɪᴍᴠᴏʟʟᴀʀ ᴅᴀxɪʟ ᴇᴅɪʟɪʙ.", false)
				end
			else
				errorChek = true
				setEditBoxWarning(3, "xəᴛᴀ! ᴍɪɴ. sɪᴍᴠᴏʟ sᴀʏɪ 𝟸, ᴍᴀᴋs. 𝟷𝟶", false)
			end
			
			
			if (passwordLen < 6) then
				errorChek = true
				setEditBoxWarning(5, "xəᴛᴀ! ᴍɪɴ. sɪᴍᴠᴏʟ sᴀʏɪ 𝟼", false)
			end
			
			if not errorChek then
				triggerServerEvent("onRequestRegister", getLocalPlayer(), editBox[3].text, editBox[5].text)
			end
		end
	end 
end)