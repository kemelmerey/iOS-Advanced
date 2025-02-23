

import Foundation

struct UserProfile: Hashable {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int
    var profileURL: String

    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


