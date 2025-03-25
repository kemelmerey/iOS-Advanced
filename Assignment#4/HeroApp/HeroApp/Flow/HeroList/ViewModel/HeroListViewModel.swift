import SwiftUI

@MainActor
final class HeroListViewModel: ObservableObject {
    @Published private(set) var heroes: [HeroListModel] = []
    @Published var searchQuery: String = "" {
        didSet {
            filterHeroes()
        }
    }
    @Published var filteredHeroes: [HeroListModel] = []

    private let service: HeroService
    private let router: HeroRouter

    init(service: HeroService, router: HeroRouter) {
        self.service = service
        self.router = router
    }

    func fetchHeroes() async {
        do {
            let heroesResponse = try await service.fetchHeroes()

            await MainActor.run {
                let mappedHeroes = heroesResponse.map {
                    HeroListModel(
                        id: $0.id,
                        title: $0.name,
                        description: $0.appearance?.race ?? "No Race",
                        heroImage: $0.heroImageUrl
                    )
                }
                self.heroes = mappedHeroes
                self.filteredHeroes = mappedHeroes
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func filterHeroes() {
        if searchQuery.isEmpty {
            filteredHeroes = heroes
        } else {
            filteredHeroes = heroes.filter { hero in
                hero.title.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
        
    func routeToDetail(by id: Int) {
        router.showDetails(for: id)
    }
    }
