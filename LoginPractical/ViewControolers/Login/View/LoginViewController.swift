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
	static func instantiate() -> LoginViewController? {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
	}
	
	private let disposeBag = DisposeBag()
	private var viewModel: LoginViewModel!

	// MARK:- LifeCycle -
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
		bindViewModel()
		bindErrorMessageWithLabel()
	}
	
	private func bindErrorMessageWithLabel() {
		emailErrorLabel.text = ErrorMessage.email
		passwordErrorLabel.text = ErrorMessage.password
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
	
	private func bindViewModel() {

		viewModel.showEmailErrorObservable
			.takeUntil(rx.deallocating)
			.bind(to: emailErrorLabel.rx.isHidden)
			.disposed(by: disposeBag)

		viewModel.showPasswordErrorObservable
			.takeUntil(rx.deallocating)
			.bind(to: passwordErrorLabel.rx.isHidden)
			.disposed(by: disposeBag)

		viewModel.enableLoginButtonObservable
			.takeUntil(rx.deallocating)
			.subscribe(onNext: { [weak self] (enable) in
				self?.loginButton.isEnabled = enable
				self?.loginButton.alpha = enable ? 1: 0.2
			})
			.disposed(by: disposeBag)

		viewModel.showLoaderObservable
			.takeUntil(rx.deallocating)
			.subscribe(onNext: { [weak self] (loading) in
				guard let self = self else { return }
				loading ?
					self.activityIndicator.startAnimating() :
					self.activityIndicator.stopAnimating()
				self.view.isUserInteractionEnabled = !loading
			})
			.disposed(by: disposeBag)

		viewModel.showHomePageObservable
			.takeUntil(rx.deallocating)
			.subscribe(onNext: { [weak self] (homePage) in
				if homePage {
					self?.redirectToHome()
				}
			})
			.disposed(by: disposeBag)

		viewModel.showLoginErrorObservable
			.filter { (!($0 ?? "").isEmpty) }
			.takeUntil(rx.deallocating)
			.subscribe(onNext: { [weak self] (error) in
				guard let self = self else { return }
				UIAlertController
					.present(in: self, title: AlertConstant.Error, message: error)
					.subscribe(onNext: { buttonIndex in
					}).disposed(by: self.disposeBag)
			})
			.disposed(by: disposeBag)
	}
	
	private func redirectToHome() {
		UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.isLogin)
	}
	
	private func resignTextField() {
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
	}
}

// MARK:- Action Event -
extension LoginViewController {
	@IBAction private func loginButtonClicked() {
		resignTextField()
		viewModel.loginButttonTapped()
	}
}
