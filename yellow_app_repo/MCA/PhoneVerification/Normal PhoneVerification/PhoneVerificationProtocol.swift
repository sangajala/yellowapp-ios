//
//  PhoneVerificationProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 28/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol PhoneVerificationPresenterProtocol: class {
    
    func validatePhoneNumberAndProceed(stringPhoneNumber: String, country_code : String)
    
    func isValidPhoneNumber(value: String) -> Bool
    
}


protocol PhoneVerificationViewProtocol: class {
    
    func setupOTPView()
    func initiateShowOTP()
    func showOTPView()
    func hideOTPView()
    
}
