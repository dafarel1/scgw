-- Fungsi untuk mengambil data gems, worlds, seeds, storage, dan packs
function fetchBotData()
    -- Mengakses bot utama
    local bot = getBot()

    -- Data yang akan dikumpulkan
    local data = {
        gems = bot.gem_count or 0,
        worlds = bot:getWorld() and bot:getWorld().tile_count or 0,
        seeds = bot.auto_harvest and bot.auto_harvest:getTiles() or 0,
        storage = bot.auto_harvest and bot.auto_harvest:setStorage("storage_name") or 0,
        packs = bot.auto_transfer and bot.auto_transfer.restock_vend or 0
    }

    return data
end

-- Menampilkan data
local botData = fetchBotData()
print("Data Bot:")
for key, value in pairs(botData) do
    print(key .. ": " .. tostring(value))
end

-- Kirim ke server web (opsional)
local url = "http://localhost:3000/api/data"
local jsonData = tableToJSON(botData) -- Fungsi konversi table ke JSON
sendData(url, jsonData) -- Fungsi HTTP POST