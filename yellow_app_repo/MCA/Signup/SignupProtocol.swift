//
//  SignupProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol SignupPresneterProtocol: class {
    
    func performSignupValidationsAndProceed()
    
    func isValidPassword(password: String) -> Bool
    
    func isValidEmail(emailString: String) -> Bool
    
    func resignAllResponders()
    
    func registerUser(firstName: String, lastName: String, email: String, phone: String, password: String, social_loginID: String, social_loginTYPE: String, isSocial: Bool)
    
}

protocol SignupViewProtocol: class {
    
    func registerResponse(signupModel: SignupModel)
    
}
