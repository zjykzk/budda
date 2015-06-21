set(SOURCES
    net.c
    async.c
    dict.c
    hiredis.c
    sds.c
)

include_directories(${CMAKE_BINARY_DIR})
add_library(hiredis STATIC ${SOURCES})

set(ADDITIONAL_LIBRARIES ${ADDITIONAL_LIBRARIES} PARENT_SCOPE)

INSTALL(TARGETS hiredis
  DESTINATION "lib"
)

INSTALL(FILES hiredis.h
  DESTINATION "include/hiredis"
)
