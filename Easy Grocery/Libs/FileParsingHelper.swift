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
    
    static func getProductsCSV() -> [ProductViewModel] {
        var products = [ProductViewModel]()
        
        guard let filepath = Bundle.main.path(forResource: "vprok_base_small", ofType: "csv") else {
            return products
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)
            return products
        }
        
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        
        // 0index, 1'Название', 2'О товаре', 3'Производитель', 4'Торговая марка', 5'Страна', 6'Вес', 7'Объем', 8'Состав', 9'Вид', 10'Энергетическая ценность', 11'Белки', 12'Жиры', 13'Углеводы', 14'Срок годности', 15'Стоимость', 16'IMG URL', 17'URL'
        for row in rows {
            let columns = row.components(separatedBy: "|")
//            print(columns)
            let productName = columns[1]
            let weight = columns[6].count != 0 ? columns[6] : nil
            let volume = columns[7].count != 0 ? columns[7] : nil
            let price = columns[15].count != 0 ? columns[15] : nil
            let imgURL = columns[16]
            let productURL = columns[17]
            
            let product = ProductViewModel(name: productName, weight: weight, volume: volume, price: price, imageURL: URL(string: imgURL), productURL: URL(string: productURL))
            
            products.append(product)
        }
        
        return products
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
