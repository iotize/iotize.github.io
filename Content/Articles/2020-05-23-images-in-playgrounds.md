---
title: Images in Playgrounds
date: 2020-05-23 16:30
tags: Xcode
---

# Images in Playgrounds

In Xcode playgrounds it's possible to find resources by name, instead of absolute path, to write code like this:

```
let image = UIImage(named: "Demo")
```

In iOS and macOS projects, finding a resource by name is handy because it means making all resources known to the project ,  which – so long as the resource files are all within the project directory – means the same project can be compiled on another machine without requiring specific and seemingly unrelated directories or files in a separate area of the file system. It's all self-contained.

In an Xcode playground there's no obvious 'bundle' to draw from. There are no other files, no xcassets  –  it's just a window of code.

Fortunately, that doesn't mean images can't be referenced by name. Images must simply be added to a specific 'Resources' directory, which can be seen in the File Inspector of a playground:

![](/assets/images/2020/05/playground-image-bad-access.png)

(Currently there's an error because there's no image at that location.)

This Resource Path points to a location within the playground, revealing that it's actually a bundle rather than a file:

![](/assets/images/2020/05/playground-bundle-contents.png)

Inside are one or more .swift files, some playground specific files, and an empty Resources directory.

Adding an image to this directory makes it available to the playground:

![](/assets/images/2020/05/playground-bundle-with-image.png)

That's it! Now it's easy to write snippets for image manipulation or for creating custom views with decoration images to see how they look.

![](/assets/images/2020/05/playground-wtih-image.png)

For more information on resources in playgrounds, see [WWDC 2014 Session 401 "What's New In Xcode 6″](https://developer.apple.com/videos/wwdc/2014/).