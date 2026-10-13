"""Renders the logo and writes every app-icon size into the Flutter project.

Usage (from apps/mobile): python3 tool/logo/install_icons.py
"""
import json
import os
import tempfile

from PIL import Image

import draw_logo

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
IOS_SET = os.path.join(ROOT, "ios/Runner/Assets.xcassets/AppIcon.appiconset")
RES = os.path.join(ROOT, "android/app/src/main/res")

# Launcher icon (48dp) and adaptive-icon foreground (108dp) per density.
ANDROID = {"mdpi": 1, "hdpi": 1.5, "xhdpi": 2, "xxhdpi": 3, "xxxhdpi": 4}


def resized(src, px, path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    src.resize((px, px), Image.LANCZOS).save(path)


def main():
    with tempfile.TemporaryDirectory() as tmp:
        draw_logo.main(tmp)
        ios = Image.open(os.path.join(tmp, "icon_ios.png")).convert("RGB")
        legacy = Image.open(os.path.join(tmp, "icon_legacy.png")).convert("RGB")
        fg = Image.open(os.path.join(tmp, "icon_fg.png")).convert("RGBA")
        full = Image.open(os.path.join(tmp, "logo_full.png")).convert("RGBA")

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
