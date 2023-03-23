include(CMakePrintHelpers)
include(FetchContent)

set(GITHUB_BRANCH_QPC "7.2.1")
cmake_print_variables(GITHUB_BRANCH_QPC)

FetchContent_Declare(
    qpc                             # Recommendation: Stick close to the original name.
    URL https://github.com/QuantumLeaps/qpc/archive/refs/tags/v7.2.1.tar.gz
    URL_HASH MD5=08a8912195287d740818ca3a9f954c99
)

FetchContent_GetProperties(qpc)

if(NOT qpc_POPULATED)
    FetchContent_Populate(qpc)
endif()
# Extract information for QPC framework
if(CMAKE_C_COMPILER_ID STREQUAL "ARMClang")
set(QPC_COMPILER_NAME "armclang" CACHE STRING "QPC port directory based on armclang compiler")
elseif(CMAKE_C_COMPILER_ID STREQUAL "GNU")
set(QPC_COMPILER_NAME "gnu" CACHE STRING "QPC port directory based on gnu c compiler")
else()
message(FATAL_ERROR "QPC can not be integrated with this compiler...")
endif()
cmake_print_variables(QPC_COMPILER_NAME)
if(NOT DEFINED qpc_SOURCE_DIR)
message(FATAL_ERROR "QPC Framework not downloaded.")
endif()
cmake_print_variables(qpc_SOURCE_DIR)

set(qpc_qf_SOURCES
    ${qpc_SOURCE_DIR}/src/qf/qep_hsm.c
    ${qpc_SOURCE_DIR}/src/qf/qep_msm.c
    ${qpc_SOURCE_DIR}/src/qf/qf_act.c
    ${qpc_SOURCE_DIR}/src/qf/qf_actq.c
    ${qpc_SOURCE_DIR}/src/qf/qf_defer.c
    ${qpc_SOURCE_DIR}/src/qf/qf_dyn.c
    ${qpc_SOURCE_DIR}/src/qf/qf_mem.c
    ${qpc_SOURCE_DIR}/src/qf/qf_ps.c
    ${qpc_SOURCE_DIR}/src/qf/qf_qact.c
    ${qpc_SOURCE_DIR}/src/qf/qf_qeq.c
    ${qpc_SOURCE_DIR}/src/qf/qf_qmact.c
    ${qpc_SOURCE_DIR}/src/qf/qf_time.c
)

set(qpc_qk_SOURCES
    ${qpc_SOURCE_DIR}/src/qk/qk.c
)

set(qpc_qs_SOURCES
    ${qpc_SOURCE_DIR}/src/qs/qs.c
#    ${qpc_SOURCE_DIR}/src/qs/qs_64bit.c
    ${qpc_SOURCE_DIR}/src/qs/qs_fp.c
    ${qpc_SOURCE_DIR}/src/qs/qs_rx.c
#    ${qpc_SOURCE_DIR}/src/qs/qstamp.c
#    ${qpc_SOURCE_DIR}/src/qs/qutest.c
)

set(qpc_qv_SOURCES
    ${qpc_SOURCE_DIR}/src/qv/qv.c
)

set(qpc_qxk_SOURCES
    ${qpc_SOURCE_DIR}/src/qxk/qxk.c
    ${qpc_SOURCE_DIR}/src/qxk/qxk_mutex.c
    ${qpc_SOURCE_DIR}/src/qxk/qxk_sema.c
    ${qpc_SOURCE_DIR}/src/qxk/qxk_xthr.c
)

set(qpc_ports_qk_PATH "${qpc_SOURCE_DIR}/ports/arm-cm/qk/${QPC_COMPILER_NAME}")
set(qpc_ports_arm-cm_qk_SOURCES
    ${qpc_ports_qk_PATH}/qk_port.c
)

add_library(qpc STATIC)

target_sources(qpc
    PRIVATE
    ${qpc_qf_SOURCES}
    ${qpc_qk_SOURCES}
    ${qpc_ports_arm-cm_qk_SOURCES}
)

target_include_directories(qpc

    PRIVATE
    ${qpc_ports_qk_PATH}
)

target_include_directories(qpc SYSTEM
    PUBLIC

    $<BUILD_INTERFACE:${qpc_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${qpc_SOURCE_DIR}/ports/arm-cm/qk/gnu>
)

target_compile_options(qpc
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