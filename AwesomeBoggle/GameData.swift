import Foundation

struct GameData: Codable {
    let id: Int
    let grid: String
    
    enum CodingKeys: String, CodingKey {
        case id = "gameId"
        case grid = "grid"
    }
}
