import Foundation
import SwiftUI

enum LoadingState {
    case idle, loading, success, failure(String)
}

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var current: CurrentWeather?
    @Published var forecast: Forecast?

    @Published var currentState: LoadingState = .idle
    @Published var forecastState: LoadingState = .idle

    @Published var searchText: String = ""

    private let service = WeatherService()

    func loadWeather(for city: String) {
        Task {
            currentState = .loading
            forecastState = .loading

            do {
                async let currentTask = service.fetchCurrentWeather(for: city)
                async let forecastTask = service.fetchForecast(for: city)

                self.current = try await currentTask
                self.forecast = try await forecastTask

                currentState = .success
                forecastState = .success
            } catch {
                currentState = .failure("Current weather error")
                forecastState = .failure("Forecast error")
            }
        }
    }
}





