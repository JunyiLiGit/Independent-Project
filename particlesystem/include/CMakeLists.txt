#Set variable PARTICLESYS_INCLUDE which represent the whole header files
SET(PARTICLESYS_INCLUDE FILES_MATCHING PATTERN "*.h")

#create include folder inside install folder when you do "make install" inside build,
#copy all header file from include folder into install folder
INSTALL(FILES
  curve.h
  point.h
  particle.h
  particlePath.h
  tinyxml2.h
  DESTINATION include
  )
