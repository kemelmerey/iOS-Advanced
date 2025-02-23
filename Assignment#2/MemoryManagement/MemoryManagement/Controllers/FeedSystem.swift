
import Foundation

class FeedSystem {
    private var userCache: [UUID: UserProfile] = [:]
    private var feedPosts: [Post] = []
    private var hashtags: Set<String> = []

    func addUser(_ user: UserProfile) {
        userCache[user.id] = user
    }

    func getUser(by id: UUID) -> UserProfile? {
        return userCache[id]
    }

    func addPost(_ post: Post) {
        feedPosts.insert(post, at: 0)
        extractHashtags(from: post.content) // No need for `mutating`
    }

    private func extractHashtags(from text: String) {
        let words = text.split(separator: " ")
        for word in words where word.starts(with: "#") {
            hashtags.insert(String(word))
        }
    }

    func searchByHashtag(_ tag: String) -> [Post] {
        return feedPosts.filter { $0.content.contains("#\(tag)") }
    }
}


