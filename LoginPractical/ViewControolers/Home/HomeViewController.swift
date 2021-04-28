//
//  HomeViewController.swift
//  LoginPractical
//
//  Created by mac-0004 on 28/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
	
	// MARK: - Varibles
	static func instantiate() -> HomeViewController? {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
	}
	private let disposeBag = DisposeBag()
	fileprivate var logOutButton: UIBarButtonItem!

	// MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
		initialization()
    }
}

// MARK:- General Methods -
extension HomeViewController {
	fileprivate func initialization() {
		self.title = StringConstant.home
		navigationItem.hidesBackButton = true
		addLogoutButton()
	}
	private func addLogoutButton() {
		logOutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: nil)
		navigationItem.rightBarButtonItem = logOutButton
		logOutButton.rx.tap
				  .subscribe(onNext: {
					UserDefaults.standard.setValue(false, forKey: UserDefaultKeys.isLogin)
				  }).disposed(by: disposeBag)
	}
}
