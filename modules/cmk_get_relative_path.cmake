# Set the output variable ${OUTPUT_VARIABLE} to a path value which is relative from ${PROJECT_SOURCE_DIR} to ${CMAKE_CURRENT_SOURCE_DIR}.
#
# 输出变量 ${OUTPUT_VARIABLE} 将返回一个 相对路径字符串，该值指明从 ${PROJECT_SOURCE_DIR} 到 ${CMAKE_CURRENT_SOURCE_DIR} 的相对路径。
function(cmk_get_relative_path OUTPUT_VARIABLE)

    get_filename_component(TOP_DIR_ABS_PTH ${PROJECT_SOURCE_DIR} DIRECTORY)

    string(LENGTH ${TOP_DIR_ABS_PTH} TOP_DIR_ABS_PTH_LEN)

    math(EXPR TOP_DIR_ABS_PTH_LEN_ADD_ONE "${TOP_DIR_ABS_PTH_LEN} + 1")

    string(SUBSTRING ${CMAKE_CURRENT_SOURCE_DIR} ${TOP_DIR_ABS_PTH_LEN_ADD_ONE} -1 CUR_DIR_REL_PTH)

    set(${OUTPUT_VARIABLE} ${CUR_DIR_REL_PTH} PARENT_SCOPE)

endfunction()
