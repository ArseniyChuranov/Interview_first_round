//
//  Location_Template.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import Foundation

struct Location_Template: Identifiable, Codable {
    var id: UUID
    var title: String
    var latitude: Double
    var longitude: Double
    var current_weather: String
    var current_temp: Double
    
    init(id: UUID = UUID(), title: String, latitude: Double, longitude: Double, current_weather: String, current_temp: Double) {
        self.id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.current_weather = current_weather
        self.current_temp = current_temp
    }
}

