import Foundation

protocol HeroService {
    func fetchHeroes() async throws -> [HeroEntity]
    func fetchHeroById(id: Int) async throws -> HeroEntity
}

struct HeroServiceImpl: HeroService {
    func fetchHeroes() async throws -> [HeroEntity] {
        let urlString = Constants.baseUrl + "all.json"
        guard let url = URL(string: urlString) else { throw HeroError.wrongUrl }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([HeroEntity].self, from: data)
    }

    func fetchHeroById(id: Int) async throws -> HeroEntity {
        let urlString = Constants.baseUrl + "id/\(id).json"
        guard let url = URL(string: urlString) else { throw HeroError.wrongUrl }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(HeroEntity.self, from: data)
    }
}

enum HeroError: Error {
    case wrongUrl
    case somethingWentWrong
}

private enum Constants {
    static let baseUrl: String = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/"
}

