cmake_minimum_required(VERSION 3.20)

project("stm32f0308_disco" C CXX ASM)

include(cmake/st-project.cmake)
include(cmake/lib_cmsis.cmake)

add_executable(${PROJECT_NAME})
add_st_target_properties(${PROJECT_NAME})