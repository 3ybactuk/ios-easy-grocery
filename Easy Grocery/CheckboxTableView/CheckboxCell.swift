import UIKit

struct CheckboxCell: Equatable, Codable, Hashable {
    var title: String
    var description = String("")
    var excludes: [String] = []
    
    static func ==(lhs: CheckboxCell, rhs: CheckboxCell) -> Bool {
            return lhs.title == rhs.title
        }
}
