return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- for lazy pending updates count

		-- Bubbles color scheme
		local colors = {
			blue = "#80a0ff",
			cyan = "#79dac8",
			black = "#080808",
			white = "#c6c6c6",
			red = "#ff5189",
			violet = "#d183e8",
			grey = "#303030",
			fg = "#c6c6c6",
		}

		-- Bubbles theme with transparency
		local bubbles_theme = {
			normal = {
				a = { fg = colors.black, bg = colors.violet, gui = "bold" },
				b = { fg = colors.white, bg = "NONE" }, -- Transparent background
				c = { fg = colors.white, bg = "NONE" }, -- Transparent background
			},
			insert = { a = { fg = colors.black, bg = colors.blue, gui = "bold" } },
			visual = { a = { fg = colors.black, bg = colors.cyan, gui = "bold" } },
			replace = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },
			command = { a = { fg = colors.black, bg = colors.yellow, gui = "bold" } },
			inactive = {
				a = { fg = colors.white, bg = colors.black, gui = "bold" },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white, bg = "NONE" }, -- Transparent background
			},
		}

		-- Configure lualine with bubbles theme and transparency
		lualine.setup({
			options = {
				theme = bubbles_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "filename", "branch" },
				lualine_c = {
					"%=", -- center component placeholder
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
				lualine_y = { "filetype", "progress" },
				lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
