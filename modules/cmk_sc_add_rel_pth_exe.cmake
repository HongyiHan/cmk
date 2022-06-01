include(cmk_add_executable.cmake)
include(cmk_get_relative_path.cmake)

# Add an executable with a specific target name which is generated from its relative path.
#
# sc  - shortcut
# rel - relative
# pth - path
# exe - executable
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
