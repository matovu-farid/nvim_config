local wk = require("which-key")


--
wk.register({
    t = {
        name = "TSTools",
        i = { ":TSToolsOrganizeImports<CR>", "Organise imports" },
        f = { ":TSToolsFixAll<CR>", "Fix All" },
        r = { ":TSToolsRenameFile<CR>", "Rename File" },
        a = { ":TSToolsAddMissingImports<CR>", "Add Missing imports" },
        l = { ":TSToolsFileReferences<CR>", "Locate File" },
        d = {":TSToolsGoToSourceDefinition<CR>", "Go to Definition"}
    },
}, { prefix = "<leader>" })
