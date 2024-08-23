//
//  LocationProvider.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import Foundation

@MainActor
class LocationProvider: ObservableObject {
    
    // Sample initialization
    @Published var location: LocationTemplate = LocationTemplate(lat: 0, lon: 0, main: "", temp: 0, feels_like: 0, temp_max: 0, temp_min: 0, pressure: 0, humidity: 0)
    
    let client: LocationClient
    
    func fetchLocation() async throws {
        let locationWeather = try await client.location
        self.location = locationWeather
    }
    
    static func load() async throws -> LocationTemplate {
        try await withCheckedThrowingContinuation {continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let aurora):
                    continuation.resume(returning: aurora)
                }
            }
        }
    }
    
    static func load(completion: @escaping(Result<LocationTemplate, Error>)->Void) {
        
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false)
                               .appendingPathComponent("location_weather.json")
                
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(LocationTemplate(lat: 0, lon: 0, main: "", temp: 0, feels_like: 0, temp_max: 0, temp_min: 0, pressure: 0, humidity: 0)))
                    }
                    return
                }
                let location_weather = try JSONDecoder().decode(LocationTemplate.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(location_weather))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    private static func fileURL() -> URL {
        try! FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("location_weather.json")
    }
    
    init(client: LocationClient = LocationClient()) {
        self.client = client
    }
}
