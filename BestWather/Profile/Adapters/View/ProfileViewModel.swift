//
//  ProfileViewModel.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 01/06/2023.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    
    @Published
    var firstName = ""
    @Published
    var lastName = ""
    @Published
    var dateOfBirth = Date()
    @Published
    var email = ""
    @Published
    var password = ""
    @Published
    var isSubscriber = false
    @Published
    var cardNumber = ""
    @Published
    var cardCvv = ""
    @Published
    var cardExpirationDate = Date()
    @Published
    var errors: [String] = []
        
}
