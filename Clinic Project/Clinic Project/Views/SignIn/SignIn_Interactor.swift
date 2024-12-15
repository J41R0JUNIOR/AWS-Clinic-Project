//
//  File.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation

protocol SignInInteractorProtocol {
//    func signIn(username: String, password: String)
//    func tryAutoSignIn(modelContainer: ModelContainer?)
}

class SignIn_Interactor: SignInInteractorProtocol {
    
    private var authWorker: AuthWorker
    var presenter: SignInPresenterProtocol
    
    init(authWorker: AuthWorker = .init(), presenter: SignInPresenterProtocol) {
        self.authWorker = authWorker
        self.presenter = presenter
    }
    
    func signIn(username: String, password: String) {
        print("Authenticating user...")
        
        authWorker.authenticateUser(username: username, password: password) { result in
            switch result {
            case .success(let user):
                print("success \(user)")
          
                self.presenter.userSignInSuccess(user: user)
                
                SwiftDataService.shared.save(login: .init(username: username, password: password, accessToken: "", idToken: "", refreshToken: ""))
                
            case .failure(let error):
                print("error \(error)")
                self.presenter.userSignInFailure(error: error)
            }
        }
    }
    
    func tryAutoSignIn() {
        SwiftDataService.shared.fetch { result in
            switch result {
            case .success(let users):
                print("User finded: \(users)")
                if let firstUser = users.first {
                    print("Username founded: \(firstUser.username)")
                    // Faça o auto login com os dados do primeiro usuário
                }
            case .failure(let error):
                print("Error looking for users: \(error)")
            }
        }
    }

}
