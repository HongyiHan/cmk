# Set a variable, named to system's name and value is 1, in current scope.
#
# 在调用了此函数的作用域中，添加以系统名称命名的变量，并将其值设为 1。
function(cmk_set_system_name)

    if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
        set(Linux 1 PARENT_SCOPE)
    elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
        set(Darwin 1 PARENT_SCOPE)
    elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
        set(Windows 1 PARENT_SCOPE)
    endif()

endfunction()
