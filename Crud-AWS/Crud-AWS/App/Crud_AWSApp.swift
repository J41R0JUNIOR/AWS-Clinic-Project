//
//  Crud_AWSApp.swift
//  Crud-AWS
//
//  Created by Jairo Júnior on 25/10/24.
//

import SwiftUI

@main
struct Crud_AWSApp: App {
    @Bindable var router = Router.shared
    var api = Api.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                AuthView()
            }.environmentObject(router)
            .navigationDestination(for: RoutePath.self) { route in
                route.findPath()
            }
        }
    }
}

