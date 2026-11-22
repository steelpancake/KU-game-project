alias cr:= config-release
alias cd:= config-debug
alias br:= build-release
alias bd:= build-debug

config-release:
  cmake -B Release -DCMAKE_TOOLCHAIN_FILE=cmake/mingw64.cmake -DCMAKE_BUILD_TYPE=Release

config-debug:
  cmake -B Debug -DCMAKE_TOOLCHAIN_FILE=cmake/mingw64.cmake -DCMAKE_BUILD_TYPE=Debug

build-release:
  cmake --build Release

build-debug:
  cmake --build Debug
