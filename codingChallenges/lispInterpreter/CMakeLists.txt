cmake_minimum_required(VERSION 3.25)
project(lisp)

SET_SOURCE_FILES_PROPERTIES( main.c PROPERTIES LANGUAGE CXX )

add_executable(lisp main.c)
