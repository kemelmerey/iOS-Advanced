

import Foundation

struct Post: Hashable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}




