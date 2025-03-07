import SwiftUI

struct HeroView: View {
    @StateObject var viewModel = HeroViewModel()

    var body: some View {
        VStack {
            if let hero = viewModel.selectedHero {
                AsyncImage(url: URL(string: hero.images?.sm ?? "")) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.frame(height: 200)
                }
                .frame(height: 200)

                VStack(alignment: .leading, spacing: 8) {
                    InfoRow(title: "Name", value: hero.name)
                    InfoRow(title: "Full Name", value: hero.biography.fullName ?? "Unknown")
                    InfoRow(title: "Intelligence", value: "\(hero.powerstats?.intelligence ?? 0)")
                    InfoRow(title: "Strength", value: "\(hero.powerstats?.strength ?? 0)")
                    InfoRow(title: "Speed", value: "\(hero.powerstats?.speed ?? 0)")
                    InfoRow(title: "Gender", value: hero.appearance?.gender ?? "Unknown")
                    InfoRow(title: "Occupation", value: hero.work?.occupation ?? "Unknown")
                    InfoRow(title: "Publisher", value: hero.biography.publisher ?? "Unknown")
                    InfoRow(title: "Alignment", value: hero.biography.alignment ?? "Unknown")
                }
                .padding()
            } else {
                ProgressView("Fetching Hero...")
            }

            Button("Randomize") {
                Task {
                    await viewModel.fetchHero()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear {
            Task {
                await viewModel.fetchHero()
            }
        }
    }
}

// Reusable Row View
struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
            Spacer()
            Text(value)
        }
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView()
    }
}

