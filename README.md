# Hedera C++ Protobuf API SDK

## SDK IS NOT READY FOR PRODUCTION USE. IT IS CURRENTLY STILL UNDER DEVELOPEMENT.

### Building the Protobuf API SDK

This project features CMake Presets which simplify the setup of `vcpkg` based dependencies. The below commands are typically all that is required.

```shell
# Ensure the VCPkg Submodule is initialized
git submodule update --init

# Windows (x64) Build
cmake --preset windows-x64-release
cmake --build --preset windows-x64-release

# Linux (x64) Build
cmake --preset linux-x64-release
cmake --build --preset linux-x64-release

# MacOS (Intel x64) Build
cmake --preset macos-x64-release
cmake --build --preset macos-x64-release

# MacOS (Aarch64) Build
cmake --preset macos-arm64-release
cmake --build --preset macos-arm64-release
```
