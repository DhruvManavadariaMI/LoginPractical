//
//  Extension+UserDefaults.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation
import UIKit

extension UserDefaults {

	var user: User? {
		get {
			guard let user = UserDefaults.standard.object(forKey: UserDefaultKeys.user) as? [String:Any] else { return nil }
			return User(user)
		}
		set {
			UserDefaults.standard.set(newValue?.toDictionary, forKey: UserDefaultKeys.user)
		}
	}
	
	func removeUserData() {
		UserDefaults.standard.removeObject(forKey: UserDefaultKeys.user)
		UserDefaults.standard.synchronize()
	}
}
