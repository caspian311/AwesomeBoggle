import Foundation

struct CheckAvailabilityData: Codable {
    let isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case isAvailable = "isAvailable"
    }
}
