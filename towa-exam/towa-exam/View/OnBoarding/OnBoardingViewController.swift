//
//  OnBoardingViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OnBoardingViewController: BaseViewController {
    
    // MARK: Variable Declaration
    
    let viewModel = OnBoardingViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: UI Declaration
    
    private lazy var appLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.appLogo()
        return imageView
    }()
    
    private lazy var appTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.app_title_main()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.extraLarge
        
        return label
    }()
    
    private lazy var appDescription: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.app_sub_title_main()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.titleNormal
        return label
    }()
    
    private lazy var devDetailLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.developer_email()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.smallText
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.sign_up_button_title(),
                        for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = R.color.main_accent_color()
        button.setTitleColor(R.color.accent_light_color(), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.login_button_title(),
                        for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = R.color.accent_light_color()?.cgColor
        button.setTitleColor(R.color.accent_light_color(), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBindings()
        checkAppState()
    }
    
    // MARK: Private fuction for UI Configuration and Bindings
    
    private func configureUI() {
        self.view.addSubview(appLogo)
        appLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(280)
            make.height.equalTo(250)
        }
        
        self.view.addSubview(appTitle)
        appTitle.snp.makeConstraints { make in
            make.top.equalTo(appLogo.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.view.addSubview(appDescription)
        appDescription.snp.makeConstraints { make in
            make.top.equalTo(appTitle.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(50)
            
        }
        
        self.view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(appDescription.snp.bottom).offset(30)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }

        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(14)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(devDetailLabel)
        devDetailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(10)
            
        }
        
        
    }
    
    private func configureBindings() {
        self.loginButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.redirectScreen(viewController: LoginViewController())
            }).disposed(by: disposeBag)
        
        self.signUpButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.redirectScreen(viewController: SignUpViewController())
            }).disposed(by: disposeBag)
    }
    
    private func redirectScreen(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    private func checkAppState() {
        if session.appState {
            self.redirectScreen(viewController: HomeViewController())
        }
        
    }
}
