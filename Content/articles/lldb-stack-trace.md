---
title: How to print a stack trace in the Xcode console
date: 2020-05-23 20:45
tags: Xcode
---

# How to print a stack trace in the Xcode console

In the lldb console in Xcode, the command `bt` generates a stack trace. This is a trick I use occasionally, usually when I find a crash during debugging. It looks something like this:

```
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000100004277 Publisher`static Node<A>.footer<A>(site=, self=Plot.Node<Plot.HTML.BodyContext>) at CustomTheme.swift:207:17
    frame #1: 0x0000000100002cb0 Publisher`CustomHTMLFactory.makeIndexHTML(index=Publish.Index @ 0x00007ffeefbfd190, context=Publish.PublishingContext<Publisher.PersonalWebsite> @ 0x00007ffeefbfcf10, self=Publisher.CustomHTMLFactory<Publisher.PersonalWebsite> @ scalar) at CustomTheme.swift:36:18
    frame #2: 0x0000000100007e4a Publisher`protocol witness for HTMLFactory.makeIndexHTML(for:context:) in conformance CustomHTMLFactory<A> at <compiler-generated>:0
    frame #3: 0x000000010009fc97 Publisher`partial apply at <compiler-generated>:0
    frame #4: 0x00000001000ac9f6 Publisher`HTMLGenerator.generateIndexHTML(self=Publish.HTMLGenerator<Publisher.PersonalWebsite> @ 0x00007ffeefbfd510) at HTMLGenerator.swift:49:30
    frame #5: 0x00000001000abee4 Publisher`HTMLGenerator.generate(self=Publish.HTMLGenerator<Publisher.PersonalWebsite> @ 0x00007ffeefbfd510) at HTMLGenerator.swift:18:13
    frame #6: 0x000000010006cb25 Publisher`closure #1 in static PublishingStep.generateHTML(context=Publish.PublishingContext<Publisher.PersonalWebsite> @ 0x00007ffeefbfd960, theme=Publish.Theme<Publisher.PersonalWebsite> @ 0x0000000100ac1df0, indentation=nil, fileMode=foldersAndIndexFiles) at PublishingStep.swift:326:27
    frame #7: 0x000000010006cd9f Publisher`partial apply for closure #1 in static PublishingStep.generateHTML(withTheme:indentation:fileMode:) at <compiler-generated>:0
    frame #8: 0x00000001000e8e0b Publisher`PublishingPipeline.execute(site=, path=nil, self=Publish.PublishingPipeline<Publisher.PersonalWebsite> @ 0x00007ffeefbfe7c0) at PublishingPipeline.swift:55:26
    frame #9: 0x00000001000a38ed Publisher`Website.publish(path=nil, steps=9 values, file="/Users/Ryan/Developer/Blog/Sources/Publisher/main.swift", self=) at Website.swift:114:29
    frame #10: 0x00000001000a2f50 Publisher`Website.publish(theme=Publish.Theme<Publisher.PersonalWebsite> @ 0x00007ffeefbff338, indentation=nil, path=nil, rssFeedSections=1 value, rssFeedConfig=some, deploymentMethod=nil, additionalSteps=0 values, plugins=1 value, file="/Users/Ryan/Developer/Blog/Sources/Publisher/main.swift", self=) at Website.swift:78:13
    frame #11: 0x0000000100011a21 Publisher`Publisher.run(self=Publisher.Publisher @ scalar) at main.swift:26:32
    frame #12: 0x0000000100011fef Publisher`protocol witness for ParsableCommand.run() in conformance Publisher at <compiler-generated>:0
    frame #13: 0x00000001001ea840 Publisher`static ParsableCommand.main(arguments=nil, self=Publisher.Publisher) at ParsableCommand.swift:95:19
    frame #14: 0x000000010000f9a4 Publisher`main at main.swift:33:11
    frame #15: 0x00007fff6da58cc9 libdyld.dylib`start + 1
```

This was from setting a breakpoint in the project that [generates this website](https://github.com/iotize/iotize.github.io).