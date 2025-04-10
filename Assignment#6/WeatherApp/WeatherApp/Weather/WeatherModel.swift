import Foundation

struct CurrentWeather: Codable {
    let location: Location
    let current: Current

    struct Location: Codable {
        let name: String
        let country: String
    }

    struct Current: Codable {
        let temp_c: Double
        let humidity: Int
        let wind_kph: Double
        let uv: Double
        let condition: Condition
    }

    struct Condition: Codable {
        let text: String
        let icon: String
    }
}

struct Forecast: Codable {
    let forecast: ForecastData

    struct ForecastData: Codable {
        let forecastday: [ForecastDay]
    }

    struct ForecastDay: Codable, Identifiable {
        var id: String { date }
        let date: String
        let day: Day
        let astro: Astro
    }

    struct Day: Codable {
        let avgtemp_c: Double
        let condition: CurrentWeather.Condition
    }

    struct Astro: Codable {
        let sunrise: String
        let sunset: String
    }
}

