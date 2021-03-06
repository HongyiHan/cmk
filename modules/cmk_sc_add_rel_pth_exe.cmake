include(${CMAKE_CURRENT_LIST_DIR}/cmk_add_executable.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmk_get_relative_path.cmake)

# Add an executable with a specific target name which is generated from its relative path.
#
# sc  - shortcut
# rel - relative
# pth - path
# exe - executable
#
# 添加一个可执行程序，其最终的目标名称是由 一个相对路径 和 调用者传入的名称 组合而成，以保证目标名称的唯一性。
# 1. 最终的目标名称
#   a. 获取从 ${PROJECT_SOURCE_DIR} 到 ${CMAKE_CURRENT_SOURCE_DIR} 的相对路径
#   b. 将相对路径中的 '/' 替换为 '__' 得到目标名称的前缀
#   c. 最终的目标名称为：目标名称的前缀 + '__' + 调用者传入的名称
# 2. 默认的源文件
#   a. ${target_hint}.c
#   b. ${target_hint}.cpp
function(cmk_sc_add_rel_pth_exe)

    # cmk_sc_add_rel_pth_exe(<target_hint>                      input
    #                        <source>...                        input
    #                        [EXCLUDE_FROM_ALL]                 input
    #                        [OUTPUT_NAME <name>]               input
    #                        [LINK_LIBRARIES <library>...]      input
    #                        [SOURCE_FILES <source>...]         input
    #                        [TARGET_NAME <name>])              output
    set(ARG_TARGET_HINT ${ARGV0})
    set(options EXCLUDE_FROM_ALL)
    set(oneValueArgs OUTPUT_NAME TARGET_NAME)
    set(multiValueArgs LINK_LIBRARIES SOURCE_FILES)
    cmake_parse_arguments(PARSE_ARGV 1 "ARG" "${options}" "${oneValueArgs}" "${multiValueArgs}")

    cmk_get_relative_path(CURRENT_DIRECTORY_RELATIVE_PATH)
    string(REPLACE / __ TARGET_NAME_PREFIX ${CURRENT_DIRECTORY_RELATIVE_PATH})
    set(TARGET_NAME ${TARGET_NAME_PREFIX}__${ARG_TARGET_HINT})

    set(TARGET_OUTPUT_NAME ${ARG_OUTPUT_NAME})
    if(NOT TARGET_OUTPUT_NAME)
        set(TARGET_OUTPUT_NAME ${ARG_TARGET_HINT})
    endif()

    list(APPEND TARGET_SOURCE_FILES ${ARG_SOURCE_FILES} ${ARG_UNPARSED_ARGUMENTS})
    list(LENGTH TARGET_SOURCE_FILES TARGET_SOURCE_FILES_LENGTH)
    if(NOT TARGET_SOURCE_FILES_LENGTH)
        if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_TARGET_HINT}.c)
            list(APPEND TARGET_SOURCE_FILES ${ARG_TARGET_HINT}.c)
        elseif(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_TARGET_HINT}.cpp)
            list(APPEND TARGET_SOURCE_FILES ${ARG_TARGET_HINT}.cpp)
        else()
            message(FATAL_ERROR "Default source file not found for target_hint ${ARG_TARGET_HINT}.")
        endif()
    endif()

    if(ARG_EXCLUDE_FROM_ALL)
        set(ARG_EXCLUDE_FROM_ALL EXCLUDE_FROM_ALL)
    endif()

    cmk_add_executable(${TARGET_NAME}
                       ${ARG_EXCLUDE_FROM_ALL}
                       OUTPUT_NAME ${TARGET_OUTPUT_NAME}
                       SOURCE_FILES ${TARGET_SOURCE_FILES}
                       LINK_LIBRARIES ${ARG_LINK_LIBRARIES})

    if(ARG_TARGET_NAME)
        set(${ARG_TARGET_NAME} ${TARGET_NAME} PARENT_SCOPE)
    endif()

endfunction()
