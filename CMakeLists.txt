cmake_minimum_required(VERSION 3.16.3)

project(
    cmk
    VERSION 0.0.2
    DESCRIPTION "CMake Modules Collection"
)

include(modules/cmk_set_system_name.cmake)
cmk_set_system_name()

if(Linux)
    set(CMK_INSTALL_SHARE_DIR share/${PROJECT_NAME})
elseif(Windows)
    set(CMK_INSTALL_SHARE_DIR share)
endif()

install(
    DIRECTORY modules
    DESTINATION ${CMK_INSTALL_SHARE_DIR}
)

include(CMakePackageConfigHelpers)
configure_package_config_file(
    config.cmake.in
    ${PROJECT_NAME}-config.cmake
    INSTALL_DESTINATION ${CMK_INSTALL_SHARE_DIR}
    PATH_VARS CMK_INSTALL_SHARE_DIR
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
    DESTINATION ${CMK_INSTALL_SHARE_DIR}
)
