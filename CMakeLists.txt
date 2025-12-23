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

qt_add_resources(RESOURCES
   ui/Lcr2.qrc
)

qt_add_executable(dlp
    ${SOURCES}
    ${HEADERS}
    ${FORMS}
    ${RESOURCES}
)

target_link_libraries(dlp PRIVATE Qt6::Core Qt6::Gui Qt6::Widgets)
target_link_libraries(dlp PRIVATE hidapi::hidapi)
set_target_properties(dlp PROPERTIES
    INSTALL_RPATH "\$ORIGIN/../lib"
)
target_include_directories(dlp PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)
set(QT_CONF_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/Qt6")
#file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/qt.conf" CONTENT "[Paths]\nPlugins=${QT_CONF_DIR}/plugins")
include(GNUInstallDirs)
include(CPack)
install(TARGETS dlp
    DESTINATION bin
    RUNTIME_DEPENDENCY_SET dep
)
install(DIRECTORY
    "${QT_CONF_DIR}"
    DESTINATION .
)
install(
    RUNTIME_DEPENDENCY_SET dep
    DESTINATION lib
    DIRECTORIES
    "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}"
    PRE_EXCLUDE_REGEXES 
    "libgcc." 
    "libgomp."
    POST_EXCLUDE_REGEXES
    "^/lib" 
    "^/usr/lib"
    "^/usr/local/lib"
)
# Create qt.conf to set plugin path
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/qt.conf" "[Paths]\nPlugins=../Qt6/plugins\nFont=/usr/share/fonts")
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/qt.conf" DESTINATION bin)
file(GLOB XCB_DEP "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/libQt6XcbQpa.so*")
install( 
    FILES
        ${XCB_DEP}
        DESTINATION lib
)
set(CPACK_GENERATOR "TGZ")