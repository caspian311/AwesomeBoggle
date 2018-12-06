import Foundation

struct GameData: Codable {
    let id: Int
    let grid: String
    let isReady: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "gameId"
        case grid = "grid"
        case isReady = "isReady"
    }
}
