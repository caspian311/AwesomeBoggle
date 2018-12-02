import Foundation

struct GameData: Codable {
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "gameId"
    }
}
