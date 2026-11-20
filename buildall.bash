#!/bin/bash

mkdir -p "_binaries"

# shape for being able to do a lot of Zig compiled actors easily;
# TODO: define as a function
ACTOR="unzip-actor"
(
  cd "./${ACTOR}"                                              &&
  zig build -Dtarget=x86_64-linux -Doptimize=ReleaseFast       &&
  mv "./zig-out/${ACTOR}" "../_binaries/${ACTOR}-x86_64-linux" &&
  zig build -Dtarget=x86_64-windows-gnu -Doptimize=ReleaseFast &&
  mv "./zig-out/${ACTOR}.exe" "../_binaries/${ACTOR}-x86_64-windows.exe"
)


# c++ for Windows API
ACTOR="windows-shortcut-actor"
(
  cd "./${ACTOR}"                                                            &&
  x86_64-w64-mingw32-g++ main.cpp -o "${ACTOR}.exe" -lole32 -luuid -lshell32 &&
  mv "${ACTOR}.exe" "../_binaries/${ACTOR}-x86_64-windows.exe"
)