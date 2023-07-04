local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
	return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
	defaults = {
		initial_mode = 'normal',
		wrap_results = true,
		mappings = {
			n = {
				["q"] = actions.close
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			previewer = false,
			-- disables netrw and use telescope-file-browser in its place
			path = "%:p:h",
			cwd = telescope_buffer_dir(),
			grouped = true,
			hijack_netrw = true,
			git_status = true,
			layout_config = { height = 40 },
			select_buffer = true,
			hidden = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function() vim.cmd('normal vbd') end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd('startinsert')
					end
				},
			},
		},
		emoji = {
			action = function(emoji)
				-- argument emoji is a table.
				-- {name="", value="", cagegory="", description=""}
				--vim.fn.setreg("*", emoji.value)
				--print([[Press p or "*p to paste this emoji]] .. emoji.value)

				-- insert emoji when picked
				vim.api.nvim_put({ emoji.value }, 'c', false, true)
			end,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
				-- even more opts
			}

			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		}
	},
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
telescope.load_extension("emoji")
--telescope.load_extension("flutter")

vim.keymap.set('n', ';f',
	function()
		builtin.find_files({
			no_ignore = false,
			hidden = true
		})
	end)
vim.keymap.set('n', ';r', function()
	builtin.live_grep()
end)
vim.keymap.set('n', '\\\\', function()
	builtin.buffers()
end)
vim.keymap.set('n', ';t', function()
	builtin.help_tags()
end)
vim.keymap.set('n', ';;', function()
	builtin.resume()
end)
vim.keymap.set('n', ';e', function()
	builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
	--vim.cmd('tabnew ' .. telescope_buffer_dir())
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
		git_status = true,
	})
end)
vim.keymap.set("n", "fs", function()
	vim.cmd('tabnew ' .. telescope_buffer_dir())
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
		git_status = true,
	})
end)
vim.keymap.set("n", "tf", function()
	vim.cmd('tabnew ' .. telescope_buffer_dir())
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		cwd_to_path = true,
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
		git_status = true,
	})
end)
vim.keymap.set("n", "ff", function()
	telescope.extensions.file_browser.file_browser({
		path = ".",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		git_status = true,
		layout_config = { height = 40 }
	})
end)
local uv = vim.loop
local function folderExists(path)
	local stat = uv.fs_stat(path)
	return stat and stat.type == 'directory'
end
--print(folderExists(vim.fn.getcwd() .. '/app'))
if folderExists(vim.fn.getcwd() .. '/app') then
	vim.keymap.set("n", "ft", function()
		telescope.extensions.file_browser.file_browser({
			path = "./app",
			cwd = telescope_buffer_dir(),
			cwd_to_path = true,
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 },
			git_status = true,
		})
	end)
end
if folderExists(vim.fn.getcwd() .. '/lib') then
	vim.keymap.set("n", "ft", function()
		telescope.extensions.file_browser.file_browser({
			path = "./lib",
			cwd = telescope_buffer_dir(),
			cwd_to_path = true,
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 },
			git_status = true,
		})
	end)
end
if folderExists(vim.fn.getcwd() .. '/src') then
	vim.keymap.set("n", "ft", function()
		telescope.extensions.file_browser.file_browser({
			path = "./src",
			cwd = telescope_buffer_dir(),
			cwd_to_path = true,
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 },
			git_status = true,
		})
	end)
end
