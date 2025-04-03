import SwiftUI

struct ImageView: View {
    @StateObject var viewModel = ImageViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    HStack(alignment: .top, spacing: 10) {
                        VStack(spacing: 10) {
                            ForEach(viewModel.images.indices.filter { $0.isMultiple(of: 2) }, id: \.self) { index in
                                viewModel.images[index].image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 15,
                                           height: CGFloat.random(in: 150...300))
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }

                        VStack(spacing: 10) {
                            ForEach(viewModel.images.indices.filter { !$0.isMultiple(of: 2) }, id: \.self) { index in
                                viewModel.images[index].image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 15,
                                           height: CGFloat.random(in: 150...300))
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
                Button("Get 5 Images") {
                    viewModel.getImages()
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 10)
            }
            .navigationTitle("Pinterest Gallery")
        }
    }
}

#Preview {
    ImageView()
}







