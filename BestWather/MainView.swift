//
//  MainView.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    
    @Environment(Router.self) var router: Router
    let componentsFactory: ComponentsFactory
    
    init(componentsFactory: ComponentsFactory) {
        self.componentsFactory = componentsFactory
    }
    
    var body: some View {
        switch router.route {
        case .forecast:
            ForecastView(viewModel: componentsFactory.getForecastViewModel())
        case .profile:
            ProfileView()
        }
    }
    
}
