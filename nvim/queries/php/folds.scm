; Fold array creation expressions
((array_creation_expression) @fold)

; Fold array expressions with elements
((array_creation_expression
  "[" . (_) . "]") @fold)

; Fold associative arrays
((array_creation_expression
  "[" . (array_element_initializer) . "]") @fold)

; Fold multiline arrays
((array_creation_expression
  "[" . (_) . (_)+ . "]") @fold)
