local core_modules = {
    "core.plugins",
    "core.settings",
    "core.autocmd",
    "core.mappings",
}

vim.g.mapleader = " "

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end
