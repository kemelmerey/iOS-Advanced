import UIKit

class UserProfileViewController: UIViewController, ProfileUpdateDelegate {
    var profileManager: ProfileManager?
    var imageLoader: ImageLoader?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupProfileManager()
    }

    func setupProfileManager() {
        profileManager = ProfileManager(delegate: self)
        profileManager?.onProfileUpdate = { [weak self] profile in
            self?.updateUI(with: profile)
        }
    }

    func updateProfile() {
        let userId = UUID()
        profileManager?.loadProfile(id: userId) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.updateUI(with: profile)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func updateUI(with profile: UserProfile) {
        print("Profile updated: \(profile.username)")
    }

    func profileDidUpdate(_ profile: UserProfile) {
        updateUI(with: profile)
    }

    func profileLoadingError(_ error: Error) {
        print("Failed to load profile: \(error.localizedDescription)")
    }
}


