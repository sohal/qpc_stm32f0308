set(app_SOURCE_DIR ${CMAKE_SOURCE_DIR}/app/qpc_adapter)
set(app_SOURCES
    ${app_SOURCE_DIR}/qpc_app.c
    ${app_SOURCE_DIR}/blinky.c
    ${app_SOURCE_DIR}/qk/bsp.c
)

add_library(app STATIC)

target_sources(app
    PRIVATE
    ${app_SOURCES}
)

target_include_directories(app
    PRIVATE
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${cmsis_SOURCE_DIR}/Device/ARM/ARMCM0/Include>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${cmsis_SOURCE_DIR}/CMSIS/Core/Include>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:${PROJECT_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32F0xx/Include>"
    PUBLIC
    ${app_SOURCE_DIR}
    $<BUILD_INTERFACE:${app_SOURCE_DIR}>
)

target_include_directories(app SYSTEM
    PUBLIC

    
)

target_compile_options(app
    PRIVATE
    -mcpu=cortex-m0 #ARM_CPU (cortex-m0, cortex-m1...)
                    #ARM_FPU (vfp)
                    #FLOAT_ABI (soft|softfp|hard)
    -mthumb
    -Wall
    -ffunction-sections
    -fdata-sections
    -O2
)

target_link_libraries(app
    hal
    qpc
)