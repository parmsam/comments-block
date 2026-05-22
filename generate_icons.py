#!/usr/bin/env python3
"""Generates Comments Block extension icons at required sizes."""
import math
from PIL import Image, ImageDraw

SIZES = [16, 32, 48, 128]
OUT = "Comments Block/Shared (App)/Resources"

def draw_icon(size):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    p = size / 128  # scale factor relative to 128px canvas

    # Background circle
    pad = 4 * p
    d.ellipse([pad, pad, size - pad, size - pad], fill=(50, 50, 50, 255))

    # Speech bubble body
    bx1, by1 = 28 * p, 22 * p
    bx2, by2 = 100 * p, 78 * p
    r = 12 * p
    d.rounded_rectangle([bx1, by1, bx2, by2], radius=r, fill=(255, 255, 255, 255))

    # Bubble tail
    tail = [
        (38 * p, 76 * p),
        (28 * p, 98 * p),
        (55 * p, 76 * p),
    ]
    d.polygon(tail, fill=(255, 255, 255, 255))

    # Slash line
    slash_w = max(2, int(9 * p))
    margin = 18 * p
    d.line([(size - margin, margin), (margin, size - margin)],
           fill=(220, 50, 50, 255), width=slash_w)

    return img

for size in SIZES:
    img = draw_icon(size)
    path = f"{OUT}/icon-{size}.png"
    img.save(path)
    print(f"Saved {path}")

# Also overwrite the main Icon.png at 128px
main = draw_icon(128)
main.save(f"{OUT}/Icon.png")
print(f"Saved {OUT}/Icon.png")
