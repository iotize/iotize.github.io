import Foundation
import Publish

struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case articles
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
    }

    var url = URL(string: "http://www.ryanjdavies.com")!
    var name = "Ryan's Website"
    var description = "A website by Ryan."
    var imagePath: Path? { "images/logo.png" }
}

try! PersonalWebsite().publish(withTheme: .foundation)
