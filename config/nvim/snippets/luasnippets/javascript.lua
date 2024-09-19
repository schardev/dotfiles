---@diagnostic disable: undefined-global
local utils = require("core.utils").string_utils

return {
  -- c-style for loop
  s(
    { trig = "forc", name = "For Loop" },
    fmt(
      [[
  for (let {} = 0; {} < {}; {}++) {{
    {}
  }}
  ]],
      {
        i(1, "i"),
        rep(1),
        c(2, {
          i(1, "j"),
          sn(1, { i(1, "array"), t(".length") }),
        }),
        rep(1),
        insert_selected_text(3),
      }
    )
  ),

  -- import statement
  s(
    { trig = "import", name = "Import Name" },
    fmt('import {} from "{}";', {
      c(2, {
        d(nil, function(args)
          local specifier = args[1][1]
          local import = utils.to_pascal_case(utils.basename(specifier))
          return sn(nil, { i(1, import) })
        end, { 1 }),
        sn(nil, { t("{ "), i(1, "named import"), t(" }") }),
        sn(nil, { t("* as "), i(1, "namespace import") }),
      }),
      i(1, "specifier"),
    })
  ),

  -- useeffect
  s(
    { trig = "rue", name = "React useEffect" },
    fmt(
      [[
  useEffect(() => {{
    {}
    {}
  }}{})
  ]],
      {
        i(1),
        c(2, {
          i(1),
          sn(nil, {
            t({ "return () => {", "" }),
            i(1),
            t({ "", "\t}" }),
          }),
        }),
        c(3, {
          i(1),
          sn(nil, { t(", ["), i(1), t("]") }),
        }),
      }
    )
  ),

  -- usestate
  s(
    { trig = "rus", name = "React useState" },
    fmt("const [{}, set{}] = useState({});", {
      i(1, "state"),
      l(l._1:gsub("^%l", string.upper), 1),
      i(2),
    })
  ),
}
