//
//  ForecastView.swift
//  Best Weather
//
//  Created by Łukasz Andrzejewski on 18/11/2023.
//

import SwiftUI

struct ForecastView: View {
    
    @State var viewModel: ForecastViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.top, .bottom]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                if let currentForecast = viewModel.currentForecast {
                    Text(viewModel.city)
                        .defaultStyle(size: 34)
                        .opacity(viewModel.isUnlocked ? 0.8 : 1)
                    VStack {
                        Text(viewModel.lastSeen ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                        Text(viewModel.lastPeek ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                    Spacer()
                    Image(systemName: currentForecast.icon)
                        .symbol(width: 200, height: 200)
                        .padding(.bottom, 24)
                        .padding()
                    Text(currentForecast.description)
                        .defaultStyle(size: 32)
                        .onTapGesture(count: 3) { viewModel.isUnlocked.toggle() }
                    HStack(spacing: 24){
                        Text(currentForecast.temperature)
                            .defaultStyle(size: 24)
                            .padding()
                        Text(currentForecast.pressure)
                            .defaultStyle(size: 24)
                            .padding()
                    }
                    .padding()
                    Spacer()
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.nextDaysForecast, content: DayForecastView.init)
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
    }
    
}

#Preview {
    let viewModel = ForecastViewModel(forecastService: ComponentsFactory().getPreviewForecastViewModel())
    return ForecastView(viewModel: viewModel)
}
