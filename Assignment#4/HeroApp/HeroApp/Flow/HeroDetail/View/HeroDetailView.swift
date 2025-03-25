import SwiftUI

struct HeroDetailView: View {
    @StateObject private var viewModel: HeroDetailViewModel
    
    init(heroId: Int) {
        _viewModel = StateObject(wrappedValue: HeroDetailViewModel(service: HeroServiceImpl(), heroId: heroId))
    }

    var body: some View {
        ZStack {
            LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                .ignoresSafeArea()

            VStack {
                if viewModel.isLoading {
                    ProgressView("Fetching Hero...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .font(.headline)
                        .foregroundColor(.white)
                } else if let hero = viewModel.hero {
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            AsyncImage(url: hero.heroImageUrl) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 280, height: 280)
                                        .clipped()
                                        .cornerRadius(15)
                                        .shadow(color: Color.white.opacity(0.8), radius: 10, x: 0, y: 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                default:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 280, height: 280)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(.white.opacity(0.7))
                                        )
                                        .cornerRadius(15)
                                }
                            }

                            Text("\(hero.name)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top, 8)
                                .shadow(radius: 5)

                            Text(hero.biography.fullName ?? "🕶 Unknown Identity")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))

                            detailsCard(hero: hero)

                            if let powerstats = hero.powerstats {
                                powerStatsCard(powerstats: powerstats)
                            }
                        }
                        .padding()
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text("⚠️ \(errorMessage)")
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding()
                } else {
                    Text("❌ No hero found.")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchHeroDetail()
            }
        }
    }
}

@ViewBuilder
private func detailsCard(hero: HeroEntity) -> some View {
    VStack(alignment: .leading, spacing: 12) {
        Text("📝 Hero Information")
            .font(.headline)
            .foregroundColor(.white)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, alignment: .center)

        infoRow(label: "📖 Publisher", value: hero.biography.publisher ?? "Unknown")
        infoRow(label: "⚖️ Alignment", value: hero.biography.alignment ?? "Unknown")
        infoRow(label: "🚻 Gender", value: hero.appearance?.gender ?? "Unknown")
        infoRow(label: "🌍 Race", value: hero.appearance?.race ?? "Unknown")
        infoRow(label: "💼 Occupation", value: hero.work?.occupation ?? "Unknown")
    }
    .padding()
    .frame(maxWidth: 360) // Centering the card
    .background(Color.blue.opacity(0.7)) // Updated background
    .cornerRadius(15)
    .overlay(
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.white.opacity(0.7), lineWidth: 1.5)
    )
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .center) 
}

@ViewBuilder
private func powerStatsCard(powerstats: HeroEntity.Powerstats) -> some View {
    VStack(alignment: .leading, spacing: 12) {
        Text("⚡ Power Stats")
            .font(.headline)
            .foregroundColor(.white)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, alignment: .center)

        infoRow(label: "🧠 Intelligence", value: "\(powerstats.intelligence ?? 0)")
        infoRow(label: "💪 Strength", value: "\(powerstats.strength ?? 0)")
        infoRow(label: "⚡ Speed", value: "\(powerstats.speed ?? 0)")
    }
    .padding()
    .frame(maxWidth: 360)
    .background(Color.purple.opacity(0.7))
    .cornerRadius(15)
    .overlay(
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.white.opacity(0.8), lineWidth: 1.5)
    )
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .center)
}

@ViewBuilder
private func infoRow(label: String, value: String) -> some View {
    HStack {
        Text("\(label):")
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white.opacity(0.9))
        Spacer()
        Text(value)
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.9))
    }
}








