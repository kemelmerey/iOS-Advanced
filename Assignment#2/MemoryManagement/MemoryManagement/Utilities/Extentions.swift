import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}

