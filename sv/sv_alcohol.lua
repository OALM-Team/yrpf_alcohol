local yrpf = ImportPackage("yrpf")

AddEvent("OnPackageStart", function()
    -- Vodka
    yrpf.CreateItemTemplate(100001, "Vodka", "A la votre camarade !", 1, "yrpf_alcohol/cl/img/vodka.png", 508, 0.5, 0, 50, -1, -1, -1)
    yrpf.AddI18nKey("fr", "item.name.100001", "Vodka")
    yrpf.AddI18nKey("fr", "ui.item.desc_100001", "A la votre camarade !")

    -- Rhum
     yrpf.CreateItemTemplate(100002, "Rhum", "Du bon rhum des îles", 1, "yrpf_alcohol/cl/img/rhum.png", 508, 0.5, 0, 45, -1, -1, -1)
     yrpf.AddI18nKey("fr", "item.name.100002", "Rhum")
     yrpf.AddI18nKey("fr", "ui.item.desc_100002", "Du bon rhum des îles")

    -- Beer
    yrpf.CreateItemTemplate(100003, "Bière", "La bonne binouze", 1, "yrpf_alcohol/cl/img/beer.png", 508, 0.5, 0, 25, -1, -1, -1)
    yrpf.AddI18nKey("fr", "item.name.100003", "Bière")
    yrpf.AddI18nKey("fr", "ui.item.desc_100003", "La bonne binouze")
end)


AddEvent("YRPF:ItemAPI:OnUse", function(player, templateId, itemId)
    -- Vodka
    if templateId == 100001 or templateId == 100002 or templateId == 100003 then
        Delay(500, function()
            if GetPlayerArmor(player) < 15 then
                SetPlayerArmor(player, 15)
            end
            CallRemoteEvent(player, "YRPF:Alcohol:DrugsConsumeAlcohol",4)
        end)
    end
end)