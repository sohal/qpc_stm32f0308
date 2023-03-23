include(CMakePrintHelpers)

set(hal_core_INCLUDES_DIR "${CMAKE_SOURCE_DIR}/Core/Inc")
set(hal_core_SOURCE_DIR "${CMAKE_SOURCE_DIR}/Core/Src")
set(hal_core_SOURCES
    ${hal_core_SOURCE_DIR}/main.c
    ${hal_core_SOURCE_DIR}/stm32f0xx_hal_msp.c
    ${hal_core_SOURCE_DIR}/syscalls.c
    ${hal_core_SOURCE_DIR}/sysmem.c
    ${hal_core_SOURCE_DIR}/system_stm32f0xx.c
)

set(hal_drivers_CMSIS_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32F0xx/Include")
set(hal_drivers_legacy_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/Drivers/STM32F0xx_HAL_Driver/Inc/Legacy")
set(hal_drivers_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/Drivers/STM32F0xx_HAL_Driver/Inc")
set(hal_drivers_SOURCE_DIR "${CMAKE_SOURCE_DIR}/Drivers/STM32F0xx_HAL_Driver/Src")
set(hal_drivers_SOURCES
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_cortex.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_dma.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_exti.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_flash.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_flash_ex.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_gpio.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_i2c_ex.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_i2c.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_pwr_ex.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_pwr.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_rcc_ex.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_rcc.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_tim_ex.c
    ${hal_drivers_SOURCE_DIR}/stm32f0xx_hal_tim.c
)

add_library(hal STATIC)

target_sources(hal
    PRIVATE
    ${hal_core_SOURCES}
    ${hal_drivers_SOURCES}
)

target_include_directories(hal
    PUBLIC
    ${hal_core_INCLUDES_DIR}
    ${hal_drivers_INCLUDE_DIR}
    $<BUILD_INTERFACE:${hal_core_INCLUDES_DIR}>
    $<BUILD_INTERFACE:${hal_drivers_INCLUDE_DIR}>
    PRIVATE
    ${hal_drivers_legacy_INCLUDE_DIR}
    ${hal_drivers_CMSIS_INCLUDE_DIR}
    ${cmsis_SOURCE_DIR}/Device/ARM/ARMCM0/Include
    ${cmsis_SOURCE_DIR}/CMSIS/Core/Include
)

target_compile_definitions(hal
    PUBLIC
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:ASM>>:DEBUG>"
    "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:DEBUG>"
    USE_HAL_DRIVER
    STM32F030x8
)

target_compile_options(hal
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
