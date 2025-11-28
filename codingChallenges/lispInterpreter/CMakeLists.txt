cmake_minimum_required(VERSION 3.25)
project(lisp)

set(CMAKE_CXX_STANDARD 23)

include(CMakePrintHelpers)

find_package(absl REQUIRED)
FIND_PACKAGE(BISON REQUIRED)
FIND_PACKAGE(FLEX REQUIRED)

BISON_TARGET(MyParser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c
	DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.h)

FLEX_TARGET(MyLexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c
	DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.h)

SET_SOURCE_FILES_PROPERTIES( main.c PROPERTIES LANGUAGE CXX )
SET_SOURCE_FILES_PROPERTIES( lex.yy.c PROPERTIES LANGUAGE CXX )
SET_SOURCE_FILES_PROPERTIES( parser.tab.c PROPERTIES LANGUAGE CXX )

cmake_print_variables( BISON_MyParser_OUTPUTS FLEX_MyLexer_OUTPUTS )
add_executable(lisp main.c sayhello.cpp ast.cpp ${BISON_MyParser_OUTPUTS} ${FLEX_MyLexer_OUTPUTS}  )
target_link_libraries( lisp absl::log )
target_include_directories( lisp PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} )

# enable testing functionality
enable_testing()

add_subdirectory(tests)
