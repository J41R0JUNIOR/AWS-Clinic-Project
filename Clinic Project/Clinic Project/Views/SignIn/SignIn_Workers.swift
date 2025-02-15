//
//  SignIn_Worker.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation

import Foundation

protocol SignInAuthWorkerProtocol {
    func authenticateUser(username: String, password: String, completion: @escaping (Result<Model.SignInReturn, Error>) -> Void)
}

struct AuthWorker: SignInAuthWorkerProtocol {
    func authenticateUser(username: String, password: String, completion: @escaping (Result<Model.SignInReturn, Error>) -> Void) {
        Task {
            do {
                let signInReturn = try await authenticateUser(username: username, password: password)
                completion(.success(signInReturn))
                
            } catch {
                completion(.failure(error))
            }
        }
    }

    private func authenticateUser(username: String, password: String) async throws -> Model.SignInReturn {
        let urlString = URLs.authSignIn.url
        
        guard let url = URL(string: urlString) else {
            throw Errors.invalidURL
        }
        
        let user = Model.User(clientId: ClientId.clientId.rawValue, username: username, password: password)
        let encodedUser = Utility.shared.encode(content: user)
        
        var request = URLRequest(url: url)
        request.httpMethod = MethodApi.post.rawValue
        request.httpBody = encodedUser
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw Errors.invalidResponse
        }
        
        guard let signInReturn: Model.SignInReturn = try Utility.shared.decode(content: data) else {
            throw Errors.decodingFailed
        }
        
        return signInReturn
    }
}

