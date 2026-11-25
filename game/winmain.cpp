#include <iostream>
#include <windows.h>

extern "C" int SDL_main(int argc, char *argv[]);

int WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int) {
  std::cout << "nice\n\n";
  return SDL_main(__argc, __argv);
}
