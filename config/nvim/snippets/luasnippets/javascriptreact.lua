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
