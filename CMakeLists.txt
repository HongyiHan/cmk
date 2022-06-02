cmake_minimum_required(VERSION 3.16.3)

project(cmk)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/modules)

add_subdirectory(modules)

#[[
set(CMK_INCLUDE_ALL_MODULE OFF CACHE BOOL "")
set(CMK_EXPORT_MODULE_PATH OFF CACHE BOOL "")

if(CMK_INCLUDE_ALL_MODULE)
    add_subdirectory(modules)
endif()

if(CMK_EXPORT_MODULE_PATH)
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} PARENT_SCOPE)
endif()
]]
