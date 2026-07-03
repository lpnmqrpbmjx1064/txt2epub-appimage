#!/usr/bin/env bash
set -euo pipefail

PYTHON_VERSION="3.12.9"
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
OUTPUT="$SCRIPT_DIR/txt2epub-x86_64.AppImage"

echo "==> Setting up build directory"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "==> Downloading python-build-standalone ${PYTHON_VERSION}"
cd "$BUILD_DIR"
wget -q "https://github.com/niess/python-build-standalone/releases/download/${PYTHON_VERSION}/python-${PYTHON_VERSION}-x86_64-unknown-linux-gnu-pgo+lto-full.tar.gz"
tar -xzf "python-${PYTHON_VERSION}-x86_64-unknown-linux-gnu-pgo+lto-full.tar.gz"
rm "python-${PYTHON_VERSION}-x86_64-unknown-linux-gnu-pgo+lto-full.tar.gz"

echo "==> Installing dependencies"
./bin/python3 -m pip install pip --upgrade -q
./bin/python3 -m pip install --target=./lib/python3.12/site-packages \
    txt2epub ebooklib lxml PyQt6 -q

echo "==> Verifying all deps are bundled"
./bin/python3 -c "
import lxml.etree
import ebooklib
import PyQt6
print('All deps verified OK')
"

echo "==> Fixing pip-generated scripts (build-time paths)"
for script in ./bin/txt2epub; do
    [ -f "$script" ] || continue
    cat > "$script" << 'SCRIPT'
#!/bin/sh
APPDIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
export PYTHONHOME="${APPDIR}"
export PYTHONNOUSERSITE=1
exec "${APPDIR}/bin/python3" -m txt2epub "$@"
SCRIPT
done

echo "==> Building AppImage structure"
cd "$SCRIPT_DIR"
mkdir -p AppDir
cp -r build/* AppDir/usr/

# AppRun
cat > AppDir/AppRun << 'EOF'
#!/bin/bash
APPDIR="$(dirname "$(readlink -f "$0")")"
export PYTHONHOME="${APPDIR}/usr"
export PYTHONNOUSERSITE=1
export PATH="${APPDIR}/usr/bin:${PATH}"
exec "${APPDIR}/usr/bin/python3" -m txt2epub "$@"
EOF
chmod +x AppDir/AppRun

# Desktop file
cat > AppDir/txt2epub.desktop << 'EOF'
[Desktop Entry]
Name=txt2epub
Comment=Convert TXT books to EPUB
Exec=txt2epub
Icon=txt2epub
Terminal=false
Type=Application
Categories=Office;TextTools;
StartupNotify=true
MimeType=text/plain;
EOF

echo "==> Downloading appimagetool"
wget -q "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage" -O appimagetool
chmod +x appimagetool
./appimagetool --appimage-extract > /dev/null 2>&1
./squashfs-root/AppRun AppDir/ "$OUTPUT"

echo "==> Done!"
ls -lh "$OUTPUT"
