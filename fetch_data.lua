-- Fungsi untuk mengonversi tabel Lua ke JSON
function tableToJSON(tbl)
    local json = "{"
    for key, value in pairs(tbl) do
        -- Pastikan nilai berupa string, angka, atau boolean dikonversi dengan benar
        local formattedValue = type(value) == "string" and string.format('"%s"', value) or tostring(value)
        json = json .. string.format('"%s":%s,', key, formattedValue)
    end
    json = json:sub(1, -2) .. "}" -- Hapus koma terakhir dan tutup dengan kurung kurawal
    return json
end

-- Fungsi HTTP POST untuk mengirim data ke server
function sendData(url, jsonData)
    local socket = require("socket.http")
    local ltn12 = require("ltn12")

    local response_body = {}
    local res, code, response_headers = socket.request{
        url = url,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#jsonData)
        },
        source = ltn12.source.string(jsonData),
        sink = ltn12.sink.table(response_body)
    }

    if code == 200 then
        print("Data berhasil dikirim:", table.concat(response_body))
    else
        print("Gagal mengirim data. Kode respon:", code)
    end
end

-- Fungsi utama untuk mengambil data dari bot Lucifer
function fetchBotData()
    -- Mengakses bot utama
    local bot = getBot()

    -- Debug: Periksa apakah bot dan properti-propertinya tersedia
    if not bot then
        print("Error: Bot tidak ditemukan!")
        return {}
    end

    -- Data yang dikumpulkan dari bot
    local data = {
        gems = bot.gem_count or 0,
        worlds = bot:getWorld() and bot:getWorld().tile_count or 0,
        seeds = bot.auto_harvest and bot.auto_harvest.getTiles and #bot.auto_harvest:getTiles() or 0,
        storage = bot.auto_harvest and bot.auto_harvest.setStorage and bot.auto_harvest:setStorage("storage") or 0,
        packs = bot.auto_transfer and bot.auto_transfer.restock_vend or 0
    }

    return data
end

-- Eksekusi
local data = fetchBotData()
if next(data) then -- Pastikan data tidak kosong sebelum mengirim
    local jsonData = tableToJSON(data)
    local url = "http://localhost:3000/api/data" -- Pastikan ini URL server Anda
    sendData(url, jsonData)
else
    print("Tidak ada data yang dikirim karena error.")
end
