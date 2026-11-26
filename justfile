alias crl:= config-release-linux
alias crw:= config-release-win
alias cdl:= config-debug-linux
alias cdw:= config-debug-win
alias brl:= build-release-linux
alias brw:= build-release-win
alias bdl:= build-debug-linux
alias bdw:= build-debug-win

config-release-linux:
  cmake -B release-linux -DCMAKE_BUILD_TYPE=Release

config-release-win:
  cmake -B release-win -DCMAKE_TOOLCHAIN_FILE=cmake/mingw64.cmake -DCMAKE_BUILD_TYPE=Release

config-debug-linux:
  cmake -B debug-linux -DCMAKE_BUILD_TYPE=Debug

config-debug-win:
  cmake -B debug-win -DCMAKE_TOOLCHAIN_FILE=cmake/mingw64.cmake -DCMAKE_BUILD_TYPE=Debug

build-release-linux:
  cmake --build release-linux

build-release-win:
  cmake --build release-win

build-debug-linux:
  cmake --build debug-linux

build-debug-win:
  cmake --build debug-win
