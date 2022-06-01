# Add an executable.
#
# 添加一个可执行程序。
function(cmk_add_executable)

    # cmk_add_executable(<target>
    #                    <source>...
    #                    [OUTPUT_NAME <name>]
    #                    [LINK_LIBRARIES <library>...]
    #                    [SOURCE_FILES <source>...])
    set(ARG_TARGET ${ARGV0})
    set(options)
    set(oneValueArgs OUTPUT_NAME)
    set(multiValueArgs LINK_LIBRARIES SOURCE_FILES)
    cmake_parse_arguments(PARSE_ARGV 1 "ARG" "${options}" "${oneValueArgs}" "${multiValueArgs}")

    add_executable(${ARG_TARGET} ${ARG_UNPARSED_ARGUMENTS} ${ARG_SOURCE_FILES})

    if(ARG_OUTPUT_NAME)
        set_property(TARGET ${ARG_TARGET} PROPERTY OUTPUT_NAME ${ARG_OUTPUT_NAME})
    endif()

    if(ARG_LINK_LIBRARIES)
        target_link_libraries(${ARG_TARGET} ${ARG_LINK_LIBRARIES})
    endif()

endfunction()
