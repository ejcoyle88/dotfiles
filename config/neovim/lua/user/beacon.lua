local status_ok, beacon = pcall(require, "beacon")
if not status_ok then
    return
end

vim.g.beacon_minimal_jump = 5
