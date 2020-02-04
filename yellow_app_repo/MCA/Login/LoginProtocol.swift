//
//  LoginProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: class {
    
    func performLoginValidationsAndProceed()
    
    func isValidPassword(password: String) -> Bool
    
    func isValidEmail(emailString: String) -> Bool
    
    func resignAllResponders()
    
    func loginUser(email: String, password: String, social_loginID: String, social_loginTYPE: String, isSocial: Bool)
    
}

protocol LoginViewProtocol: class {
    
    func loginResponse(loginModel: LoginModel)
    
}
