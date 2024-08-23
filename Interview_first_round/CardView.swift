//
//  CardView.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import SwiftUI

struct CardView: View {
    let location: LocationTemplate
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(location.main) // use for weather.
                .font(.title2)
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var location = LocationTemplate(lat: 0, lon: 0, main: "", temp: 0, feels_like: 0, temp_max: 0, temp_min: 0, pressure: 0, humidity: 0)
    static var previews: some View {
        CardView(location: location)
    }
}
