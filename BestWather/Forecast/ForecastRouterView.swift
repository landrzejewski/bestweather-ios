//
//  ForecastRouterView.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import SwiftUI

struct ForecastRouterView: View {
    
    @Environment(ForecastRouter.self) var router
    private let componentsFactory: ForecastComponentsFactory
    
    init(componentsFactory: ForecastComponentsFactory) {
        self.componentsFactory = componentsFactory
    }
    
    var body: some View {
        switch router.route {
        case .forecast:
            ForecastView(viewModel: componentsFactory.getForecastViewModel())
        case .forecastDetails(let viewModel):
            ForecastDetailsView(viewModel: viewModel)
        }
    }
    
}
