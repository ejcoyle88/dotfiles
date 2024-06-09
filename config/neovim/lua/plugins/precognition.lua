return {
    {
        "tris203/precognition.nvim",
        config = function()
            require("precognition").show()
            nnoremaps("<leader>pt", ":lua require(\"precognition\").toggle()<cr>")
            nnoremaps("<leader>pp", ":lua require(\"precognition\").peek()<cr>")
        end
    }
}
