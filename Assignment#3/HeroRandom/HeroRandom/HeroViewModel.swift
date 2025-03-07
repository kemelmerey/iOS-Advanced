//
//  HeroViewModel.swift
//  HeroRandom
//
//  Created by Kemel Merey on 07.03.2025.
//
import Foundation

final class HeroViewModel: ObservableObject {
    @Published var selectedHero: Hero?

    func fetchHero() async {
        guard let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json") else {
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)

            // Print raw JSON to check structure
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }

            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()

            await MainActor.run {
                selectedHero = randomHero
            }
        } catch {
            print("Decoding Error: \(error.localizedDescription)")
        }
    }
}

