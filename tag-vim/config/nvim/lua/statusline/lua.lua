local cmd = vim.cmd
local fn = vim.fn
local gl = require("galaxyline")
local section = gl.section
local condition = require('galaxyline.condition')
local utils = require('misc-utils.lua')

gl.short_line_list = {"LuaTree", "packager", "Floaterm", "coc-eplorer", "NvimTree"}

local moon_colors = {
  bg = "#121212",
  section_bg = "#38393f",
  fg = "#9e9e9e",
  line_bg = "#121212",
  fg_green = "#36c692",
  yellow = "#e3c78a",
  cyan = "#74b2ff",
  darkblue = "#80a0ff",
  green = "#36c692",
  orange = "#de935f",
  purple = "#d183e8",
  magenta = "#ff5189",
  grey = "#9e9e9e",
  blue = "#80a0ff",
  red = "#ff5454"
}

-------------------------------- HELPER FUNCTIONS ------------------------------
local buffer_not_empty = function() return not utils.is_buffer_empty() end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value[1] == val then return true end
    end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = moon_colors.green, -- NORMAL
        [105] = moon_colors.blue,  -- INSERT
        [99] = moon_colors.green,  -- COMMAND
        [116] = moon_colors.blue,  -- TERMINAL
        [118] = moon_colors.purple,-- VISUAL
        [22] = moon_colors.purple, -- V-BLOCK
        [86] = moon_colors.purple, -- V-LINE
        [82] = moon_colors.red,   -- REPLACE
        [115] = moon_colors.red,  -- SELECT
        [83] = moon_colors.red    -- S-LINE
    }

    mode_color = mode_colors[vim.fn.mode():byte()]
    if mode_color ~= nil then
        return mode_color
    else
        return moon_colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return ' ? ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. ' ? ' end
    end
    return file .. ' '
end


local function get_basename(file) return file:match("^.+/(.+)$") end

local GetGitRoot = function()
    local git_dir = require('galaxyline.provider_vcs').get_git_dir()
    if not git_dir then return '' end

    local git_root = git_dir:gsub('/.git/?$', '')
    return get_basename(git_root)
end

-------------------------------- SECTIONS --------------------------------------
section.left[1] = {
  ViMode = {
    provider = function()
        local aliases = {
            [110] = 'NORMAL',
            [105] = 'INSERT',
            [99] = 'COMMAND',
            [116] = 'TERMINAL',
            [118] = 'VISUAL',
            [22] = 'V-BLOCK',
            [86] = 'V-LINE',
            [82] = 'REPLACE',
            [115] = 'SELECT',
            [83] = 'S-LINE'
        }
        cmd('hi GalaxyViMode guibg=' .. mode_color())
        alias = aliases[vim.fn.mode():byte()]
        if alias ~= nil then
            if utils.has_width_gt(35) then
                mode = alias
            else
                mode = alias:sub(1, 1)
            end
        else
            mode = vim.fn.mode():byte()
        end
        return '  ' .. mode .. ' '
    end,
    highlight = {moon_colors.bg, moon_colors.bg, 'bold'}
  }
}
section.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            moon_colors.section_bg
        }
    }
}
--section.left[3] = {
--    FileName = {
--        provider = get_current_file_name,
--        condition = buffer_not_empty,
--        highlight = {moon_colors.fg, moon_colors.section_bg},
--        separator = '',
--        separator_highlight = {moon_colors.section_bg, moon_colors.bg}
--    }
--}
section.left[9] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = ' ? ',
        highlight = {moon_colors.red, moon_colors.bg}
    }
}
section.left[10] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}
section.left[11] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = ' ? ',
        highlight = {moon_colors.orange, moon_colors.bg}
    }
}
section.left[12] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}
section.left[13] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = ' ? ',
        highlight = {moon_colors.blue, moon_colors.section_bg},
        separator = ' ',
        separator_highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}


section.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '+',
        highlight = {moon_colors.green, moon_colors.bg}
    }
}
section.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = {moon_colors.orange, moon_colors.bg}
    }
}
section.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = {moon_colors.red, moon_colors.bg}
    }
}
section.right[4] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}
section.right[5] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = condition.check_git_workspace,
        highlight = {moon_colors.middlegrey, moon_colors.bg}
    }
}
section.right[6] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = {moon_colors.middlegrey, moon_colors.bg}
    }
}
section.right[7] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}
section.right[8] = {
    GitRoot = {
        provider = {GetGitRoot, function() return ' ' end},
        condition = function()
            return utils.has_width_gt(45) and condition.check_git_workspace
        end,
        highlight = {moon_colors.middlegrey, moon_colors.bg}
    }
}
--section.right[9] = {
--    PerCent = {
--        provider = 'LinePercent',
--        separator = '',
--        separator_highlight = {moon_colors.section_bg, moon_colors.bg},
--        highlight = {moon_colors.bg, moon_colors.section_bg}
--    }
--}


-- Short status line
section.short_line_left[1] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = function()
            return buffer_not_empty and
                       has_value(gl.short_line_list, vim.bo.filetype)
        end,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            moon_colors.section_bg
        }
    }
}
section.short_line_left[2] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {moon_colors.fg, moon_colors.section_bg},
        separator = '',
        separator_highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}

section.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {moon_colors.yellow, moon_colors.section_bg},
        separator = '',
        separator_highlight = {moon_colors.section_bg, moon_colors.bg}
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
