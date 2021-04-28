//
//  LoginViewModel.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {

	private let disposeBag = DisposeBag()


	// events
	private let email: BehaviorRelay<String> = BehaviorRelay(value: "")
	private let password: BehaviorRelay<String> = BehaviorRelay(value: "")

	// state

	private let showEmailError = BehaviorRelay<Bool>(value: false)
	private let showPasswordError = BehaviorRelay<Bool>(value: false)
	private let enableLoginButton = BehaviorRelay<Bool>(value: false)


	init() {
		bindState()
	}

	private func bindState() {

		Observable.combineLatest(email.asObservable(), password.asObservable())
			.map { (email, password) in
				email.isEmpty && password.isEmpty
			}
			.bind(to: enableLoginButton)
			.disposed(by: disposeBag)

		email.asObservable()
			.map {(email) in
				email.isEmpty
			}
			.bind(to: showEmailError)
			.disposed(by: disposeBag)

		password.asObservable()
			.map {(password) in
				password.isEmpty
			}
			.bind(to: showPasswordError)
			.disposed(by: disposeBag)

	}

	func onEmailChanged(_ value: String?) {
		self.email.accept(value ?? "")
	}

	func onPasswordChanged(_ value: String?) {
		self.password.accept(value ?? "")
	}

}
