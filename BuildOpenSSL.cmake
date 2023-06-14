include(ExternalProject)
set(OPENSSL_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/_deps/openssl-src) # default path by CMake
set(OPENSSL_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/openssl)
set(OPENSSL_INCLUDE_DIR ${OPENSSL_INSTALL_DIR}/include)
set(OPENSSL_CONFIGURE_COMMAND ${OPENSSL_SOURCE_DIR}/Configure no-shared)

if (WIN32)
    set(OPENSSL_CONFIGURE_COMMAND perl ${OPENSSL_CONFIGURE_COMMAND})
    set(OPENSSL_BUILD_COMMAND nmake /S)
    set(OPENSSL_INSTALL_COMMAND nmake install_sw /S)
    set(OPENSSL_LIBRARY_EXTENSION .lib)
else ()
    set(OPENSSL_BUILD_COMMAND make)
    set(OPENSSL_INSTALL_COMMAND make install_sw)
    set(OPENSSL_LIBRARY_EXTENSION .a)
endif ()

if (LINUX)
    set(OPENSSL_BYPRODUCT_DIR ${OPENSSL_INSTALL_DIR}/lib64)
else ()
    set(OPENSSL_BYPRODUCT_DIR ${OPENSSL_INSTALL_DIR}/lib)
endif ()

ExternalProject_Add(OpenSSL
        SOURCE_DIR ${OPENSSL_SOURCE_DIR}
        GIT_REPOSITORY https://github.com/openssl/openssl.git
        GIT_TAG master
        GIT_SHALLOW TRUE
        USES_TERMINAL_DOWNLOAD TRUE
        CONFIGURE_COMMAND ${OPENSSL_CONFIGURE_COMMAND} --prefix=${OPENSSL_INSTALL_DIR} --openssldir=${OPENSSL_INSTALL_DIR}
        BUILD_COMMAND ${OPENSSL_BUILD_COMMAND}
        TEST_COMMAND ""
        INSTALL_COMMAND ${OPENSSL_INSTALL_COMMAND}
        INSTALL_DIR ${OPENSSL_INSTALL_DIR}
        BUILD_BYPRODUCTS ${OPENSSL_BYPRODUCT_DIR}/libcrypto${OPENSSL_LIBRARY_EXTENSION} ${OPENSSL_BYPRODUCT_DIR}/libssl${OPENSSL_LIBRARY_EXTENSION}
        UPDATE_COMMAND ""
        )

# We cannot use find_library because ExternalProject_Add() is performed at build time.
# And to please the property INTERFACE_INCLUDE_DIRECTORIES, we make the include directory in advance.
file(MAKE_DIRECTORY ${OPENSSL_INCLUDE_DIR})

add_library(OpenSSL::Crypto STATIC IMPORTED GLOBAL)
set_property(TARGET OpenSSL::Crypto PROPERTY IMPORTED_LOCATION ${OPENSSL_BYPRODUCT_DIR}/libcrypto${OPENSSL_LIBRARY_EXTENSION})
set_property(TARGET OpenSSL::Crypto PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${OPENSSL_INCLUDE_DIR})
add_dependencies(OpenSSL::Crypto OpenSSL)

add_library(OpenSSL::SSL STATIC IMPORTED GLOBAL)
set_property(TARGET OpenSSL::SSL PROPERTY IMPORTED_LOCATION ${OPENSSL_BYPRODUCT_DIR}/libssl${OPENSSL_LIBRARY_EXTENSION})
set_property(TARGET OpenSSL::SSL PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${OPENSSL_INCLUDE_DIR})
add_dependencies(OpenSSL::SSL OpenSSL)