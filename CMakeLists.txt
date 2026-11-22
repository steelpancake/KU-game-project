cmake_minimum_required(VERSION 3.16)
project(pathfinder VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(pathfinder
    game/main.cpp
    game/MyGame.cpp
    game/gfc/Game.cpp
    game/gfc/GameApp.cpp
    game/gfc/Graphics.cpp
    game/gfc/SDL_collide.cpp
    game/gfc/Sound.cpp
    game/gfc/Sprite.cpp
    game/gfc/SpriteOval.cpp
    game/gfc/SpriteRect.cpp
    game/gfc/SpriteText.cpp
)

target_include_directories(pathfinder PRIVATE
    game
    game/gfc/include
    game/gfc/sdl/include
)

# Replace these with the paths to MinGW-compatible Windows SDL libraries.
target_link_directories(pathfinder PRIVATE
    "${CMAKE_SOURCE_DIR}/path/to/mingw-sdl/lib"
)

target_link_libraries(pathfinder PRIVATE
    SDL
    SDLmain
    SDL_gfx
    SDL_image
    SDL_mixer
    SDL_ttf
)

target_compile_options(pathfinder PRIVATE
-fpermissive)
