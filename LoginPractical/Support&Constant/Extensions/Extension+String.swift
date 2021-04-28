//
//  Extension+String.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation

extension String {
	var isValidEmail: Bool {
		let emailPred = NSPredicate(format:"SELF MATCHES %@", ValidationType.email.rawValue)
		return emailPred.evaluate(with: self)
	}

	var isValidPassword: Bool {
		if self.contains(" ") {
			return false
		}
		let passwordCheck = NSPredicate(format: "SELF MATCHES %@", ValidationType.password.rawValue)
		return passwordCheck.evaluate(with: self)
	}
}
