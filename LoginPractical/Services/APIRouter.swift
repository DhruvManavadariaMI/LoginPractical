//
//  APIRouter.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation
import Moya

enum APIRouter {
	case login(LoginModel)
}

extension APIRouter: TargetType {

	var baseURL: URL {
		return URL(string: "http://imaginato.mocklab.io")!
	}

	var path: String {
		switch self {
		case .login:
			return "/login"
		}
	}

	var method: Moya.Method {
		switch self {
		case .login:
			return .post
		}
	}

	var task: Moya.Task {
		switch self {
		case .login(let param) :
			return .requestParameters(parameters: param.toDictionary,
									  encoding: JSONEncoding.default)
		}
	}

	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}

	var sampleData: Data {
		return Data()
	}
}
