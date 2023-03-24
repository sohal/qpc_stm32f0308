# Minimum version for cmake compatiblity
cmake_minimum_required(VERSION 3.22)
include(CMakePrintHelpers)
include(FetchContent)
# Set branch names for the sub modules dependencies
set(GITHUB_BRANCH_TOOLCHAIN "HEAD" CACHE STRING "git SHA for CMake Toolchain")
# set the location of all fetched repos

# show limited messages while cloning git repos
set(FETCHCONTENT_QUIET ON)

cmake_print_variables(GITHUB_BRANCH_TOOLCHAIN)
FetchContent_Declare(
    platform_cmake                             # Recommendation: Stick close to the original name.
    GIT_REPOSITORY  git@github.com:Hillrom-Enterprise/platfORm_cmake.git
    GIT_TAG         ${GITHUB_BRANCH_TOOLCHAIN}
)

# pre-fetch the toolchain repository as the first job before project configuration
FetchContent_GetProperties(platform_cmake)

if(NOT platform_cmake_POPULATED)
    FetchContent_Populate(platform_cmake)
endif()

project("stm32f0308_disco" C CXX ASM)

include(cmake/lib_cmsis.cmake)
include(cmake/lib_qpc.cmake)
include(cmake/lib_app.cmake)
include(cmake/lib_hal.cmake)
include(cmake/qpc_app.cmake)
