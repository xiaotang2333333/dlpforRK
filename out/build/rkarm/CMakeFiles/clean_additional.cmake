# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/LightCrafter4500_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/LightCrafter4500_autogen.dir/ParseCache.txt"
  "LightCrafter4500_autogen"
  )
endif()
