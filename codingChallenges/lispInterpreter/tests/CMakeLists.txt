file(GLOB TEST_INPUT_FILES *.lsp)

cmake_print_variables( TEST_INPUT_FILES)

add_test(NAME test1 COMMAND true)
