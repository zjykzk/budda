add_executable(hello hello.c)

target_link_libraries(hello
	lwan-common
	dl
	${ADDITIONAL_LIBRARIES}
)

