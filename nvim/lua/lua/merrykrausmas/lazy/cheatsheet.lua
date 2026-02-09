return {
    "ibhagwan/fzf-lua",
    keys = {
        {
            "<leader>?",
            function()
                local entries = {
                    -- Neovim: Core
                    "[nvim:core]  Space pv       │ Toggle Neo-tree file explorer",
                    "[nvim:core]  Ctrl+d         │ Half-page down (centered)",
                    "[nvim:core]  Ctrl+u         │ Half-page up (centered)",
                    "[nvim:core]  J (visual)     │ Move selection down",
                    "[nvim:core]  K (visual)     │ Move selection up",
                    "[nvim:core]  Space f         │ Format buffer (LSP)",
                    "[nvim:core]  Space s         │ Search & replace word under cursor",
                    "[nvim:core]  Space x         │ Make file executable",
                    "[nvim:core]  Space Space     │ Source current file",
                    "[nvim:core]  Space y         │ Yank to system clipboard",
                    "[nvim:core]  Space Y         │ Yank line to system clipboard",
                    "[nvim:core]  Space d         │ Delete without yanking",
                    "[nvim:core]  Space p (vis)   │ Paste over without yanking",
                    "[nvim:core]  Ctrl+k / Ctrl+j │ Next/prev quickfix",
                    "[nvim:core]  Space k / j     │ Next/prev location list",

                    -- Neovim: LSP
                    "[nvim:lsp]   gd              │ Go to definition",
                    "[nvim:lsp]   K               │ Hover documentation",
                    "[nvim:lsp]   Space vws       │ Workspace symbol search",
                    "[nvim:lsp]   Space vd        │ Open diagnostic float",
                    "[nvim:lsp]   Space vca       │ Code action",
                    "[nvim:lsp]   Space vrr       │ Find references",
                    "[nvim:lsp]   Space vrn       │ Rename symbol",
                    "[nvim:lsp]   Ctrl+h (ins)    │ Signature help",
                    "[nvim:lsp]   [d / ]d         │ Next/prev diagnostic",

                    -- Neovim: Completion
                    "[nvim:cmp]   Ctrl+p          │ Select previous item",
                    "[nvim:cmp]   Ctrl+n          │ Select next item",
                    "[nvim:cmp]   Ctrl+y          │ Accept completion",
                    "[nvim:cmp]   Ctrl+Space      │ Show completions",

                    -- Neovim: FZF
                    "[nvim:fzf]   Space pf        │ Find files",
                    "[nvim:fzf]   Ctrl+p          │ Git files",
                    "[nvim:fzf]   Space ps        │ Grep (prompted)",
                    "[nvim:fzf]   Space pg        │ Live grep",
                    "[nvim:fzf]   Space pws       │ Grep word under cursor",
                    "[nvim:fzf]   Space vh        │ Help tags",
                    "[nvim:fzf]   Space gs        │ Git status",
                    "[nvim:fzf]   Space gb        │ Git branches",
                    "[nvim:fzf]   Space gc        │ Git commits",
                    "[nvim:fzf]   Space gC        │ Git buffer commits",

                    -- Neovim: Harpoon
                    "[nvim:harp]  Space a         │ Add file to harpoon",
                    "[nvim:harp]  Ctrl+e          │ Toggle harpoon menu",
                    "[nvim:harp]  Ctrl+h/t/n/s    │ Jump to file 1/2/3/4",

                    -- Neovim: Fugitive
                    "[nvim:git]   Space gf        │ Open Fugitive",
                    "[nvim:git]   = (fugitive)    │ Inline expand diff",
                    "[nvim:git]   s (fugitive)    │ Stage file",
                    "[nvim:git]   u (fugitive)    │ Unstage file",
                    "[nvim:git]   cc (fugitive)   │ Commit",
                    "[nvim:git]   dv (fugitive)   │ Vertical diff split",
                    "[nvim:git]   Space p (fug)   │ Git push",
                    "[nvim:git]   Space P (fug)   │ Git pull --rebase",
                    "[nvim:git]   gu              │ Take left (ours)",
                    "[nvim:git]   gh              │ Take right (theirs)",

                    -- Neovim: Other
                    "[nvim:misc]  Space u         │ Toggle undotree",
                    "[nvim:misc]  Space lg        │ Open LazyGit",
                    "[nvim:misc]  Space mp        │ Markdown preview",
                    "[nvim:misc]  Space ?         │ This cheat sheet",

                    -- Tmux
                    "[tmux]       Prefix d        │ Detach session",
                    "[tmux]       Prefix s        │ List sessions",
                    "[tmux]       Prefix $        │ Rename session",
                    "[tmux]       Prefix c        │ New window",
                    "[tmux]       Prefix ,        │ Rename window",
                    "[tmux]       Prefix n/p      │ Next/prev window",
                    "[tmux]       Prefix 0-9      │ Switch window by number",
                    "[tmux]       Prefix %        │ Split vertical",
                    '[tmux]       Prefix "        │ Split horizontal',
                    "[tmux]       Prefix h/j/k/l  │ Navigate panes",
                    "[tmux]       Prefix x        │ Kill pane",
                    "[tmux]       Prefix z        │ Toggle pane zoom",
                    "[tmux]       Prefix [        │ Enter copy mode",

                    -- AeroSpace
                    "[aero:app]   Alt+q           │ Ghostty → ws 1",
                    "[aero:app]   Alt+w           │ Cursor → ws 2",
                    "[aero:app]   Alt+e           │ Chrome → ws 3",
                    "[aero:app]   Alt+r           │ Slack → ws 4",
                    "[aero:app]   Alt+t           │ Spotify → ws 5",
                    "[aero:ws]    Alt+1-9         │ Focus workspace",
                    "[aero:ws]    Alt+Shift+1-9   │ Move window to workspace",
                    "[aero:ws]    Alt+Tab         │ Toggle last workspace",
                    "[aero:win]   Alt+h/j/k/l     │ Focus direction",
                    "[aero:win]   Alt+Shift+hjkl  │ Move window direction",
                    "[aero:win]   Alt+f           │ Toggle fullscreen",
                    "[aero:win]   Alt+Ctrl+f      │ Toggle floating/tiling",
                    "[aero:win]   Alt+/           │ Toggle h/v tiles",
                    "[aero:win]   Alt+,           │ Toggle accordion",
                    "[aero:win]   Alt+Shift+-/=   │ Resize smaller/larger",
                    "[aero:svc]   Alt+Shift+;     │ Enter service mode",

                    -- Atuin
                    "[atuin]      Ctrl+r          │ Interactive history search",
                    "[atuin]      Up arrow        │ Browse filtered history",
                    "[atuin]      Tab (in search) │ Put on prompt without exec",
                    "[atuin]      Ctrl+r (cycle)  │ Global → session → directory",

                    -- Shell
                    "[shell]      c               │ clear",
                    "[shell]      e               │ exit",
                    "[shell]      n               │ nvim",
                    "[shell]      t               │ tmux-sessionizer",
                    "[shell]      tko             │ tmux kill-server",
                    "[shell]      l               │ eza -l --icons --git",
                    "[shell]      lt              │ eza tree (long)",
                    "[shell]      ltree           │ eza tree",
                    "[shell]      lf              │ tree → fzf → nvim",
                }

                require("fzf-lua").fzf_exec(entries, {
                    prompt = "Cheat Sheet❯ ",
                    winopts = {
                        height = 0.8,
                        width = 0.75,
                        preview = { hidden = "hidden" },
                    },
                    fzf_opts = {
                        ["--header"] = "Type to filter │ [nvim] [tmux] [aero] [atuin] [shell]",
                    },
                })
            end,
            desc = "Cheat Sheet",
        },
    },
}
