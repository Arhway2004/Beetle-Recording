"""Writes every app-icon size into the Flutter project.

Usage (from apps/mobile):
  python3 tool/logo/install_icons.py            # from source/beetle_keeper_ai.png (current icon)
  python3 tool/logo/install_icons.py --drawn    # from the drawn DHH logo (draw_logo.py)
"""
import json
import os
import sys
import tempfile

from PIL import Image, ImageDraw

import draw_logo

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
IOS_SET = os.path.join(ROOT, "ios/Runner/Assets.xcassets/AppIcon.appiconset")
RES = os.path.join(ROOT, "android/app/src/main/res")

# Launcher icon (48dp) and adaptive-icon foreground (108dp) per density.
ANDROID = {"mdpi": 1, "hdpi": 1.5, "xhdpi": 2, "xxhdpi": 3, "xxxhdpi": 4}


def resized(src, px, path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    src.resize((px, px), Image.LANCZOS).save(path)


SOURCE = os.path.join(os.path.dirname(__file__), "source", "beetle_keeper_ai.png")
# Dark green of the source artwork's border, used to fill its black corners.
EDGE = (27, 53, 18)


def from_source(path):
    """Returns (full-bleed square, rounded with transparent corners, adaptive foreground).

    The artwork is a rounded square on black; iOS and Android apply their own
    masks, so the black corners are filled with the border green for the
    full-bleed icon and made transparent for the in-app logo.
    """
    src = Image.open(path).convert("RGB")
    n = src.size[0]
    square = src.copy()
    for xy in [(0, 0), (n - 1, 0), (0, n - 1), (n - 1, n - 1)]:
        ImageDraw.floodfill(square, xy, EDGE, thresh=40)
    # The pixels the flood fill changed are the corners: transparent in the logo.
    mask = Image.new("L", src.size, 255)
    a, b = src.load(), square.load()
    m = mask.load()
    for y in range(n):
        for x in range(n):
            if a[x, y] != b[x, y]:
                m[x, y] = 0
    rounded = src.convert("RGBA")
    rounded.putalpha(mask)
    # Adaptive icons show the central 72dp of a 108dp canvas: fit the whole
    # design inside it so the title text is never cropped.
    fg = Image.new("RGBA", (1080, 1080), (0, 0, 0, 0))
    inner = rounded.resize((720, 720), Image.LANCZOS)
    fg.paste(inner, (180, 180), inner)
    return square, rounded, fg


def main():
    if "--drawn" not in sys.argv:
        ios, full, fg = from_source(SOURCE)
        legacy = ios
        _write(ios, legacy, fg, full)
        return
    with tempfile.TemporaryDirectory() as tmp:
        draw_logo.main(tmp)
        ios = Image.open(os.path.join(tmp, "icon_ios.png")).convert("RGB")
        legacy = Image.open(os.path.join(tmp, "icon_legacy.png")).convert("RGB")
        fg = Image.open(os.path.join(tmp, "icon_fg.png")).convert("RGBA")
        full = Image.open(os.path.join(tmp, "logo_full.png")).convert("RGBA")
    _write(ios, legacy, fg, full)


def _write(ios, legacy, fg, full):
    with open(os.path.join(IOS_SET, "Contents.json")) as f:
        for img in json.load(f)["images"]:
            pt = float(img["size"].split("x")[0])
            px = round(pt * int(img["scale"][0]))
            resized(ios, px, os.path.join(IOS_SET, img["filename"]))

    for density, k in ANDROID.items():
        resized(legacy, round(48 * k), os.path.join(RES, f"mipmap-{density}", "ic_launcher.png"))
        resized(fg, round(108 * k), os.path.join(RES, f"mipmap-{density}", "ic_launcher_foreground.png"))

    resized(full, 512, os.path.join(ROOT, "assets/brand/logo.png"))


if __name__ == "__main__":
    main()
