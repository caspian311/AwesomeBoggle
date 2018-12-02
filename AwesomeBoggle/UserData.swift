import Foundation

struct UserData:Codable {
    let id: Int
    let username: String
    let authToken: String
    
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case username = "username"
        case authToken = "authToken"
    }
}
