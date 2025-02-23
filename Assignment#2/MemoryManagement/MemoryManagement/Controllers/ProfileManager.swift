

import Foundation

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager {
    private var activeProfiles: [String: UserProfile] = [:]
    weak var delegate: ProfileUpdateDelegate?
    var onProfileUpdate: ((UserProfile) -> Void)?

    init(delegate: ProfileUpdateDelegate) {
        self.delegate = delegate
    }

    func loadProfile(id: UUID, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }

            let profile = UserProfile(id: id, username: "User \(id.uuidString)", bio: "Swift Developer", followers: 100, profileURL: "profile.png")

            DispatchQueue.main.async {
                completion(.success(profile))
                self.delegate?.profileDidUpdate(profile)
                self.onProfileUpdate?(profile) 
            }
        }
    }
}


