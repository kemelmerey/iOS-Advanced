import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        HStack {
                            TextField("Enter city name", text: $viewModel.searchText)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.leading)
                            
                            Button(action: {
                                viewModel.loadWeather(for: viewModel.searchText)
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .padding()
                                    .background(viewModel.searchText.isEmpty ? Color.gray : Color.white)
                                    .foregroundColor(.black)
                                    .clipShape(Circle())
                            }
                            .disabled(viewModel.searchText.isEmpty)
                            .padding(.trailing)
                        }
                        .padding(.top)

                        if case .success = viewModel.currentState, let current = viewModel.current {
                            VStack(spacing: 10) {
                                Image(systemName: "cloud.sun.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.yellow)

                                Text("\(current.current.temp_c, specifier: "%.0f")°C")
                                    .font(.system(size: 48, weight: .bold))

                                Text("\(current.current.condition.text)")
                                    .font(.title3)

                                Text("📍 \(current.location.name), \(current.location.country)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 20) {
                                    Label("\(current.current.humidity)%", systemImage: "drop.fill")
                                    Label("\(current.current.wind_kph, specifier: "%.1f") km/h", systemImage: "wind")
                                    Label("UV: \(current.current.uv)", systemImage: "sun.max")
                                }
                                .font(.footnote)
                                .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white.opacity(0.9))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        } else if case .loading = viewModel.currentState {
                            ProgressView("Loading current weather...")
                                .padding()
                        } else if case .failure(let message) = viewModel.currentState {
                            Text(message).foregroundColor(.red)
                        }

                        if case .success = viewModel.forecastState, let forecast = viewModel.forecast {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("3-Day Forecast")
                                    .font(.headline)
                                    .padding(.bottom, 5)

                                ForEach(forecast.forecast.forecastday) { day in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(day.date)
                                                .font(.subheadline)
                                                .bold()

                                            Text("🌤 \(day.day.condition.text)")
                                                .font(.caption)
                                        }

                                        Spacer()

                                        VStack(alignment: .trailing) {
                                            Text("🌡 \(day.day.avgtemp_c, specifier: "%.1f")°C")
                                            Text("🌅 \(day.astro.sunrise)")
                                            Text("🌇 \(day.astro.sunset)")
                                        }
                                        .font(.caption)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 2)
                                }
                            }
                            .padding()
                            .background(.white.opacity(0.1))
                            .cornerRadius(15)
                            .padding(.horizontal)
                        } else if case .loading = viewModel.forecastState {
                            ProgressView("Loading forecast...")
                        } else if case .failure(let message) = viewModel.forecastState {
                            Text(message).foregroundColor(.red)
                        }

                        Button(action: {
                            let city = viewModel.searchText.isEmpty ? WeatherService.Constants.defaultCity : viewModel.searchText
                            viewModel.loadWeather(for: city)
                        }) {
                            Label("Refresh", systemImage: "arrow.clockwise")
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("🌦 Weather App")
            .onAppear {
                viewModel.loadWeather(for: WeatherService.Constants.defaultCity)
            }
        }
    }
}

#Preview {
    WeatherView()
}






