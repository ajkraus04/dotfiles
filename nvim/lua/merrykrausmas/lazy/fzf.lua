return {
    "ibhagwan/fzf-lua",

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local fzf = require('fzf-lua')
        fzf.setup({})

        vim.keymap.set('n', '<leader>pf', fzf.files, {})
        vim.keymap.set('n', '<C-p>', fzf.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            fzf.grep({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            fzf.grep({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            fzf.grep({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>pg', fzf.live_grep, {})
        vim.keymap.set('n', '<leader>vh', fzf.help_tags, {})
        vim.keymap.set('n', '<leader>gs', fzf.git_status, {})
        vim.keymap.set('n', '<leader>gb', fzf.git_branches, {})
        vim.keymap.set('n', '<leader>gc', fzf.git_commits, {})
        vim.keymap.set('n', '<leader>gC', fzf.git_bcommits, {})
    end
}
