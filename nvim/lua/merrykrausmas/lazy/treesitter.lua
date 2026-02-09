return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({})

        vim.treesitter.language.register("templ", "templ")

        local installed = require("nvim-treesitter").get_installed()
        local ensure = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "jsdoc", "bash" }
        local to_install = vim.tbl_filter(function(lang)
            return not vim.list_contains(installed, lang)
        end, ensure)
        if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
        end
    end
}
