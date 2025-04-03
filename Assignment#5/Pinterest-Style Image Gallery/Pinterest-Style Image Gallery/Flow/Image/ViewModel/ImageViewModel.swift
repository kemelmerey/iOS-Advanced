import SwiftUI

final class ImageViewModel: ObservableObject {
    @Published var images: [ImageModel] = []

    func getImages() {
        var tempImages: [ImageModel] = []
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)

        let urlStrings: [String] = (0..<5).map { _ in
            "https://picsum.photos/300/500?random=\(Int.random(in: 0...1000))"
        }

        for url in urlStrings {
            group.enter()
            queue.async {
                self.downloadImage(urlString: url) { model in
                    if let model = model {
                        DispatchQueue.main.async {
                            tempImages.append(model)
                        }
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: DispatchQueue.main) {
            self.images += tempImages
        }
    }

    private func downloadImage(urlString: String, completion: @escaping (ImageModel?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                completion(ImageModel(image: image))
            } else {
                completion(nil)
            }
        }.resume()
    }
}


