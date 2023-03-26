add_executable(blinky)

target_sources(blinky
    PRIVATE
    ${CMAKE_SOURCE_DIR}/__startup/__vectors.c
    ./Core/Src/main.c
)

target_link_libraries(blinky
    app
)

target_include_directories(blinky
    PRIVATE
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${cmsis_SOURCE_DIR}/Device/ARM/ARMCM0/Include>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${cmsis_SOURCE_DIR}/CMSIS/Core/Include>"
)

set(targetName blinky)

set(${targetName}_LINKER_PATH "${CMAKE_SOURCE_DIR}/__linker")
set(${targetName}_LINKER_SCRIPT "gcc_arm.ld")
set(${targetName}_SCATTER_PATH "${CMAKE_SOURCE_DIR}/__linker")
set(${targetName}_SCATTER_FILE "ac6_arm.sct")
setTargetCompileOptions(targetName)
setTargetLinkOptions(targetName)

convertELF_BIN_HEX (${targetName})
