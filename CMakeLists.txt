cmake_minimum_required(VERSION 3.16.3)

project(
    cmk
    VERSION 0.0.3
    DESCRIPTION "CMake Modules Collection"
)

if(UNIX)
    set(CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME})
endif()

install(
    DIRECTORY modules
    DESTINATION .
)

include(CMakePackageConfigHelpers)
configure_package_config_file(
    config.cmake.in
    ${PROJECT_NAME}-config.cmake
    INSTALL_DESTINATION .
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)
write_basic_package_version_file(
    ${PROJECT_NAME}-config-version.cmake
    COMPATIBILITY SameMajorVersion
)
install(
    FILES
        ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
        ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    DESTINATION .
)
