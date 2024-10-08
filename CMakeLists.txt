cmake_minimum_required(VERSION 3.21...3.24)
project(hedera-protobufs-cpp VERSION 0.54.0 DESCRIPTION "Hedera C++ Protobuf Library" LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/${CMAKE_SYSTEM_NAME}/${CMAKE_SYSTEM_PROCESSOR})

include(FetchContent)
set(Protobuf_USE_STATIC_LIBS ON)

set(gRPC_SSL_PROVIDER package)

find_package(OpenSSL REQUIRED)
find_package(ZLIB REQUIRED)
find_package(Protobuf REQUIRED)
find_package(gRPC CONFIG REQUIRED)
find_package(re2 CONFIG REQUIRED)
find_package(c-ares CONFIG REQUIRED)
find_package(absl CONFIG REQUIRED)

set(HAPI_VERSION_TAG "v0.54.0" CACHE STRING "Use the configured version tag for the Hedera API protobufs")

if (HAPI_VERSION_TAG STREQUAL "")
    set(HAPI_VERSION_TAG "v0.54.0")
endif ()

# Fetch the protobuf definitions
FetchContent_Declare(
        HProto
        GIT_REPOSITORY https://github.com/hashgraph/hedera-protobufs.git
        GIT_TAG ${HAPI_VERSION_TAG}
)
set(FETCHCONTENT_QUIET OFF)
FetchContent_MakeAvailable(HProto)

# Clean and update the protobuf definitions
set(PROTO_SRC ${PROJECT_SOURCE_DIR}/src/proto)
file(GLOB_RECURSE PROTO_FILES ${PROTO_SRC}/*.proto)
if (PROTO_FILES)
    file(REMOVE ${PROTO_FILES})
endif ()

file(INSTALL ${hproto_SOURCE_DIR}/mirror/ DESTINATION ${PROTO_SRC}/mirror)
file(INSTALL ${hproto_SOURCE_DIR}/services/ DESTINATION ${PROTO_SRC})
file(INSTALL ${hproto_SOURCE_DIR}/sdk/ DESTINATION ${PROTO_SRC})

add_subdirectory(src)