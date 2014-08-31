SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
SET(CMAKE_CXX_FLAGS "-std=c++11")

#CMAKE_SOURCE_DIR means the project directory
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/include
  )

#Store a property of directory scope in the named variable
#get_directory_property(<variable> [DIRECTORY <dir>]
#                       DEFINITION <var-name>)
GET_DIRECTORY_PROPERTY(PARTICLESYS_SRC
    DIRECTORY ${CMAKE_SOURCE_DIR}/src
    DEFINITION PARTICLESYS_SRC)

#Add a library to the project using the specified source files.
ADD_LIBRARY(particlesys_shared SHARED ${PARTICLESYS_SRC})
ADD_LIBRARY(particlesys_static STATIC ${PARTICLESYS_SRC})

#Link a target to given libraries
TARGET_LINK_LIBRARIES(particlesys_static
  )

TARGET_LINK_LIBRARIES(particlesys_shared
  )

#create lib folder inside install folder when you do "make install" inside build,
#copy all lib file from /build/lib into install folder
INSTALL(TARGETS particlesys_static DESTINATION lib)
INSTALL(TARGETS particlesys_shared DESTINATION lib)
