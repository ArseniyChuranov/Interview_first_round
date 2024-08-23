//
//  Interview_first_roundApp.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import SwiftUI

@main
struct Interview_first_roundApp: App {
    
    @StateObject var locationProvider = LocationProvider()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationProvider)
        }
    }
}
