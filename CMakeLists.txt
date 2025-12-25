cmake_minimum_required(VERSION 3.16)
project(LightCrafter4500 VERSION 1.0.0 LANGUAGES CXX)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)
find_package(hidapi REQUIRED)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
qt_standard_project_setup()
add_subdirectory(qtui)
add_subdirectory(dlp)
qt_add_executable(LightCrafter main.cpp)
target_link_libraries(LightCrafter PRIVATE DLP_Driver UI)

set_target_properties(LightCrafter PROPERTIES
    INSTALL_RPATH "\$ORIGIN/../lib"
    AUTORCC OFF
    AUTOMOC OFF
    AUTOUIC OFF
)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/FlashDeviceParameters.txt DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
set(QT_CONF_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/Qt6")
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/qt.conf" CONTENT "[Paths]\nPlugins=${QT_CONF_DIR}/plugins")
include(GNUInstallDirs)
include(CPack)
install(TARGETS LightCrafter
    DESTINATION bin
    RUNTIME_DEPENDENCY_SET dep
)
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/FlashDeviceParameters.txt"
    DESTINATION bin
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
install( 
    FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/qt.conf
    DESTINATION bin
)
file(GLOB XCB_DEP "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/libQt6XcbQpa.so*")
install( 
    FILES
        ${XCB_DEP}
        DESTINATION lib
)
set(CPACK_GENERATOR "TGZ")