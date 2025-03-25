import Foundation

struct HeroEntity: Decodable, Identifiable {
    let id: Int
    
    let name: String
    let biography: Biography
    let images: HeroImage
    var heroImageUrl: URL? {
        URL(string: images.sm)
    }
    let powerstats: Powerstats?
    let appearance: Appearance?
    let work: Work?

    struct Biography: Decodable {
        let fullName: String?
        let publisher: String?
        let alignment: String?
    }
    
    struct Appearance: Decodable {
        let gender: String?
        let race: String?
    }
    
    struct Work: Decodable {
        let occupation: String?
    }
    
    struct Powerstats:  Decodable {
        let intelligence: Int?
        let strength: Int?
        let speed: Int?
    }

    struct HeroImage: Decodable {
        let sm: String
        let md: String
    }
}


