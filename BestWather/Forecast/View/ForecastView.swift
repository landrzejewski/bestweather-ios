//
//  ForecastView.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import SwiftUI

struct ForecastView: View {
    
    @State var viewModel: ForecastViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ForecastView(viewModel: ForecastViewModel())
}
