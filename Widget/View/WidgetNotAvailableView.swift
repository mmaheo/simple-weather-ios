//
//  WidgetNotAvailableView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct WidgetNotAvailableView: View {
    
    // MARK: - Body
    
    var body: some View {
        Text("§Widget is not available.")
            .multilineTextAlignment(.center)
    }
}

#if DEBUG

struct WidgetNotAvailableView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetNotAvailableView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            WidgetNotAvailableView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            WidgetNotAvailableView()
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

#endif
