//
//  AuthenticationService.swift
//  project004
//
//  Created by user250318 on 9/24/24.
//

import Foundation
import Combine

class AuthenticationService {
    
    
    func checkUserNameAvailable(userName: String) -> AnyPublisher<Bool, Never> {
    
        guard let url = URL(string: "https://esimflys.com:8443/isusernamexist") else {
            
            return Just(false).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": userName]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = jsonData
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: UserNameAvailableMessage.self, decoder: JSONDecoder())
            .map(\.message)
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
    
}
