---@diagnostic disable: undefined-global

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
    fmt("import {} from {};", {
      c(2, {
        sn("named import", { t("{ "), i(1, "named import"), t(" }") }),
        sn("default import", i(1, "default import")),
        sn("namespace import", { t("* as "), i(1, "namespace import") }),
      }),
      i(1, "specifier"),
    })
  ),
}
