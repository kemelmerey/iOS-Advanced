//
//  Hero.swift
//  HeroRandom
//
//  Created by Kemel Merey on 07.03.2025.
//
import Foundation

struct Hero: Codable, Identifiable {
    var id: Int
    
    let name: String
    let biography: Biography
    let images: HeroImage?
    let powerstats: Powerstats?
    let appearance: Appearance?
    let work: Work?

    struct Biography: Codable {
        let fullName: String?
        let publisher: String?
        let alignment: String?
    }
    
    struct Appearance: Codable {
        let gender: String?
    }
    
    struct Work: Codable {
        let occupation: String?
    }
    
    struct Powerstats: Codable {
        let intelligence: Int?
        let strength: Int?
        let speed: Int?
    }

    struct HeroImage: Codable {
        let sm: String?
    }
}


