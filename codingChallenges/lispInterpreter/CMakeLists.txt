cmake_minimum_required(VERSION 3.25)
project(lisp)

set(CMAKE_CXX_STANDARD 23)

find_package(absl REQUIRED)

SET_SOURCE_FILES_PROPERTIES( main.c PROPERTIES LANGUAGE CXX )
SET_SOURCE_FILES_PROPERTIES( lex.yy.c PROPERTIES LANGUAGE CXX )

add_executable(lisp main.c sayhello.cpp lex.yy.c )
target_link_libraries( lisp absl::log )
