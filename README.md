# txt2epub AppImage

Portable [txt2epub](https://github.com/k4yt3x/txt2epub) converter packaged as a self-contained AppImage — no Python or system dependencies needed. Runs on any Linux distro, including immutable ones like **Bazzite**, Fedora Silverblue, SteamOS.

## Download

Grab the latest `.AppImage` from the [Releases page](https://github.com/lpnmqrpbmjx1064/txt2epub-appimage/releases).

## Usage

```bash
# Make executable
chmod +x txt2epub-x86_64.AppImage

# Launch GUI (default — no args needed)
./txt2epub-x86_64.AppImage

# Or use CLI
./txt2epub-x86_64.AppImage convert -i book.txt -o book.epub

# Without FUSE (Bazzite, containers)
./txt2epub-x86_64.AppImage --appimage-extract-and-run
```

## GUI by Default

Running the AppImage with no arguments launches the PyQt6 GUI. The `convert` subcommand is still available for CLI usage.

## Build from Source

```bash
git clone https://github.com/lpnmqrpbmjx1064/txt2epub-appimage.git
cd txt2epub-appimage
./build.sh
```

Requires: `python3`, `wget`, `squashfs-tools`, `libfuse2`.

The build script:
1. Downloads `python-build-standalone` (full stdlib, not a venv)
2. Installs txt2epub + dependencies
3. Verifies all packages are actually bundled
4. Fixes pip-generated shebangs
5. Builds the AppImage with official `appimagetool`

## Technical Notes

- Uses **python-build-standalone** (not a venv) — venvs don't bundle Python's stdlib
- `PYTHONNOUSERSITE=1` prevents host system package bleed
- All dependencies are tested by importing them during build
- Built with official AppImageKit `appimagetool`, not manual runtime concatenation

## License

GPLv3 — same as [txt2epub](https://github.com/k4yt3x/txt2epub).
