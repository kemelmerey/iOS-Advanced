import SwiftUI
import UIKit

final class HeroRouter {
    var rootViewController: UINavigationController?
    
    func showDetails(for id: Int) {
        let detailVC = makeDetailViewController(id: id)
        rootViewController?.pushViewController(detailVC, animated: true)
    }
    
    private func makeDetailViewController(id: Int) -> UIViewController {
        let detailView = HeroDetailView(heroId: id)
        return UIHostingController(rootView: detailView)
    }
}






