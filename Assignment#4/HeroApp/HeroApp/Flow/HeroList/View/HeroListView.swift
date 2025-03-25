import SwiftUI

struct HeroListView: View {
    @StateObject var viewModel: HeroListViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Hero List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                TextField("", text: $viewModel.searchQuery, prompt: Text("Search heroes...").foregroundColor(.white.opacity(0.7)))
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .font(.headline)
                    .shadow(color: .white.opacity(0.3), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    .onChange(of: viewModel.searchQuery) {
                        viewModel.filterHeroes()
                    }


                Divider()
                    .background(Color.white.opacity(0.5))
                    .frame(height: 1)
                    .padding(.horizontal, 32)

                
                listOfHeroes()

                Spacer()
            }
            .task {
                await viewModel.fetchHeroes()
            }
        }
    }
}

extension HeroListView {
    @ViewBuilder
    private func listOfHeroes() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.heroes) { model in
                    heroCard(model: model)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
    @ViewBuilder
    private func heroCard(model: HeroListModel) -> some View {
        HStack {
            AsyncImage(url: model.heroImage) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                default:
                    Color.gray
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .frame(width: 80, height: 80)
            .padding(.trailing, 16)
            
            VStack(alignment: .center, spacing: 4) {
                Text(model.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text(model.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.1)) 
        .cornerRadius(12)
        .shadow(color: Color.white.opacity(0.15), radius: 4, x: 0, y: 2)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.routeToDetail(by: model.id)
        }
    }
}
