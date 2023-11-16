-- open perldoc beside the screen
--
-- ┌───────────────┌──────────────┐
-- │               │              │
-- │               │              │
-- │  code screen  │ Perldoc page │
-- │               │              │
-- │               │              │
-- └───────────────└──────────────┘
-- What this lua script do
-- 1. Get the function name under cursor
-- 2. Pass the function name and file name to perl script
-- 3. Recieve the module name from perl script
-- 4. Run :set splitright, :vsplit, :term perldoc modulename
--
-- What perl script do
-- 1. Get all modules and use them, may use:
-- while (<$fh>) {
--    eval $_ if m/^use/;
-- }
--
-- 2. Use CvGV(\&func) function in Devel::Peek module to get where the function from
-- 3. Return the module name
vim.g.perldoc_keymap = { "n", "gh", ":lua Perldoc()<CR>" }

if vim.bo.filetype == 'perl' or vim.bo.filetype == 'pl' then
  vim.keymap.set(vim.g.perldoc_keymap[1], vim.g.perldoc_keymap[2], vim.g.perldoc_keymap[3])
end

function RunPerl(file, args)
  local command = ""
  for _, arg in ipairs(args) do
    command = command .. " " .. arg
  end
  command = "perl " .. file .. command
  return vim.fn.system(command)
end

function Perldoc()
  local file_name = vim.fn.expand('%:p')
  local func_name = vim.fn.expand("<cword>")

  local perl_script = "../../perl/perldoc.pl"
  local perl_args = { file_name, func_name }
  local module_name = RunPerl(perl_script, perl_args)
  if not (module_name == 'main') then
    vim.cmd[[
      set splitright
      vsplit
    ]]
    vim.cmd('term perldoc' .. ' ' .. module_name)
  else
    print("Can not find this function's doc")
  end
end
