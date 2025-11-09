file(GLOB TEST_INPUT_FILES *.lsp)

cmake_print_variables( TEST_INPUT_FILES)


foreach  (testInputFile ${TEST_INPUT_FILES})
	cmake_print_variables( testInputFile)
	get_filename_component(TName ${testInputFile}  NAME_WE)
	cmake_print_variables( TName)
	add_test(NAME ${TName} COMMAND ${lisp_BINARY_DIR}/lisp ${testInputFile} )
endforeach()
