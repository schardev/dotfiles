;; extends
(ternary_expression consequence: (_) @user.ternary.inner)
(ternary_expression alternative: (_) @user.ternary.inner)

; function Button() {}
((function_declaration
   name: (identifier) @user.jsx_component.name)
 @user.jsx_component.outer
 (#match? @user.jsx_component.name "^[A-Z]"))

; const Button = () => {}
; const Button = function() {}
((lexical_declaration (variable_declarator
    name: (identifier) @user.jsx_component.name
    value: [(arrow_function) (function_expression)]))
 @user.jsx_component.outer
 (#match? @user.jsx_component.name "^[A-Z]"))

; Button = () => {}
; Button = function() {}
((assignment_expression
   left: (identifier) @user.jsx_component.name
   right: [(arrow_function) (function_expression)])
 @user.jsx_component.outer
 (#match? @user.jsx_component.name "^[A-Z]"))
