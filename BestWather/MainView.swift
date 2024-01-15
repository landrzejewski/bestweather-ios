//
//  MainView.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import SwiftUI

struct MainView: View {

    let componentsFactory: ComponentsFactory
    
    init(componentsFactory: ComponentsFactory) {
        self.componentsFactory = componentsFactory
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    var body: some View {
        TabView {
            ForecastRouterView(componentsFactory: componentsFactory.forecastFactory)
                .environment(ForecastRouter())
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("Forecast")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
    
}
