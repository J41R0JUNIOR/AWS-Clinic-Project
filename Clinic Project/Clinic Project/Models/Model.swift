//
//  Model.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation

struct Model {
    struct User: Codable {
        var clientId: String?
        var username: String
        var password: String?
        var email: String?
        var code: String?
        var token: String?
    }
    
    struct SignInReturn: Codable {
        var accessToken: String
        var idToken: String
        var refreshToken: String
    }
    
    struct Patient: Codable {
        var id: String?
        var name: String?
        var birthDate: String?
        var healthServiceNumber: String?
        var phoneNumber: String?
        var height: Int?
        var weight: Int?
        
        struct adress {
            var street: String?
            var city: String?
            var state: String?
            var country: String?
            var postalCode: String?
        }
        
        var birthDateAsDate: Date {
            get {
                guard let birthDate = birthDate else { return Date() }
                let formatter = ISO8601DateFormatter()
                return formatter.date(from: birthDate) ?? Date()
            }
            set {
                let formatter = ISO8601DateFormatter()
                birthDate = formatter.string(from: newValue)
            }
        }
    }
}
