-- ~/.config/nvim-new/lsp/intelephense.lua
---@type vim.lsp.Config
return {
    cmd = { '/home/marius/.local/share/nvim/mason/bin/intelephense','--stdio'},
    filetypes = { 'php' },
    root_markers = { 'composer.json' },
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    settings = {
        intelephense = {
            init_options = {
                ['indexer.enabled_watchers'] = {
                    'lsp',
                },
                ['completion_worse.completor.keyword.enabled'] = true,
                ['language_server_worse_reflection.inlay_hints.enable'] = true,
                ['language_server_worse_reflection.inlay_hints.types'] = true,
                ['language_server_worse_reflection.inlay_hints.params'] = true,
                ['indexer.searcher_semi_fuzzy'] = true,
            },
            stubs = {"bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo", "filter", "gd", "gettext", "hash", "iconv", "imap", "intl", "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", "regex", "session", "SimpleXML", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml", "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib"},
            environment = {
                includePaths = {'/home/marius/Projects/'},
                shortOpenTag = true
            },
            format = {
                enable = false,
            },
            files = {
                maxSize = 5000000;
            },
        },
    }
}
