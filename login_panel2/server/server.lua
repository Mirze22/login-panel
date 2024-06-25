function PlayerLogin(username, password, checksave)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount ( username, password )
			if ( account ~= false ) then
				if checksave == true then
					triggerClientEvent(source, "saveLoginToXML", getRootElement(), username, password)
				else
					triggerClientEvent(source, "resetSaveXML", getRootElement(), username, password)
				end
				local chek = logIn(source, account, password)
				if chek then 
					triggerClientEvent(source, "setLoginPanelVisible", getRootElement(), false)
				else
					triggerClientEvent(source, "showWarning", getRootElement(), 1, false, "ʙᴜ ʜᴇsᴀʙ ᴀʀᴛɪǫ sᴇʀᴠᴇʀᴅᴇ ᴠᴀʀ")
				end
			else
				triggerClientEvent(source, "showWarning", getRootElement(), 1, false, "ʟᴏɢɪɴ ᴠə ʏᴀ ᴘᴀʀᴏʟ səʜᴠᴅɪʀ")
				triggerClientEvent(source, "showWarning", getRootElement(), 2, false, "ʟᴏɢɪɴ ᴠə ʏᴀ ᴘᴀʀᴏʟ səʜᴠᴅɪʀ")
			end
		else
			triggerClientEvent(source, "showWarning", getRootElement(), 2, false, "ᴘᴀʀᴏʟ ᴅᴀxɪʟ ᴇᴅɪɴ")
		end
	else
		triggerClientEvent(source, "showWarning", getRootElement(), 1, false, "ʟᴏɢɪɴ ᴅᴀxɪʟ ᴇᴅɪɴ")
	end
end
addEvent("onRequestLogin", true)
addEventHandler("onRequestLogin", getRootElement(), PlayerLogin)

function outputChatBox (msg, pl)
exports.dpChat:message (pl, "global", msg)
end

function registerPlayer(username, password)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount (username, password)
			if (account == false) then
				local accountID = #getAccounts() + 1
				local accountAdded = addAccount(tostring(username),tostring(password))
				if (accountAdded) then
					triggerEvent("rmta_save.createNewAccount", root, accountAdded, accountID)
					triggerClientEvent(source, "onAccountCreate", getRootElement())
				else
					triggerClientEvent(source, "showWarning", getRootElement(), 3, false, "ʙᴀsǫᴀ ᴍəʟᴜᴍᴀᴛʟᴀʀ ʏᴏxʟᴀʏɪɴ")
					triggerClientEvent(source, "showWarning", getRootElement(), 4, false, "ʙᴀsǫᴀ ᴍəʟᴜᴍᴀᴛʟᴀʀ ʏᴏxʟᴀʏɪɴ")
					triggerClientEvent(source, "showWarning", getRootElement(), 5, false, "ʙᴀsǫᴀ ᴍəʟᴜᴍᴀᴛʟᴀʀ ʏᴏxʟᴀʏɪɴ")
				end
			else
				triggerClientEvent(source, "showWarning", getRootElement(), 3, false, "ʙᴜ ʟᴏɢɪɴ ɪsᴛɪғᴀᴅə ᴇᴅɪʟɪʀ")
			end
		else
			triggerClientEvent(source, "showWarning", getRootElement(), 5, false, "ᴘᴀʀᴏʟ ᴅᴀxɪʟ ᴇᴅɪɴ")
		end
	else
		triggerClientEvent(source, "showWarning", getRootElement(), 3, false, "ʟᴏɢɪɴ ᴅᴀxɪʟ ᴇᴅɪɴ")
	end
end
addEvent("onRequestRegister",true)
addEventHandler("onRequestRegister",getRootElement(),registerPlayer)


function loggedOut()
	cancelEvent()
end
addEventHandler("onPlayerLogout",getRootElement(),loggedOut)