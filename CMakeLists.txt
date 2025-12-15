cmake_minimum_required(VERSION 3.16)

project(LightCrafter4500 VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)
find_package(hidapi REQUIRED)

qt_standard_project_setup()

set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/ui)

set(SOURCES
    src/main.cpp
    src/mainwindow.cpp
    src/dlpc350_common.cpp
    src/dlpc350_usb.cpp
    src/dlpc350_api.cpp
    src/dlpc350_BMPParser.cpp
    src/dlpc350_firmware.cpp
)

set(HEADERS
    inc/mainwindow.h
    inc/dlpc350_usb.h
    inc/dlpc350_api.h
    inc/dlpc350_BMPParser.h
    inc/dlpc350_firmware.h
    inc/dlpc350_version.h
    inc/dlpc350_common.h
    inc/dlpc350_flashDevice.h
    inc/Helper.h
    inc/dlpc350_error.h
)

set(FORMS
    ui/mainwindow.ui
    ui/dialog.ui
)

set(RESOURCES
   Lcr2.qrc
)

add_executable(${PROJECT_NAME} 
    ${SOURCES}
    ${HEADERS}
    ${FORMS}
    ${RESOURCES}
)

target_link_libraries(${PROJECT_NAME} Qt6::Core Qt6::Gui Qt6::Widgets)
target_link_libraries(${PROJECT_NAME} hidapi::hidapi)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)
