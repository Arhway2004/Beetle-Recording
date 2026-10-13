"""Draws the Beetle Keeper logo (a Dynastes hercules hercules in profile).

Usage: python3 tool/logo/draw_logo.py <out_dir>

Writes:
  logo_full.png        1024x1024, rounded-square background (in-app use)
  icon_ios.png         1024x1024, full-bleed square, no alpha (iOS masks it)
  icon_fg.png          1024x1024, transparent, beetle only, sized for the
                       Android adaptive-icon safe zone
  icon_legacy.png      1024x1024, full-bleed square (Android legacy icon)
"""
import math
import sys

from PIL import Image, ImageDraw, ImageFilter

S = 4  # supersampling factor
N = 1024 * S

BG_TOP = (196, 214, 170)
BG_BOTTOM = (122, 156, 98)
ELYTRA = (226, 202, 122)  # DHH's olive-gold wing cases
SPOT = (72, 60, 34)
BLACK = (26, 28, 22)  # head, pronotum and horns
GLOSS = (92, 98, 80)
LEG = (40, 42, 34)


def p(x, y):
    return (x * S, y * S)


def bezier(pts, t):
    n = len(pts) - 1
    x = y = 0.0
    for i, (px, py) in enumerate(pts):
        b = math.comb(n, i) * (1 - t) ** (n - i) * t**i
        x += b * px
        y += b * py
    return x, y


def tapered(draw, pts, w0, w1, fill, steps=80):
    """Fills a curve whose width tapers linearly from w0 to w1."""
    left, right = [], []
    for i in range(steps + 1):
        t = i / steps
        x, y = bezier(pts, t)
        x2, y2 = bezier(pts, min(1.0, t + 1e-3)) if t < 1 else bezier(pts, t)
        x1, y1 = bezier(pts, max(0.0, t - 1e-3))
        dx, dy = x2 - x1, y2 - y1
        d = math.hypot(dx, dy) or 1.0
        nx, ny = -dy / d, dx / d
        w = (w0 + (w1 - w0) * t) / 2
        left.append(p(x + nx * w, y + ny * w))
        right.append(p(x - nx * w, y - ny * w))
    draw.polygon(left + right[::-1], fill=fill)
    r = w0 / 2 * S
    sx, sy = p(*pts[0])
    draw.ellipse((sx - r, sy - r, sx + r, sy + r), fill=fill)


def ellipse(draw, cx, cy, rx, ry, rot_deg, fill):
    a = math.radians(rot_deg)
    pts = []
    for i in range(180):
        t = 2 * math.pi * i / 180
        x, y = rx * math.cos(t), ry * math.sin(t)
        pts.append(p(cx + x * math.cos(a) - y * math.sin(a), cy + x * math.sin(a) + y * math.cos(a)))
    draw.polygon(pts, fill=fill)


def leg(draw, pts, w, fill):
    for a, b in zip(pts, pts[1:]):
        tapered(draw, [a, b], w, w * 0.8, fill, steps=4)
        r = w / 2 * 0.9 * S
        x, y = p(*b)
        draw.ellipse((x - r, y - r, x + r, y + r), fill=fill)


