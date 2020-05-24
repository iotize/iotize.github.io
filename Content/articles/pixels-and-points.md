---
title: Pixels and Points
date: 2020-05-24 17:15
tags: iOS
---

# Pixels and Points

Pixels are each a single area of illumination on the screen, and in order to get the highest quality screen image, manufacturers are packing as many in as possible. To deal with this, apps work with 'points' instead.

Points represent either individual or groups of pixels depending on the screen resolution. On a non-retina screen, points directly equate to pixels. On a retina screen in which there are exactly twice as many pixels, each point represents a 2×2 grid.

To give an example, a line of code that says 'draw a circle with a radius of 50pt' would, on a non-retina screen, render with a radius of 50 pixels. On a retina display, the system knows that each point is equivalent to 2×2 pixels, and so the circle would be rendered with a radius of 100 pixels. This looks the same to the user, but at a higher resolution.

Most on-screen components  - navigation bars, tab bars, lines, and text  - are drawn in points using Core Graphics and as such don't need modifying. In most cases, the only thing developers need to be concerned with are images: app icons, bar icons, photos, and video.

The reason images don't scale up is because the number of pixels rendered to the screen is limited to the number of pixels stored in the image data. This is fixed by supplying larger images that have more data.

At this point in time, the best practice is to provide 1x, 2x, and 3x sizes for each image asset, or vector-based images where possible. Tools like Sketch, Marvel, and Zeplin have built-in functionality for this.