local Enabled = false
SLASH_LOOTFISH1 = "/lootfish"
local WantedFish = "Oily Blackmouth"

print('|cffff0000[LOOTFISH]|r|cffffff00 /Lootfish FishName To only loot that fish.|r')

SlashCmdList["LOOTFISH"] = function(msg)
    if msg == "" then
        print('Will loot everything now.')
        Enabled = false
    else
        Enabled = true
        WantedFish = tostring(msg)
        print('Will only loot |cffffff00' .. msg .. '|r now.')
    end
end 

function LootAllSlots()
    if Enabled then
        SetCVar("autoLootDefault", false)
        for i = GetNumLootItems(), 1, -1 do
            local _,name = GetLootSlotInfo(i)
            if name == WantedFish then
                LootSlot(i)
                ConfirmLootSlot(i)
            end
        end
        CloseLoot()
    else
        SetCVar("autoLootDefault", true)
        for i = GetNumLootItems(), 1, -1 do
            LootSlot(i)
            ConfirmLootSlot(i)
        end
        CloseLoot()
    end
end

C_Timer.NewTicker(0, LootAllSlots)