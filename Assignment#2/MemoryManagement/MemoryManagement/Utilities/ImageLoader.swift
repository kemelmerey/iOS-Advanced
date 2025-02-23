import UIKit
protocol ImageLoaderDelegate: AnyObject {
    func didLoadImage(_ image: UIImage?)
}

class ImageLoader {
    weak var delegate: ImageLoaderDelegate?
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
                self.delegate?.didLoadImage(image) 
            }
        }.resume()
    }
}
