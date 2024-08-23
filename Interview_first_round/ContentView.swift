//
//  ContentView.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import SwiftUI
import Network

struct ContentView: View {
    // @Binding var locations: [LocationTemplate]
    @EnvironmentObject var provider: LocationProvider
    
    @State private var areLocationsPresent = false;
    @State private var newLocationRequest = "";
    @State private var isFetchinLocation = false
    
    @State private var error: LocationError?
    @State private var hasError = false
    
    
    var body: some View {
        VStack {
            
            VStack {
                Spacer()
                TextField("Look Up Location", text: $newLocationRequest)
                    .onSubmit {
                        Task {
                            // Temporarily just makes a basic request.
                            if(!newLocationRequest.isEmpty) {
                                await fetchLocation()
                            }
                        }
                    }
                Spacer()
            }

            }
    }
}

extension ContentView {
    
    func fetchLocation() async {
        do {
            isFetchinLocation = true
            try await provider.fetchLocation()
        } catch {
            self.error = error as? LocationError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        
        isFetchinLocation = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var location = LocationTemplate(lat: 0, lon: 0, main: "", temp: 0, feels_like: 0, temp_max: 0, temp_min: 0, pressure: 0, humidity: 0)
    
    static var previews: some View {
        CardView(location: location)
    }
}

