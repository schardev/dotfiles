---@diagnostic disable: undefined-global
return {
  -- react component
  s(
    { trig = "rfc", name = "React Component" },
    fmt(
      [[
  const {} = ({}) => {{
    return (
      <>
        {}
      </>
    )
  }};

  export default {};
  ]],
      {
        insert_filename(1, 1, "pascal"),
        c(2, {
          i(1, "props"),
          i(1, "{ children }"),
        }),
        insert_selected_text(3),
        rep(1),
      }
    )
  ),
}
