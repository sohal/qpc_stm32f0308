add_executable(blinky)

target_sources(blinky
    PRIVATE
    ${CMAKE_SOURCE_DIR}/__startup/__vectors.c
    ./Core/Src/main.c
)

target_compile_definitions(blinky
    PRIVATE
)

target_link_libraries(blinky
    app
)

target_include_directories(blinky
    PRIVATE
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${cmsis_SOURCE_DIR}/Device/ARM/ARMCM0/Include>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${cmsis_SOURCE_DIR}/CMSIS/Core/Include>"
)

target_compile_options(blinky
    PRIVATE
    ${TARGET_NAME} PRIVATE
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:ASM>>:-g3>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:-g3>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:CXX>>:-g3>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:ASM>>:-g0>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:C>>:-g0>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:CXX>>:-g0>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:C>>:-Os>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:CXX>>:-Os>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:CXX>>:>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:C>>:>"
    "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<COMPILE_LANGUAGE:CXX>>:>"
    "$<$<CONFIG:Debug>:-mcpu=cortex-m0>"
    "$<$<NOT:$<CONFIG:Debug>>:-mcpu=cortex-m0>"
)

target_link_options(blinky
    PRIVATE
    --specs=nosys.specs
    -Wl,-Map=blinky.map -Xlinker --cref
    "$<$<CONFIG:Debug>:-mcpu=cortex-m0>"
    "$<$<NOT:$<CONFIG:Debug>>:-mcpu=cortex-m0>"
    -T
    "$<$<CONFIG:Debug>:${CMAKE_SOURCE_DIR}/__linker/gcc_arm.ld>"
    "$<$<NOT:$<CONFIG:Debug>>:${CMAKE_SOURCE_DIR}/__linker/gcc_arm.ld>"
)

add_custom_command(
    TARGET blinky POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:blinky>
)


add_custom_command(
    TARGET blinky POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex
    $<TARGET_FILE:blinky> blinky.hex
)

add_custom_command(
    TARGET blinky POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary
    $<TARGET_FILE:blinky> blinky.bin
)