if(NOT TARGET Cinder-WMFVideo)
    # Define ${Cinder-WMFVideo_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(Cinder-WMFVideo_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH  "${Cinder-WMFVideo_PROJECT_ROOT}/../.." ABSOLUTE)

    # Make a list of source files and define that to be ${SOURCE_LIST}.
    file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
            "${Cinder-WMFVideo_PROJECT_ROOT}/src/*.cpp"
            "${Cinder-WMFVideo_PROJECT_ROOT}/src/presenter/*.cpp"
            "${Cinder-WMFVideo_PROJECT_ROOT}/src/presenter/common/*.cpp"
            )

    # Create the library!
    add_library(Cinder-WMFVideo ${SOURCE_LIST})

    # Add include directories.
    # Notice that `cinderblock.xml` has `<includePath>src</includePath>`.
    # So you need to set `../../src/` to include.
    target_include_directories(Cinder-WMFVideo PUBLIC "${Cinder-WMFVideo_PROJECT_ROOT}/src" )
    target_include_directories(Cinder-WMFVideo SYSTEM BEFORE PUBLIC  "${CINDER_PATH}/include" )



    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(Cinder-WMFVideo PRIVATE cinder)

endif()