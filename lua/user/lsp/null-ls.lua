local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

local sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.phpcbf,
		formatting.golines.with({
			extra_args = {
			"--max-len=180",
			"--base-formatter=gofumpt",
			},
		}),
		--diagnostics.revive,
	  diagnostics.psalm,
		diagnostics.phpcs.with({ extra_args = { "--standard=phpcs_ruleset.xml" } }),
		code_actions.gitsigns,
	} 

-- for go.nvim
local gotest = require("go.null_ls").gotest()
local gotest_codeaction = require("go.null_ls").gotest_action()
local golangci_lint = require("go.null_ls").golangci_lint()
--table.insert(sources, gotest, golangci_lint)
--table.insert(sources, gotest_codeaction)

null_ls.setup({
	--debug = true,
	debounce = 1000,
	default_timeout = 5000,
	sources = sources,
})
null_ls.register(gotest)
