---@diagnostic disable: undefined-global

local template = [[
```{}
{}
```
]]

local function fenced_code_block(lang, placeholder)
  return s(
    { trig = lang, name = lang:upper() .. " fenced code block" },
    fmt(template, { t(lang), insert_selected_text(1, placeholder) })
  )
end

return {
  s(
    { trig = "code", name = "code block" },
    fmt(template, { i(1), insert_selected_text(2) })
  ),
  fenced_code_block("html"),
  fenced_code_block("css"),
  fenced_code_block("bash"),
  fenced_code_block("js"),
  fenced_code_block("ts"),
  fenced_code_block("tsx"),
}
