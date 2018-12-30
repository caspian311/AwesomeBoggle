import Foundation

struct InvitationData: Codable {
    let invitations: [Invitation]
    
    enum CodingKeys: String, CodingKey {
        case invitations = "invitations"
    }
}
