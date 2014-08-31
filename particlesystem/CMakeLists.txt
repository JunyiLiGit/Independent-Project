
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

#project name
PROJECT(PARTICLESYSTEM)

#If “make install” is invoked or INSTALL is built, this directory is prepended
#onto all install directories. This variable defaults to /usr/local on UNIX
SET(CMAKE_INSTALL_PREFIX ../install)

#Add a subdirectory to the build
ADD_SUBDIRECTORY(include)
ADD_SUBDIRECTORY(src)
ADD_SUBDIRECTORY(lib)
ADD_SUBDIRECTORY(docs)

#List of directories to search for CMake modules
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
