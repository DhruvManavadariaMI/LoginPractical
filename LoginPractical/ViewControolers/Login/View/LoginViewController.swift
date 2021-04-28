//
//  LoginViewController.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
	
	//MARK:- IBOutlets
	@IBOutlet private weak var emailTextField: UITextField!
	@IBOutlet private weak var emailErrorLabel: UILabel!
	@IBOutlet private weak var passwordTextField: UITextField!
	@IBOutlet private weak var passwordErrorLabel: UILabel!
	@IBOutlet private weak var loginButton: UIButton!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK:- Global Variables -
	private let disposeBag = DisposeBag()
	private var viewModel: LoginViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		initialization()
	}
}

// MARK:- General Methods -
extension LoginViewController {
	fileprivate func initialization() {
		self.viewModel = LoginViewModel()
		bindTextFields()
	}
	
	private func bindTextFields() {
		emailTextField.rx.text
			.asObservable()
			.subscribe(onNext: { [weak self] (text) in
				self?.viewModel.onEmailChanged(text)
			})
			.disposed(by: disposeBag)

		passwordTextField.rx.text
			.asObservable()
			.subscribe(onNext: { [weak self] (text) in
				self?.viewModel.onPasswordChanged(text)
			})
			.disposed(by: disposeBag)
	}
}
