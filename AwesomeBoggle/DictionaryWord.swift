import Foundation

struct DictWord: Codable {
    let id: Int?
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
    }
}
