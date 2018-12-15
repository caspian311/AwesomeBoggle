import Foundation

struct DictWord: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}
