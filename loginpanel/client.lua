local panelW, panelH = 0.20, 0.19 -- Panelin genişlik ve yükseklik oranları
local panelX, panelY = (1 - panelW) / 2, (1 - panelH) / 2 -- Ortalamak için hesaplama

local panel = guiCreateWindow(panelX, panelY, panelW, panelH, "Denizcicocuk'un Giriş Paneli!", true)

guiWindowSetMovable(panel, false)
guiWindowSetSizable(panel, false)

local kullanici_adi = guiCreateEdit(0.13, 0.24, 0.73, 0.17, "Kullanıcı Adı", true, panel)
local kullanici_sifre = guiCreateEdit(0.13, 0.56, 0.73, 0.17, "Kullanıcı Şifresi", true, panel)

local kullanici_label = guiCreateLabel(0.14, 0.16, 0.73, 0.08, "Hesap Adı", true, panel)
local sifre_label = guiCreateLabel(0.13, 0.46, 0.73, 0.07, "Hesap Şifresi", true, panel)

local giris_buton = guiCreateButton(0.17, 0.79, 0.27, 0.16, "Giriş Yap", true, panel)
local kayit_buton = guiCreateButton(0.57, 0.79, 0.27, 0.16, "Kayıt Ol", true, panel)

local muzikLabel = guiCreateLabel(279, 22, 97, 17, "Müzik Aç/Kapa", false, panel)  
guiLabelSetColor(muzikLabel, 0, 255, 0)

setCameraMatrix(1500, 1500, 50, 1600, 1600, 50)
showCursor(true)

local muzik = playSound("loginmuzik.mp3", true) -- Müzik otomatik başlasın
local muzikDurumu = "aktif"  -- Başlangıçta renk yeşil
        setSoundVolume(muzik, 0.5) -- Ses seviyesini %50 yap

        function muzikTiklandi()
                if muzikDurumu == "aktif" then
                    stopSound(muzik)
                    guiLabelSetColor(muzikLabel, 255, 0, 0)
                    muzikDurumu = "deaktif"
                else
                    muzik = playSound("loginmuzik.mp3", true)
                    guiLabelSetColor(muzikLabel, 0, 255, 0)
                    muzikDurumu = "aktif"
                end
            end
            
            addEventHandler("onClientGUIClick", muzikLabel, muzikTiklandi, false)


            addEventHandler("onClientGUIClick", kullanici_adi, function()
                if guiGetText(kullanici_adi) == "Kullanıcı Adı" then
                    guiSetText(kullanici_adi, "") -- Sadece ilk tıklamada sil
                end
            end, false)

            addEventHandler("onClientGUIClick", kullanici_sifre, function()
                if guiGetText(kullanici_sifre) == "Kullanıcı Şifresi" then
                    guiSetText(kullanici_sifre, "") -- Sadece ilk tıklamada sil
                end
            end, false)



function butonTikla()
    if source == giris_buton then
        local kullanici_adi = guiGetText(kullanici_adi)
        local sifre = guiGetText(kullanici_sifre)
        triggerServerEvent("giris:yap", localPlayer, kullanici_adi, sifre)

    elseif source == kayit_buton then 
        local kullanici_adi = guiGetText(kullanici_adi)
        local sifre = guiGetText(kullanici_sifre)
        triggerServerEvent("kayit:ol", localPlayer, kullanici_adi, sifre)
        
    end
end

addEventHandler("onClientGUIClick", resourceRoot, butonTikla)


addEvent("giris:yapildi", true)

function girisYapildi()
        destroyElement(panel)
        stopSound(muzik)
        fadeCamera(true)  -- Ekranı yumuşak geçişle aç
        setCameraTarget(localPlayer) -- Kamerayı oyuncunun karakterine döndür
        showPlayerHudComponent("all", true)
        showChat(true) 
        showCursor(false)
        triggerServerEvent("login:freeze", resourceRoot, localPlayer)


end
addEventHandler("giris:yapildi", root, girisYapildi)

addEvent("loginkamera", true)
addEventHandler("loginkamera", root,
    function()
        setCameraMatrix(1500, 1500, 50, 1600, 1600, 50) -- Kamera pozisyonunu ayarla
        showChat(false)  -- Sohbeti kapat (opsiyonel)
        showPlayerHudComponent("all", false)
    end
)


