//
//  DayForecastView.swift
//  Best Weather
//
//  Created by Łukasz Andrzejewski on 19/11/2023.
//

import SwiftUI

struct DayForecastView: View {
    
    let viewModel: DayForecastViewModel
    
    var body: some View {
        VStack(spacing: 4) {
            Text(viewModel.date)
                .defaultStyle(size: 18)
            Image(systemName: viewModel.icon)
                .symbol(width: 40, height: 40)
            Text(viewModel.temperature)
                .defaultStyle(size: 18)
        }
    }
}

#Preview {
    let viewModel = DayForecastViewModel(date: "Pn.", description: "Sunny", temperature: "-12°", pressure: "1000 hPa", icon: "sun.max.fill")
    return DayForecastView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
