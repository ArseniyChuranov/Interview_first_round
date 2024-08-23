//
//  LocationClient.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import Foundation

actor LocationClient {

    var location: LocationTemplate {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            
            createTileDirectory()
            
            let outFile = try! FileManager.default.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: false)
                           .appendingPathComponent("location_weather.json")
        
            try data.write(to: outFile)
            let locationWeather = try decoder.decode(LocationTemplate.self, from: data)
            return locationWeather
        }
    }
         
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    private let feedURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={api_token}}")! // Add lat, Lon, date + key for a request.
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    // will need to save and write to keep track of history of requests.
    
    func createTileDirectory() {
        
        let documentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let dirPathTiles = documentDirectory.appendingPathComponent("Locations")
        
        if !FileManager.default.fileExists(atPath: dirPathTiles!.path()) {
            
            // if directory doesnt exist, create new.
            
            do {
                try FileManager.default.createDirectory(atPath: dirPathTiles!.path() , withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

