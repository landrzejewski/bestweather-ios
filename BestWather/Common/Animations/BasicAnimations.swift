//
//  BasicAnimations.swift
//  Best Weather
//
//  Created by Łukasz Andrzejewski on 02/06/2023.
//

import SwiftUI

struct BasicAnimations: View {
    
    @State
    var start = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: start ? 50 : 10)
            .frame(width: 100, height: 100)
            .foregroundColor(.accentColor)
        Spacer()
        Button(action: {
            withAnimation {
                start.toggle()
            }
        }) {
            Text("Start")
                .frame(width: 200, height: 40)
                .foregroundColor(.white)
                .background(.accent)
        }
        .cornerRadius(8)
    }
    
}

struct BasicAnimations_Previews: PreviewProvider {
    static var previews: some View {
        BasicAnimations()
    }
}
