//
//  LoginModel.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation

public struct LoginModel {

	let email: String
	let password: String

	var toDictionary: [String:Any] {
		return ["email": email, "password": password]
	}
}
