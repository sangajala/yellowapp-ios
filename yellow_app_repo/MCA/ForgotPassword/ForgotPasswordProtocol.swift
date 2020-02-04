//
//  ForgotPasswordProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 22/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol ForgotPasswordPresenterProtocol: class {
    
    func performForgotPasswordEmailValidationsAndProceed()
    
    func isValidEmail(emailString: String) -> Bool
    
    func resignAllResponders()
    
    func forgotPassword(forEmail email: String)
}

protocol ForgotPasswordViewProtocol: class {
    func forgotPasswordResponse(forgotPasswordModel: ForgotpasswordModel)
}
