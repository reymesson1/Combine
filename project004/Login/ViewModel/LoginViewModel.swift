//
//  LoginViewModel.swift
//  project004
//
//  Created by user250318 on 9/20/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
  
  // MARK: Input
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""
  
  // MARK: Output
  @Published var usernameMessage: String = ""
  @Published var passwordMessage: String = ""
  @Published var isValid: Bool = false

    private var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never> {
        
        $username
            .map{ $0.count >= 3 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        
        $password
            .map{ $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordMatchingPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordConfirmation)
            .map(==)
            .eraseToAnyPublisher()
    }
    
    init(){
        isUsernameLengthValidPublisher
            .assign(to: &$isValid)
        
        isUsernameLengthValidPublisher
            .map{
                $0 ? ""
                : "Username too short. Needs to be at least 3 characters."
            }
            .assign(to: &$usernameMessage)
        
        Publishers.CombineLatest(
        
            isPasswordEmptyPublisher,
            isPasswordMatchingPublisher
        )
        .map { isPasswordEmpty, isPasswordMatching in
        
            if isPasswordEmpty {
                return "Password must be empty"
            } else if !isPasswordMatching {
                return "Password do not match"
            }
            return ""
        }
        .assign(to: &$passwordMessage)
        
    }
}
