import ArgumentParser
import Foundation
import Plot
import Publish
import SplashPublishPlugin

struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case articles
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
      var title: String
      var date: String?
    }

    var url = URL(string: "http://www.ryanjdavies.com")!
    var name = "Ryan's Website"
    var description = "A website by Ryan."
    var language: Language { .english }
    var imagePath: Path? { "images/logo.png" }
}

struct Publisher: ParsableCommand {
    func run() throws {
        try! PersonalWebsite().publish(
            withTheme: .custom,
            plugins: [.splash(withClassPrefix: "")]
        )
    }
}

Publisher.main()
