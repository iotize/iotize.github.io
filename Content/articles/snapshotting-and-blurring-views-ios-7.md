---
title: Snapshotting and Blurring Views (iOS 7)
date: 2014-03-22 17:00
tags: iOS
---

Apple use an overlaying blur effect throughout iOS 7 to suggest 'depth' to the user, seen in the notification center, control center, and in many of Apple's apps:

![](/assets/images/2014/03/embrace_translucency_2x2.png)

But how are they achieving this effect? Some expected there to be a new `UIView` subclass that would automatically blur its background, but no such luck.

Instead, Apple introduced new, flexible methods on `UIView` that - along with some WWDC sample code - make it easy for developers to make use of blurring in their apps.

## Rendering UIKit Content

When you apply a blur effect on an image in your image editor it works by performing a complex algorithm on each pixel and its surrounding pixels. iOS is no exception - in order to create a blur effect, we need to create a bitmap image from the view hierarchy we have on screen.

`CALayer`, the workhorse for each view, has had the `-renderInContext:` method since iOS 2.0. It renders itself and all sublayers into a graphics context that can then have any effects applied to it before being converted into an image for display.

Unfortunately, as it runs in the CPU, `-renderInContext:` can be incredibly slow for complex hierarchies. It also doesn't take any view transforms into account.

Thankfully Apple introduced new methods on `UIView` in iOS 7 for creating snapshots of view hierarchies:

- `snapshotViewAfterScreenUpdates:` - the fastest method for creating still snapshots of a view hierarchy. Returns a `UIView` instance whose layer contents are immutable, which makes it useless for applying blur effects.
- `resizableSnapshotViewFromRect:afterScreenUpdates:withCapInsets:` - similar to `snapshotViewAfterScreenUpdates:` but with resizable insets.
- `drawViewHierarchyInRect:afterScreenUpdates:` - draws in the current image context, and according to WWDC 2013 Session 226 is up to 8 times faster than `renderInContext:`. This is the method we'll be using to apply image effects.

Drawing a view hierarchy now looks like this:

```
UIGraphicsBeginImageContext(rect.size);
[view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
```

The `image` object can then be manipulated as needed.

## Applying the blur effect

To achieve an identical blur effect we'll use Apple's sample code, which is available in the UIImageEffects WWDC 2013 sample project. If you have an Apple developer account, you can find it [here](https://developer.apple.com/downloads/index.action?name=WWDC%202013).

Once that's included in your project, you'll also need a view hierarchy to blur. I'm using a simple rainbow image to see a colourful blur:

![](/assets/images/2014/03/ios-simulator-screen-shot-22-mar-2014-20-30-31.png)

Now you can import `UIImage+ImageEffects.h` and call `-applyLightEffect` on the `UIImage` you generated from the view hierarchy:

```
UIImage *blurredImage = [image applyLightEffect];
```

That's it! All that's left is to render the image:

![](/assets/images/2014/03/ios-simulator-screen-shot-22-mar-2014-20-30-33.png)

You can see Apple's engineers discuss snapshotting and the iOS 7 blur effect in [WWDC 2013 Session 226](https://developer.apple.com/videos/wwdc/2013/). You can also read about Apple's stance on user interface depth in the [iOS Human Interface Guidelines](https://developer.apple.com/library/ios/documentation/userexperience/conceptual/MobileHIG/index.html).
