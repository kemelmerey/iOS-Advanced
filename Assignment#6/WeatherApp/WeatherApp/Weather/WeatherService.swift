import Foundation

enum WeatherError: Error {
    case badURL, decodingError, networkError
}

class WeatherService {
    func fetchCurrentWeather(for city: String) async throws -> CurrentWeather {
        guard let url = URL(string: "\(Constants.baseURL)/current.json?key=\(Constants.apiKey)&q=\(city)&aqi=yes") else {
            throw WeatherError.badURL
        }
        return try await fetch(url: url)
    }

    func fetchForecast(for city: String, days: Int = 3) async throws -> Forecast {
        guard let url = URL(string: "\(Constants.baseURL)/forecast.json?key=\(Constants.apiKey)&q=\(city)&days=\(days)&alerts=yes") else {
            throw WeatherError.badURL
        }
        return try await fetch(url: url)
    }

    private func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            throw WeatherError.decodingError
        }
        return decoded
    }

    enum Constants {
        static let apiKey = "7e76fdf6d66043f7aff172056251004" 
        static let baseURL = "https://api.weatherapi.com/v1"
        static let defaultCity = "Almaty"
    }
}



