---
name: "skse-development-detail"
description: "SKSE native plugin development with CommonLib in C++\nKeywords: SKSE, CommonLib, CommonLibSSE, CommonLibVR, C++, DLL, native plugin, address library, hook, patch, reverse engineering, CMake, vcpkg"
---

# SKSE Native Plugin Development

## Project Setup

### Prerequisites
- Visual Studio 2022 (MSVC v143+)
- CMake 3.21+
- vcpkg (for dependency management)
- Git

### CommonLib Variants

| Library | Target | Repository |
|---------|--------|-----------|
| CommonLibSSE | SE 1.5.97 | [powerof3/CommonLibSSE](https://github.com/powerof3/CommonLibSSE) |
| CommonLibSSE-NG | SE + AE (multi-version) | [CharmedBaryon/CommonLibSSE-NG](https://github.com/CharmedBaryon/CommonLibSSE-NG) |
| CommonLibVR | VR 1.4.15 | [alandtse/CommonLibVR](https://github.com/alandtse/CommonLibVR) |

### Recommended Project Structure

```
MyPlugin/
├── CMakeLists.txt
├── vcpkg.json
├── cmake/
│   └── sourcelist.cmake
├── src/
│   ├── main.cpp
│   ├── Hooks.h / Hooks.cpp
│   ├── Events.h / Events.cpp
│   └── Settings.h / Settings.cpp
└── contrib/
    └── Distribution/
        ├── Data/
        │   └── SKSE/Plugins/
        │       ├── MyPlugin.dll
        │       └── MyPlugin.ini
        └── fomod/
```

## Minimal Plugin Template

```cpp
#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>

namespace {
    void InitializeLog() {
        auto path = logger::log_directory();
        if (!path) return;
        *path /= "MyPlugin.log"sv;
        auto sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(path->string(), true);
        auto log = std::make_shared<spdlog::logger>("global log"s, std::move(sink));
        log->set_level(spdlog::level::info);
        spdlog::set_default_logger(std::move(log));
    }

    void MessageHandler(SKSE::MessagingInterface::Message* a_msg) {
        switch (a_msg->type) {
            case SKSE::MessagingInterface::kDataLoaded:
                logger::info("Data loaded");
                break;
            case SKSE::MessagingInterface::kPostLoadGame:
                logger::info("Game loaded");
                break;
        }
    }
}

SKSEPluginLoad(const SKSE::LoadInterface* skse) {
    SKSE::Init(skse);
    InitializeLog();
    logger::info("MyPlugin loaded");

    auto messaging = SKSE::GetMessagingInterface();
    messaging->RegisterListener(MessageHandler);

    return true;
}
```

## Address Library Usage

### Concept
Address Library provides a mapping from stable **ID numbers** to actual memory addresses, allowing plugins to work across game updates without recompilation.

### Using REL::Relocation

```cpp
// By ID (recommended — portable across versions)
REL::Relocation<std::uintptr_t> target{ REL::ID(12345) };

// By offset (version-specific — avoid unless necessary)
REL::Relocation<std::uintptr_t> target{ REL::Offset(0x123456) };
```

### Cross-Version Support (SE + AE)
With CommonLibSSE-NG:
```cpp
// Provides both SE and AE IDs — resolved at runtime
REL::Relocation<std::uintptr_t> target{ RELOCATION_ID(SE_ID, AE_ID) };
```

### VR Address Resolution
VR uses a separate address library database. With CommonLibVR:
```cpp
// VR ID maps to VR-specific addresses
REL::Relocation<std::uintptr_t> target{ REL::ID(VR_ID) };
```

## Hooking Patterns

### Detour Hook (Replace Function)
```cpp
REL::Relocation<decltype(&MyHook)> _original;

void MyHook(RE::Actor* a_actor) {
    // Custom logic before
    logger::info("Actor: {}", a_actor->GetName());
    // Call original
    _original(a_actor);
}

void Install() {
    REL::Relocation<std::uintptr_t> vtbl{ RE::VTABLE_Actor[0] };
    _original = vtbl.write_vfunc(0x0AD, MyHook);
}
```

### Write Hook (Patch Bytes)
```cpp
void Install() {
    REL::Relocation<std::uintptr_t> target{ REL::ID(12345), 0x1A };
    REL::safe_fill(target.address(), REL::NOP, 0x5);  // NOP 5 bytes
}
```

## CMakeLists.txt Template

```cmake
cmake_minimum_required(VERSION 3.21)
project(MyPlugin VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(CommonLibSSE CONFIG REQUIRED)

add_commonlibsse_plugin(${PROJECT_NAME}
    SOURCES ${SOURCES}
)

target_include_directories(${PROJECT_NAME} PRIVATE src)
```

## Building for Multiple Editions

| Target | CMake Flag | CommonLib | Notes |
|--------|-----------|-----------|-------|
| SE only | Default | CommonLibSSE | Targets 1.5.97 |
| AE only | `-DENABLE_SKYRIM_AE=ON` | CommonLibSSE-NG | Targets 1.6.x |
| SE + AE | Use NG build | CommonLibSSE-NG | Uses RELOCATION_ID |
| VR | Separate build | CommonLibVR | Separate project or CMake option |

## Debugging Tips

1. Use `logger::info()` liberally during development
2. Attach Visual Studio debugger to SkyrimSE.exe / SkyrimVR.exe
3. Check `Documents/My Games/Skyrim Special Edition/SKSE/` for plugin logs
4. Use Crash Logger (SE/AE/VR) for crash analysis — it decodes stack traces
5. Test with a minimal load order first