def beetle_layer():
    """Beetle drawn on a transparent 1024 canvas, centred around (512, 512)."""
    img = Image.new("RGBA", (N, N), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    # Legs (behind the body).
    leg(d, [(330, 660), (260, 750), (180, 800)], 30, LEG)
    leg(d, [(440, 680), (440, 785), (380, 850)], 30, LEG)
    leg(d, [(560, 620), (630, 730), (640, 825)], 30, LEG)

    # Elytra with the characteristic dark spots.
    ellipse(d, 360, 575, 215, 150, -6, ELYTRA)
    for cx, cy, rx, ry in [(250, 560, 22, 16), (330, 620, 26, 18), (300, 500, 16, 12),
                           (420, 560, 20, 15), (450, 640, 15, 11), (200, 630, 14, 10),
                           (380, 470, 13, 10), (500, 500, 12, 9)]:
        ellipse(d, cx, cy, rx, ry, -6, SPOT)

    # Pronotum and head.
    ellipse(d, 585, 492, 118, 104, -15, BLACK)
    ellipse(d, 700, 560, 54, 44, 18, BLACK)

    # Head horn: curves up from the head, with a tooth on its upper edge.
    tapered(d, [(715, 572), (820, 575), (880, 520), (888, 462)], 46, 12, BLACK)
    tapered(d, [(800, 560), (812, 535)], 18, 6, BLACK, steps=6)
    # Thoracic horn: the long one, arching forward over the head horn.
    tapered(d, [(560, 405), (720, 265), (930, 270), (990, 390)], 74, 14, BLACK)
    # Gloss highlights.
    tapered(d, [(610, 372), (730, 290), (870, 285), (940, 325)], 10, 4, GLOSS)
    tapered(d, [(540, 430), (575, 415), (615, 418)], 9, 5, GLOSS)

    # Gaps that separate the body parts, punched out of the silhouette.
    cut = Image.new("L", (N, N), 0)
    c = ImageDraw.Draw(cut)
    tapered(c, [(480, 405), (470, 490), (490, 575), (535, 650)], 16, 16, 255)
    # Elytra seam.
    tapered(c, [(160, 585), (260, 540), (370, 520), (460, 525)], 9, 6, 255)
    alpha = img.getchannel("A")
    alpha.paste(0, mask=cut)
    img.putalpha(alpha)
    return img


def place(layer, scale, dx=0, dy=0):
    """Scales the beetle layer about its centre and shifts it."""
    w = int(N * scale)
    small = layer.resize((w, w), Image.LANCZOS)
    out = Image.new("RGBA", (N, N), (0, 0, 0, 0))
    out.paste(small, ((N - w) // 2 + dx * S, (N - w) // 2 + dy * S), small)
    return out


def background(rounded):
    grad = Image.new("RGBA", (N, N))
    gd = ImageDraw.Draw(grad)
    for y in range(N):
        t = y / (N - 1)
        col = tuple(int(BG_TOP[i] + (BG_BOTTOM[i] - BG_TOP[i]) * t) for i in range(3)) + (255,)
        gd.line([(0, y), (N, y)], fill=col)
    if not rounded:
        return grad
    mask = Image.new("L", (N, N), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, N - 1, N - 1), radius=int(N * 0.225), fill=255)
    out = Image.new("RGBA", (N, N), (0, 0, 0, 0))
    out.paste(grad, (0, 0), mask)
    return out


def shadow(layer):
    a = layer.getchannel("A").filter(ImageFilter.GaussianBlur(10 * S))
    sh = Image.new("RGBA", (N, N), (20, 30, 15, 0))
    sh.putalpha(a.point(lambda v: v * 0.35))
    out = Image.new("RGBA", (N, N), (0, 0, 0, 0))
    out.paste(sh, (0, 8 * S), sh)
    return out


def compose(bg, fg):
    img = bg.copy()
    img.alpha_composite(shadow(fg))
    img.alpha_composite(fg)
    return img


def save(img, path, keep_alpha=True):
    img = img.resize((1024, 1024), Image.LANCZOS)
    if not keep_alpha:
        img = img.convert("RGB")
    img.save(path)


def main(out_dir):
    beetle = beetle_layer()
    icon_fg = place(beetle, 0.84, dx=-15, dy=-25)
    save(compose(background(rounded=True), icon_fg), f"{out_dir}/logo_full.png")
    save(compose(background(rounded=False), icon_fg), f"{out_dir}/icon_ios.png", keep_alpha=False)
    save(compose(background(rounded=False), icon_fg), f"{out_dir}/icon_legacy.png", keep_alpha=False)
    # Adaptive icons crop to a circle of ~66% of the canvas: keep the beetle inside it.
    save(place(beetle, 0.62, dx=-22, dy=-14), f"{out_dir}/icon_fg.png")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else ".")
