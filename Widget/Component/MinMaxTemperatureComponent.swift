//
//  MinMaxTemperatureComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 03/12/2020.
//

import SwiftUI

enum MinMaxTemperatureType {
    case min, max
}

struct MinMaxTemperatureComponent: View {
    
    // MARK: - Properties
    
    let temperature: Int
    let type: MinMaxTemperatureType
    
    private var iconSystemName: String {
        type == .min ? "arrow.down" : "arrow.up"
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 2) {
            Text("\(temperature)°")
                .font(.callout)
            
            Image(systemName: iconSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10,
                       height: 10)
        }
    }
    
}

#if DEBUG

struct MinMaxTemperatureComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MinMaxTemperatureComponent(temperature: 12,
                                       type: .max)
            
            MinMaxTemperatureComponent(temperature: 4,
                                       type: .min)
        }
        .previewLayout(.sizeThatFits)
    }
}

#endif
