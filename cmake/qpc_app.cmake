add_executable(blinky)

target_sources(blinky
    PRIVATE
    ${CMAKE_SOURCE_DIR}/__startup/__vectors.c
)

target_link_libraries(blinky
    app
)
message(STATUS ${CMSISCORE})
target_include_directories(blinky
    PUBLIC
    ${cmsis_DEVICE_INCLUDE_DIR}
)

set(targetName blinky)

set(${targetName}_LINKER_PATH "${CMAKE_SOURCE_DIR}/__linker")
set(${targetName}_LINKER_SCRIPT "gcc_arm.ld")
set(${targetName}_SCATTER_PATH "${CMAKE_SOURCE_DIR}/__linker")
set(${targetName}_SCATTER_FILE "ac6_arm.sct")
set(${targetName}_LLVM_LINKER_PATH "${CMAKE_SOURCE_DIR}/__linker")
set(${targetName}_LLVM_LINKER_SCRIPT "llvm_arm.ld")
setTargetCompileOptions(targetName)
setTargetLinkOptions(targetName)

convertELF_BIN_HEX (${targetName})
