

-- this saves a file (without compressing it -> debug purposes)
function save_file(_file, _data)
    NFS.write(_file,_data)
end

-- this loads a file (wihtout uncompressing it -> debug purposes)
function load_file(_file)
    local file_data = NFS.getInfo(_file)
    if file_data ~= nil then
        local file_string = NFS.read(_file)
        if file_string ~= '' then
            return file_string
        end
    end
end

-- debug

function copy_uncompressed(_file)
    local file_data = NFS.getInfo(_file)
    if file_data ~= nil then
        local file_string = NFS.read(_file)
        if file_string ~= '' then
            local success = nil
            success, file_string = pcall(love.data.decompress, 'string', 'deflate', file_string)
            NFS.write(_file .. ".txt", file_string)
        end
    end
end

function tableContains(table, value)
    for i = 1, #table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end

-- Maps AP deck item IDs to their stake type
local AP_STAKE_KEYS = {
    'stake_white', 'stake_red', 'stake_green', 'stake_black',
    'stake_blue', 'stake_purple', 'stake_orange', 'stake_gold',
}

function ap_stake_for_id(_id)
    return AP_STAKE_KEYS[(_id % #AP_STAKE_KEYS) + 1]
end

-- Maps AP deck item IDs to their back type
local AP_BACK_KEYS = {
    'b_red', 'b_blue', 'b_yellow', 'b_green', 'b_black',
    'b_magic', 'b_nebula', 'b_ghost', 'b_abandoned', 'b_checkered',
    'b_zodiac', 'b_painted', 'b_anaglyph', 'b_plasma', 'b_erratic'
}

function ap_back_for_id(_id)
    local index = math.ceil((_id - 399) / 8)
    return AP_BACK_KEYS[index]
end
