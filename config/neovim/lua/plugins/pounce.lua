return {
  {
    "rlane/pounce.nvim",
    dependencies = {
      "tpope/vim-repeat"
    },
    config = function()
      nnoremaps('s', '<cmd>Pounce<cr>')
      nnoremaps('S', '<cmd>PounceRepeat<cr>')
    end
  }
}
