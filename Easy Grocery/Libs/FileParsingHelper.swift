import UIKit

class FileParsingHelper {
    static func parseJSONFile(filename: String) -> [CheckboxCell]? {
        // Get the path to the JSON file
        guard let path = Bundle.main.path(forResource: filename, ofType: "JSON") else {
            return nil
        }
        
        do {
            // Read the contents of the file
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            // Decode the JSON data into an array of CheckboxCell objects
            let decoder = JSONDecoder()
            let cells = try decoder.decode([CheckboxCell].self, from: data)
            
            return cells
        } catch {
            print("Error decoding JSON file: \(error)")
            return nil
        }
    }
    
    static func getExcludePreferences() -> [String] {
        // Load the plist file
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let plistPath = documentsDirectory.appendingPathComponent("UserPreferences.plist")
            if let plistData = try? Data(contentsOf: plistPath) {
                if let preferences = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any] {
                    return preferences["exclude_items"] as! [String]
                }
            }
        }
        
        return []
    }
    
    static func setExcludePreferences(_ excludeList: [String]) {
        // Load the plist file
        print("Set preferences invoked")
        if let plistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserPreferences.plist") {
            print(plistURL)
            let dict = ["exclude_items": excludeList]
            let data = try! PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)
            try! data.write(to: plistURL)
        }
    }
}
