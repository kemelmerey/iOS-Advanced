import SwiftUI

@MainActor
final class HeroDetailViewModel: ObservableObject {
    @Published var hero: HeroEntity?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service: HeroService
    private let heroId: Int

    init(service: HeroService, heroId: Int) {
        self.service = service
        self.heroId = heroId
    }

    func fetchHeroDetail() async {
        isLoading = true
        do {
            let fetchedHero = try await service.fetchHeroById(id: heroId)
            hero = fetchedHero
        } catch {
            errorMessage = "Failed to load hero details."
        }
        isLoading = false
    }
}
