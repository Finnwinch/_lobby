if SERVER then
    print("Lobby system was been load!")
    util.AddNetworkString("requestLobbyInterface")
	util.AddNetworkString("requestLobbyInterfaceCache")
	hook.Add("PlayerInitialSpawn","load enterLobby",function(ply)
		net.Start("requestLobbyInterfaceCache")
		net.Send(ply)
		timer.Simple(1,function()
			net.Start("requestLobbyInterface")
			net.Send(ply)
            print()
		end)
	end)
	resource.AddFile("materials/lobby/decorated_box_resultat.png")
end
if CLIENT then
    local cache
	local lobby
	net.Receive("requestLobbyInterfaceCache",function()
		lobby = vgui.Create("DHTML")
		lobby:SetSize(ScrW(),ScrH())
		local watchID  = "EColTNIbOko&t"
		if(BRANCH=="x86-64") then
		lobby:SetHTML([[
			<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            overflow: hidden;
        }
        iframe {
            width: 100vw;
            height: 100vh;
            pointer-events: none;
        }
		iframe:hover {
            pointer-events: none;
            cursor: default;
        }
    </style>
</head>
<body>
    <iframe
        width="560"
        height="315"
        src="https://www.youtube.com/embed/]]..watchID..[[?autoplay=1&playlist=]]..watchID..[[&loop=1&controls=0&mute=1"
        frameborder="0"
        allowfullscreen
    ></iframe>
</body>
</html>
		]])
	else
		lobby:SetHTML([[
			<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activation de GMod 64-bit</title>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }

        .message {
            text-align: center;
            font-family: 'Arial', sans-serif;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="message">
        <h2>Activez GMod 64-bit</h2>
        <p>Veuillez activer la version 64-bit de Garry's Mod pour profiter de toutes les fonctionnalités.</p>
    </div>
</body>
</html>
		]])
	end
		cache = vgui.Create("DPanel")
		cache:SetParent(lobby)
		cache:Dock(FILL)
		cache:MakePopup()
		cache:SetFocusTopLevel(true)
	end)
	net.Receive("requestLobbyInterface",function()
		local pan = vgui.Create("DPanel")
		pan:SetSize(ScrW(),ScrH())
		pan:MakePopup()
		pan:SetFocusTopLevel(true)
		cache:Remove()
		lobby:SetParent(pan)
		lobby:Dock(FILL)
        function lobby:Think() 
            if (IsValid(pan) ) then
                self:RequestFocus()
                pan:MakePopup()
                pan:SetZPos(9999)
            end
        end
		local enter = vgui.Create("DButton")
		enter:SetParent(lobby)
		enter:Dock(BOTTOM)
		enter:DockMargin(ScrW()*0.3,0,ScrW()*0.3,15)
		enter:SetTall(152)
		enter:SetText("Appuyer sur une touche pour continuer")
		surface.CreateFont("lobbyButton",{
			font = "Aberus",
			size = 21,
			weight = 1000,
		})
		enter:SetFont("lobbyButton")
		enter:SetTextColor(Color(255,255,255))
		local mat = Material("materials/lobby/decorated_box_resultat.png")
		function enter:Paint(w,h)
			if (self:IsHovered()) then
				self:SetTextColor(Color(0,115,255))
			else
				self:SetTextColor(Color(255,255,255))
			end
			surface.SetMaterial(mat)
    		surface.SetDrawColor(255, 255, 255, 255)
    		local imgWidth, imgHeight = 684, 152
    		local x = (w - imgWidth) / 2
    		local y = h - imgHeight
    		surface.DrawTexturedRect(x, y, 684, 152)
		end
		function enter:DoClick()
			pan:Remove()
		end
	end)
end