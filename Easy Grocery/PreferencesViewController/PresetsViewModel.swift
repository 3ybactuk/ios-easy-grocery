import UIKit

final class PresetsViewModel : Codable {
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
