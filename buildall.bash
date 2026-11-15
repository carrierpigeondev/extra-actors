#!/bin/bash

mkdir -p "_binaries"

ACTOR="unzip-actor"
(
  cd "./${ACTOR}"                                              &&
  zig build -Dtarget=x86_64-linux -Doptimize=ReleaseFast       &&
  mv "./zig-out/${ACTOR}" "../_binaries/${ACTOR}-x86_64-linux" &&
  zig build -Dtarget=x86_64-windows-gnu -Doptimize=ReleaseFast &&
  mv "./zig-out/${ACTOR}.exe" "../_binaries/${ACTOR}-x86_64-windows.exe"
)