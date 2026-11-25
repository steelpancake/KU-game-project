cmake_minimum_required(VERSION 3.16)
project(pathfinder VERSION 0.0.1 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


option(PATHFINDER_SHARED "Build third-party libraries as DLLs" ON)
if(PATHFINDER_SHARED)
  set(DEP_LIB_TYPE SHARED)
else()
  set(DEP_LIB_TYPE STATIC)
endif()



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
-fpermissive -Wl,--export-all-symbols -municode)


#
# Game
#

add_executable(pathfinder
    game/main.cpp
    game/MyGame.cpp
    game/winmain.cpp
)

target_include_directories(pathfinder PRIVATE
    game
    game/gfc/include
)

target_link_libraries(pathfinder PRIVATE
    SDLmain gfc
)

target_link_options(pathfinder PRIVATE -mwindows)

target_compile_options(pathfinder PRIVATE
-fpermissive -Wl,--export-all-symbols)

#
# SDL
#

set(SDL_DIR ${CMAKE_SOURCE_DIR}/SDL_mingw)

target_include_directories(gfc PUBLIC ${SDL_DIR}/include/SDL)
target_link_directories(gfc PUBLIC ${SDL_DIR}/lib)

add_custom_command(TARGET pathfinder POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${SDL_DIR}/bin/SDL.dll
            $<TARGET_FILE_DIR:pathfinder>)

#
# FreeType (built from source)
#

set(FT_DISABLE_ZLIB     ON)
set(FT_DISABLE_BZIP2    ON)
set(FT_DISABLE_PNG      ON)
set(FT_DISABLE_HARFBUZZ ON)
set(FT_DISABLE_BROTLI   ON)

set(BUILD_SHARED_LIBS ${PATHFINDER_SHARED})
add_subdirectory(freetype)

#
# SDL_ttf
#

set (SDLTTF_DIR ${CMAKE_SOURCE_DIR}/SDL_ttf)

add_library(sdl_ttf ${DEP_LIB_TYPE}
  ${SDLTTF_DIR}/SDL_ttf.c
)

target_include_directories(sdl_ttf PUBLIC
  ${SDLTTF_DIR}/
  ${SDL_DIR}/include/SDL
)

target_link_directories(sdl_ttf PRIVATE ${SDL_DIR}/lib)
target_link_libraries(sdl_ttf PUBLIC freetype PRIVATE SDL)

#
# SDL_gfx
#

set(SDLGFX_DIR ${CMAKE_SOURCE_DIR}/SDL_gfx)

add_library(sdl_gfx ${DEP_LIB_TYPE}
  ${SDLGFX_DIR}/SDL_framerate.c
  ${SDLGFX_DIR}/SDL_gfxBlitFunc.c
  ${SDLGFX_DIR}/SDL_gfxPrimitives.c
  ${SDLGFX_DIR}/SDL_imageFilter.c
  ${SDLGFX_DIR}/SDL_rotozoom.c
)

target_include_directories(sdl_gfx PUBLIC ${SDLGFX_DIR}
  ${SDL_DIR}/include/SDL
)
target_link_directories(sdl_gfx PRIVATE ${SDL_DIR}/lib)
target_link_libraries(sdl_gfx PRIVATE SDL)



#
# SDL_image
#

set(SDLIMAGE_DIR ${CMAKE_SOURCE_DIR}/SDL_image)

add_library(sdl_image ${DEP_LIB_TYPE}
  ${SDLIMAGE_DIR}/IMG.c
  ${SDLIMAGE_DIR}/IMG_png.c
  ${SDLIMAGE_DIR}/IMG_bmp.c
  ${SDLIMAGE_DIR}/IMG_gif.c
  ${SDLIMAGE_DIR}/IMG_jpg.c
  ${SDLIMAGE_DIR}/IMG_lbm.c
  ${SDLIMAGE_DIR}/IMG_pcx.c
  ${SDLIMAGE_DIR}/IMG_pnm.c
  ${SDLIMAGE_DIR}/IMG_tga.c
  ${SDLIMAGE_DIR}/IMG_tif.c
  ${SDLIMAGE_DIR}/IMG_webp.c
  ${SDLIMAGE_DIR}/IMG_xcf.c
  ${SDLIMAGE_DIR}/IMG_xpm.c
  ${SDLIMAGE_DIR}/IMG_xv.c
  ${SDLIMAGE_DIR}/IMG_xxx.c
)

target_include_directories(sdl_image PUBLIC ${SDLIMAGE_DIR}
  ${SDL_DIR}/include/SDL/
)

target_compile_definitions(sdl_image PRIVATE LOAD_PNG)
target_compile_options(sdl_image PRIVATE -Wno-incompatible-pointer-types)
target_link_directories(sdl_image PRIVATE /usr/x86_64-w64-mingw32/lib)
target_link_libraries(sdl_image PRIVATE png z SDL)
target_include_directories(sdl_image PRIVATE /usr/x86_64-w64-mingw32/include)

target_link_directories(sdl_image PRIVATE ${SDL_DIR}/lib)
target_link_libraries(sdl_image PRIVATE SDL)


#
# SDL_mixer 
#

set(SDLMIXER_DIR ${CMAKE_SOURCE_DIR}/SDL_mixer)

add_library(sdl_mixer ${DEP_LIB_TYPE}
  ${SDLMIXER_DIR}/dynamic_flac.c
  ${SDLMIXER_DIR}/dynamic_fluidsynth.c
  ${SDLMIXER_DIR}/dynamic_mod.c
  ${SDLMIXER_DIR}/dynamic_mp3.c
  ${SDLMIXER_DIR}/dynamic_ogg.c
  ${SDLMIXER_DIR}/effect_position.c
  ${SDLMIXER_DIR}/effects_internal.c
  ${SDLMIXER_DIR}/effect_stereoreverse.c
  ${SDLMIXER_DIR}/fluidsynth.c
  ${SDLMIXER_DIR}/load_aiff.c
  ${SDLMIXER_DIR}/load_flac.c
  ${SDLMIXER_DIR}/load_ogg.c
  ${SDLMIXER_DIR}/load_voc.c
  ${SDLMIXER_DIR}/mixer.c
  ${SDLMIXER_DIR}/music.c
  ${SDLMIXER_DIR}/music_cmd.c
  ${SDLMIXER_DIR}/music_flac.c
  ${SDLMIXER_DIR}/music_mad.c
  ${SDLMIXER_DIR}/music_mod.c
  ${SDLMIXER_DIR}/music_modplug.c
  ${SDLMIXER_DIR}/music_ogg.c
)

target_include_directories(sdl_mixer PUBLIC ${SDLMIXER_DIR}
  ${SDL_DIR}/include/SDL/
)

target_link_directories(sdl_mixer PRIVATE ${SDL_DIR}/lib)
target_link_libraries(sdl_mixer PRIVATE SDL)

set(MINGW_BIN /usr/x86_64-w64-mingw32/bin)

add_custom_command(TARGET pathfinder POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${MINGW_BIN}/libpng16-16.dll
    ${MINGW_BIN}/libssp-0.dll
    ${MINGW_BIN}/zlib1.dll
    $<TARGET_FILE_DIR:pathfinder>)

add_custom_command(TARGET pathfinder POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    $<TARGET_RUNTIME_DLLS:pathfinder>
    $<TARGET_FILE_DIR:pathfinder>
    COMMAND_EXPAND_LISTS)

set_target_properties(sdl_ttf sdl_gfx sdl_image PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)

target_link_libraries(gfc PUBLIC SDLmain sdl_ttf sdl_gfx sdl_image sdl_mixer SDL)
