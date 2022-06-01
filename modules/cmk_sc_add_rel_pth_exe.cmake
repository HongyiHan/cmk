include(cmk_add_executable.cmake)
include(cmk_get_relative_path.cmake)

# Add an executable with a specific target name which is generated from its relative path.
#
# sc  - shortcut
# rel - relative
# pth - path
# exe - executable
#
# 添加一个可执行程序，其最终的目标名称是由 一个相对路径 和 调用者传入的名称 组合而成，以保证目标名称的唯一性。
#   1. 获取从 ${PROJECT_SOURCE_DIR} 到 ${CMAKE_CURRENT_SOURCE_DIR} 的相对路径
#   2. 将相对路径中的 '/' 替换为 '__' 得到目标名称的前缀
#   3. 最终的目标名称为：目标名称的前缀 + '__' + 调用者传入的名称
function(cmk_sc_add_rel_pth_exe)

    # cmk_sc_add_rel_pth_exe(<target>
    #                        <source>...
    #                        [OUTPUT_NAME <name>]
    #                        [LINK_LIBRARIES <library>...]
    #                        [SOURCE_FILES <source>...])
    set(ARG_TARGET ${ARGV0})
    set(options)
    set(oneValueArgs OUTPUT_NAME)
    set(multiValueArgs LINK_LIBRARIES SOURCE_FILES)
    cmake_parse_arguments(PARSE_ARGV 1 "ARG" "${options}" "${oneValueArgs}" "${multiValueArgs}")

    cmk_get_relative_path(CURRENT_DIRECTORY_RELATIVE_PATH)
    string(REPLACE / __ TARGET_NAME_PREFIX ${CURRENT_DIRECTORY_RELATIVE_PATH})
    set(TARGET_FULL_NAME ${TARGET_NAME_PREFIX}__${ARG_TARGET})

    set(TARGET_OUTPUT_NAME ${ARG_OUTPUT_NAME})
    if(NOT TARGET_OUTPUT_NAME)
        set(TARGET_OUTPUT_NAME ${ARG_TARGET})
    endif()

    list(APPEND TARGET_SOURCE_FILES ${ARG_SOURCE_FILES} ${ARG_UNPARSED_ARGUMENTS})
    list(LENGTH TARGET_SOURCE_FILES TARGET_SOURCE_FILES_LENGTH)
    if(NOT TARGET_SOURCE_FILES_LENGTH)
        list(APPEND TARGET_SOURCE_FILES ${ARG_TARGET}.cpp)
    endif()

    cmk_add_executable(${TARGET_FULL_NAME}
                       OUTPUT_NAME ${TARGET_OUTPUT_NAME}
                       SOURCE_FILES ${TARGET_SOURCE_FILES}
                       LINK_LIBRARIES ${ARG_LINK_LIBRARIES})

endfunction()
