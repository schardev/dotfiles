---@diagnostic disable: undefined-global

return {
  -- comment header
  s("header 1", {
    t("----------"),
    l(l._1:gsub(".", "-"), 1),
    t({ "----------", "" }),
    t("---       "),
    i(1, "header title"),
    t({ "       ---", "" }),
    t("----------"),
    l(l._1:gsub(".", "-"), 1),
    t({ "----------", "" }),
  }),
}
