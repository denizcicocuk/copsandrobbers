addEvent("giris:yap", true)
addEvent("kayit:ol", true)
addEvent("login:freeze", true)

function girisYap(kullanici_adi, kullanici_sifre)
    local hesap = getAccount(kullanici_adi, kullanici_sifre)
    if hesap then 
        outputChatBox("Başarıyla giriş yaptınız!", source, 0, 255, 0)
        logIn(source, hesap, kullanici_sifre)
        triggerClientEvent(source, "giris:yapildi", source)
    else
        outputChatBox("Kullanıcı adı veya şifre hatalı!", source, 255, 0, 0)

    end

end
addEventHandler("giris:yap", root, girisYap)


function kayitOl(kullanici_adi, kullanici_sifre)  
    local hesap = addAccount(kullanici_adi, kullanici_sifre)
    if hesap then
        outputChatBox ( "Başarıyla Kayıt Oldun! Ad: '"..kullanici_adi.."', Şifre: '"..kullanici_sifre.."'(Unutma!)", source, 255, 0, 0)
        logIn(source, hesap, kullanici_sifre)
        triggerClientEvent(source, "giris:yapildi", source)
    else
        outputChatBox("BAŞARISIZ!", source, 255, 0, 0)
        
    end
end
addEventHandler("kayit:ol", root, kayitOl)


addEventHandler("login:freeze", root, function(player)
    -- Yarı görünür yapma
    outputChatBox("Giriş koruman başladı", player, 0, 255, 0)
    setElementAlpha(player, 128)  -- 0-255 arası alfa değeri, 128 yarı görünür yapar

    -- Sonsuz can verme
    setElementHealth(player, math.huge)  -- Sonsuz can

    -- 5 saniye sonra geri dönüş
    setTimer(function()
        setElementAlpha(player, 255)  -- Normal görünür yapma
        setElementHealth(player, 100)  -- Canı eski haline getir
        outputChatBox("Giriş koruman bitti, iyi oyunlar!", player, 0, 255, 0)
    end, 5000, 1)  -- 5000ms = 5 saniye
end)

addEventHandler("onPlayerJoin", root,
    function()
        triggerClientEvent(source, "loginkamera", source) -- İstemciye event gönder
    end
)
