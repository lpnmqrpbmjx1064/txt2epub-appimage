# txt2epub AppImage

**Portable [txt2epub](https://github.com/k4yt3x/txt2epub) converter** — packaged as a self-contained AppImage.  
No Python or system dependencies needed. Runs on any Linux distro, including immutable ones.

> **This is a packaging/build distribution only.**  
> All credit for the converter goes to **[@k4yt3x](https://github.com/k4yt3x)**.  
> Upstream: [github.com/k4yt3x/txt2epub](https://github.com/k4yt3x/txt2epub) — GPLv2

## LLM Disclosure

This packaging (build scripts, README, config) was produced with the assistance of **Hermes Agent** (Nous Research), an AI language model. The upstream source code is unmodified.

## Download

Grab the latest `.AppImage` from the [Releases page](https://github.com/lpnmqrpbmjx1064/txt2epub-appimage/releases).

## Usage

```bash
chmod +x txt2epub-x86_64.AppImage
./txt2epub-x86_64.AppImage          # GUI (default)
./txt2epub-x86_64.AppImage convert -i book.txt -o book.epub  # CLI
./txt2epub-x86_64.AppImage --appimage-extract-and-run  # no FUSE
```

## Build

```bash
git clone https://github.com/lpnmqrpbmjx1064/txt2epub-appimage.git
cd txt2epub-appimage
./build.sh
```

Requires: `python3`, `wget`, `squashfs-tools`, `libfuse2`.

## License

**GPLv2** — inherited from [txt2epub](https://github.com/k4yt3x/txt2epub). See [LICENSE](./LICENSE).
