import Foundation

struct Invitation: Codable {
    let gameId: Int
    let userId: Int
    let username: String
    let accepted: Bool
    
    enum CodingKeys: String, CodingKey {
        case gameId = "gameId"
        case userId = "userId"
        case username = "username"
        case accepted = "accepted"
    }
}
