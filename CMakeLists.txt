cmake_minimum_required(VERSION 3.16)
project(pathfinder VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)




#
#  GFC
#

add_library(gfc STATIC
    game/gfc/Game.cpp
    game/gfc/GameApp.cpp
    game/gfc/Graphics.cpp
    game/gfc/SDL_collide.cpp
    game/gfc/Sound.cpp
    game/gfc/Sprite.cpp
    game/gfc/SpriteOval.cpp
    game/gfc/SpriteRect.cpp
    game/gfc/SpriteText.cpp
    game/gfc/pch.cpp
)

target_include_directories(gfc PUBLIC
    game/gfc/include
    game/gfc
    game/gfc/sdl/include
)

target_compile_options(gfc PRIVATE
-fpermissive -Wl,--export-all-symbols)

target_link_libraries(gfc PUBLIC SDL)


#
# Game
#

add_executable(pathfinder
    game/main.cpp
    game/MyGame.cpp
)

target_include_directories(pathfinder PRIVATE
    game
    game/gfc/include
)

# Replace these with the paths to MinGW-compatible Windows SDL libraries.
target_link_directories(pathfinder PRIVATE
    "${CMAKE_SOURCE_DIR}/path/to/mingw-sdl/lib"
)

target_link_libraries(pathfinder PRIVATE
    gfc
)

target_compile_options(pathfinder PRIVATE
-fpermissive -Wl,--export-all-symbols)

#
# SDL
#

set(SDL_DIR ${CMAKE_SOURCE_DIR}/game/gfc/sdl)

target_include_directories(gfc PUBLIC ${SDL_DIR}/include)
target_link_directories(gfc PUBLIC ${SDL_DIR}/_x64)
target_link_libraries(gfc PUBLIC mingw32 SDLmain SDL)

add_custom_command(TARGET pathfinder POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
            ${SDL_DIR}/_x64/SDL.dll
            $<TARGET_FILE_DIR:pathfinder>)
