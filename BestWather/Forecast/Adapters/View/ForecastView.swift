//
//  ForecastView.swift
//  Best Weather
//
//  Created by Łukasz Andrzejewski on 18/11/2023.
//

import SwiftUI
import Factory

struct ForecastView: View {
    
    @State var viewModel: ForecastViewModel
    @Environment(ForecastRouter.self) private var router
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.top, .bottom]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                if let currentForecast = viewModel.currentForecast {
                    Text(viewModel.city)
                        .defaultStyle(size: 34)
                    Spacer()
                    Image(systemName: currentForecast.icon)
                        .symbol(width: 200, height: 200)
                        .padding(.bottom, 24)
                        .padding()
                        .onTapGesture {
                            router.route = .forecastDetails(currentForecast)
                        }
                    Text(currentForecast.description)
                        .defaultStyle(size: 32)
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
                if viewModel.error {
                    VStack {
                        Spacer()
                        Text("Refresh forecast failed")
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.bottom, 32)
                    }
                }
            }
        }
    }
    
}

#Preview {
    let viewModel = Container.shared.fakeForecastViewModel()
    return ForecastView(viewModel: viewModel)
}
