#!/bin/sh
# :D
rm -rf 32 64
mkdir -p 32 64
cd src
rm *.o *.dll
make -f Makefile.mingw CROSS=x86_64-w64-mingw32
mv SDL.dll ../32/
rm *.o *.dll
make -f Makefile.mingw CROSS=i686-w64-mingw32
mv SDL.dll ../64/
cd ..
zip -r release.zip 32 64 LICENSE.txt REMINDER_THIS_IS_A_PATCHED_VERSION_HERE_ARE_INSTRUCTIONS.txt shaders
