function(cmk_set_system_name)

    if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
        set(Linux 1 PARENT_SCOPE)
    elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
        set(Darwin 1 PARENT_SCOPE)
    elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
        set(Windows 1 PARENT_SCOPE)
    endif()

endfunction()
