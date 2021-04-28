//
//  StringContants.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation

struct AlertConstant {
	static let OK = "OK"
	static let Error = "Error"
}

struct ErrorMessage {
	static let email = "This is a invalid email."
	static let password = "Password require at least 1 uppercase, 1 lowercase, 1 number and should be at least 8 characters."
}

enum ValidationType: String {
	case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	case password = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$"
}

struct UserDefaultKeys {
	static let user = "User"
}
