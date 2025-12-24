
qt_add_library(UI OBJECT)
qt_add_resources(img
    ui/Lcr2.qrc
)
target_sources(UI
    PRIVATE
    src/mainwindow.cpp
    ui/mainwindow.ui
    ui/dialog.ui
    inc/Helper.h
    ${img}
    PUBLIC
    inc/mainwindow.h
)
target_include_directories(UI 
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}
)
set_target_properties( 
    UI PROPERTIES
    AUTOUIC_SEARCH_PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ui"
)
target_link_libraries(UI PRIVATE DLP_Driver)
target_link_libraries(UI PUBLIC Qt6::Core Qt6::Gui Qt6::Widgets hidapi::hidapi)
add_dependencies(UI DLP_Driver)