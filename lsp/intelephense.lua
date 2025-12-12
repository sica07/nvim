-- ~/.config/nvim-new/lsp/intelephense.lua
---@type vim.lsp.Config
return {
    cmd = { '/home/marius/.local/share/nvim/mason/bin/intelephense', '--stdio' },

    filetypes = { 'php' },

    root_dir = '/home/marius/Projects/aynax', 

    init_options = {
        storagePath = '/home/marius/.cache/intelephense',
        licenceKey = '004IK6UMSVGQXBL',  -- add yours if you have one
    },

    settings = {
        intelephense = {
            stubs = {
                "bcmath","bz2","Core","curl","date","dom","fileinfo","filter","gd",
                "gettext","hash","iconv","imap","intl","json","libxml","mbstring",
                "mcrypt","mysql","mysqli","password","pcntl","pcre","PDO","pdo_mysql",
                "Phar","readline","regex","session","SimpleXML","sockets","sodium",
                "standard","superglobals","tokenizer","xml","xdebug","xmlreader",
                "xmlwriter","yaml","zip","zlib"
            },

            environment = {
                shortOpenTag = true,
            },

            files = {
                maxSize = 50000000,
            },

            format = {
                enable = false,
            },
        },
    },
}
