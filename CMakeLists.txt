cmake_minimum_required(VERSION 3.21...3.24)
project(hedera-protobufs-cpp VERSION 0.1.0 DESCRIPTION "Hedera C++ Protobuf Library" LANGUAGES CXX)

set (CMAKE_CXX_STANDARD 20)
set (CMAKE_CXX_STANDARD_REQUIRED 14)

set(CMAKE_INSTALL_PREFIX  ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/${CMAKE_HOST_SYSTEM_NAME}/${CMAKE_HOST_SYSTEM_PROCESSOR})

include(FetchContent)

set(Protobuf_USE_STATIC_LIBS ON)

find_package(ZLIB REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(Protobuf REQUIRED)
find_package(gRPC REQUIRED)

set(HAPI_VERSION_TAG "v0.30.0" CACHE STRING "Use the configured version tag for the Hedera API protobufs")

if(HAPI_VERSION_TAG STREQUAL "")
    set(HAPI_VERSION_TAG "v0.30.0")
endif()

# Fetch the protobuf definitions
FetchContent_Declare(
        HProto
        GIT_REPOSITORY  https://github.com/hashgraph/hedera-protobufs.git
        GIT_TAG         ${HAPI_VERSION_TAG}
)
set(FETCHCONTENT_QUIET OFF)
FetchContent_MakeAvailable(HProto)

# Clean and update the protobuf definitions
set(PROTO_SRC ${PROJECT_SOURCE_DIR}/src/proto)
file(GLOB_RECURSE PROTO_FILES ${PROTO_SRC}/*.proto)
if(PROTO_FILES)
    file(REMOVE ${PROTO_FILES})
endif()
file(INSTALL ${hproto_SOURCE_DIR}/services/ DESTINATION ${PROTO_SRC})

add_subdirectory(src)