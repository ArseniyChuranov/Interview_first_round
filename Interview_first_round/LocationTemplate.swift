//
//  Location_Template.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import Foundation

struct LocationTemplate {
    var lat: Double
    var lon: Double
    var main: String
    var temp: Double
    var feels_like: Double
    var temp_max: Double
    var temp_min: Double
    var pressure: Double
    var humidity: Double
}

struct Coordinates {
    var lat: Double
    var lon: Double
}
    
extension LocationTemplate: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case main = "main"
    }
    
    private enum CoordinateCodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
    
    private enum WeatherCodingKeys: String, CodingKey {
        case main = "main"
    }
    
    private enum MainCodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }

    
    init(from decoder: Decoder) throws {
        
        print()
        
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            let rawCoord = try values.nestedContainer(keyedBy: CoordinateCodingKeys.self, forKey: .coord)
            let rawWeather = try? values.decode(String.self, forKey: .weather) // does not pull info, look into it
            let rawMain = try values.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
            
            let rawLat = try? rawCoord.decode(Double.self, forKey: .lat)
            let rawLon = try? rawCoord.decode(Double.self, forKey: .lon)
            
            
            let rawTemp = try? rawMain.decode(Double.self, forKey: .temp)
            let rawFeels = try? rawMain.decode(Double.self, forKey: .feels_like)
            let rawMax = try? rawMain.decode(Double.self, forKey: .temp_max)
            let rawMin = try? rawMain.decode(Double.self, forKey: .temp_min)
            let rawPressure = try? rawMain.decode(Double.self, forKey: .pressure)
            let rawHumidity = try? rawMain.decode(Double.self, forKey: .humidity)
            
            guard let lat = rawLat,
                  let lon = rawLon,
                  let main = rawWeather,
                  let temp = rawTemp,
                  let feels_like = rawFeels,
                  let temp_max = rawMax,
                  let temp_min = rawMin,
                  let pressure = rawPressure,
                  let humidity = rawHumidity
            else {
                throw LocationError.missingData
            }
            
            self.lat = lat
            self.lon = lon
            self.main = main
            self.temp = temp
            self.feels_like = feels_like
            self.temp_max = temp_max
            self.temp_min = temp_min
            self.pressure = pressure
            self.humidity = humidity
            
        } catch {
            print("\(error)")
        }
        
        self.lat = 0
        self.lon = 0
        self.main = ""
        self.temp = 0
        self.feels_like = 0
        self.temp_max = 0
        self.temp_min = 0
        self.pressure = 0
        self.humidity = 0
        
    }
    
}
    



