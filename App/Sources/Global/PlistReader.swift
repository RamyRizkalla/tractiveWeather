//Copyright © 2020 Tractive. All rights reserved.

import Foundation

class PlistReader {
    static func readFromPlist<Property: Decodable>(_ fileName: String) -> Property {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            preconditionFailure("File not found")
        }
        guard let data = try? Data(contentsOf: fileUrl) else {
            preconditionFailure("Failed to Decode Data")
        }
        guard let propertiesList = try? PropertyListDecoder().decode(Property.self, from: data) else {
            preconditionFailure("Failed to Decode Data")
        }
        return propertiesList
    }
}

struct InfoPlist: Decodable {
    var weatherApiKey: String
}
