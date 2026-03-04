-- define colourscheme here
local colourscheme = {
	'gruber-darker',
	'monokai_pro',
	'ayu',
	'miasma',
	'melange',
	'thorn',
	'gruvbox',
}

local colourSelect = 7

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colourscheme[colourSelect])
if not is_ok then
	vim.notify('colourscheme' .. colourscheme[colourSelect] .. ' not found!')
	return

end
