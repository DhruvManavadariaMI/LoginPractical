//
//  ServiceProvider.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol ServiceProviderProtocol : class {
	func doLogin(_ router: APIRouter) -> Observable<LoginResponse>
}

private let provider = MoyaProvider<APIRouter>()
final class AuthServices: ServiceProviderProtocol {

	private let disposeBag = DisposeBag()

	func doLogin(_ router: APIRouter) -> Observable<LoginResponse> {
		return Observable.create { observer in
			let _ = provider.rx.request(router)
				.asObservable()
				.subscribe { (response) in
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
					let output = try? decoder.decode(LoginResponse.self, from: response.data)
					observer.onNext(output ?? LoginResponse())
					observer.onCompleted()
				} onError: { (error) in
					observer.onError(error)
				}
				.disposed(by: self.disposeBag)
			return Disposables.create()
		}
	}

	// De-init
	deinit {
		print("\(self) dealloc")
	}
}

