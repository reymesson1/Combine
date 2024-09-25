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
  private var authenticationService = AuthenticationService()
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""
  
  // MARK: Output
  @Published var usernameMessage: String = ""
  @Published var passwordMessage: String = ""
  @Published var isValid: Bool = false
    
    private var isUsernameAvailablePublisher: AnyPublisher<Bool, Never> {
        
        $username
            .flatMap{ username in
            
                self.authenticationService.checkUserNameAvailable(userName: username)
            }
            .eraseToAnyPublisher()
    }

    init(){
        
        isUsernameAvailablePublisher
            .assign(to: &$isValid)
        
        isUsernameAvailablePublisher
            .map {
                $0 ? ""
                : "Username not available. Try a different one."
            }
            .assign(to: &$usernameMessage)
        
    }
}
