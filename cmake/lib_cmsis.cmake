include(CMakePrintHelpers)
include(FetchContent)

set(GITHUB_BRANCH_CMSIS "5.9.0")
#set(GITHUB_BRANCH_CMSIS_DSP "v1.10.1")
cmake_print_variables(GITHUB_BRANCH_CMSIS)

FetchContent_Declare(
    cmsis                             # Recommendation: Stick close to the original name.
    URL https://github.com/ARM-software/CMSIS_5/archive/refs/tags/${GITHUB_BRANCH_CMSIS}.tar.gz
    URL_HASH MD5=6b67968b5a3540156a4bd772d899339e
)

FetchContent_GetProperties(cmsis)

if(NOT cmsis_POPULATED)
    FetchContent_Populate(cmsis)
endif()
cmake_print_variables(cmsis_SOURCE_DIR)