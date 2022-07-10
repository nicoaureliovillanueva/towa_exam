//
//  SignUpViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CDAlertView
import SkyFloatingLabelTextField

class SignUpViewController: BaseViewController {
    
    // MARK: Variable Declaration
    
    let viewModel = SignUpViewModel()
    
    let disposeBag = DisposeBag()
    
    var isUserError = true
    var isPasswordError = true
    
    // MARK: UI Declaration
    
    private lazy var username: SkyFloatingLabelTextFieldWithIcon = {
        let floatTextField = SkyFloatingLabelTextFieldWithIcon()
        floatTextField.placeholder = R.string.localizable.username_place_holder()
        floatTextField.title = R.string.localizable.username_place_holder()
        floatTextField.tintColor = R.color.main_accent_color() ?? .white
        floatTextField.textColor = R.color.accent_light_color() ?? .white
        floatTextField.font = FontManager.subTitle
        floatTextField.selectedTitleColor = R.color.main_accent_color() ?? .white
        floatTextField.selectedLineColor = R.color.main_accent_color() ?? .white
        floatTextField.errorColor = R.color.error_color() ?? .red
        
        // Set icon properties
        floatTextField.iconType = .font
        floatTextField.iconColor = R.color.accent_light_color() ?? .white
        floatTextField.selectedIconColor =  R.color.main_accent_color() ?? .white
        floatTextField.iconFont = UIFont(name: "FontAwesome5Free-Solid", size: 16)
        floatTextField.iconText = "\u{f007}"
        floatTextField.iconMarginBottom = 4.0
        floatTextField.iconMarginLeft = 8.0
        
        
        return floatTextField
    }()
    
    
    private lazy var password: SkyFloatingLabelTextFieldWithIcon = {
        let floatTextField = SkyFloatingLabelTextFieldWithIcon()
        floatTextField.placeholder = R.string.localizable.password_place_holder()
        floatTextField.title = R.string.localizable.password_place_holder()
        floatTextField.isSecureTextEntry = true
        floatTextField.tintColor = R.color.main_accent_color() ?? .white
        floatTextField.textColor = R.color.accent_light_color() ?? .white
        floatTextField.font = FontManager.subTitle
        floatTextField.selectedTitleColor = R.color.main_accent_color() ?? .white
        floatTextField.selectedLineColor = R.color.main_accent_color() ?? .white
        floatTextField.errorColor = R.color.error_color() ?? .red

        
        // Set icon properties
        floatTextField.iconType = .font
        floatTextField.iconColor = R.color.accent_light_color() ?? .white
        floatTextField.selectedIconColor =  R.color.main_accent_color() ?? .white
        floatTextField.iconFont = UIFont(name: "FontAwesome5Free-Solid", size: 16)
        floatTextField.iconText = "\u{f023}"
        floatTextField.iconMarginBottom = 4.0
        floatTextField.iconMarginLeft = 8.0
        
        
        return floatTextField
    }()
    
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.create_account_button_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.xxxLargeTitle
        
        return label
    }()
    
    private lazy var signUpDetail: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.signup_sub_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.subTitle
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
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureBindings()
        
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.4
    }
    
    
    // MARK: Private fuction for UI Configuration and Bindings
    
    private func configureUI() {
        
        self.view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.leading.trailing.equalTo(40)
        }
        
        self.view.addSubview(signUpDetail)
        signUpDetail.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(42)
            
        }
        
        self.view.addSubview(username)
        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpDetail.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }

        self.view.addSubview(password)
        password.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(username.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }

        self.view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func configureBindings() {
        
        self.signUpButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.proceedToHomeScreen()
            }).disposed(by: disposeBag)
        
        self.username.rx.controlEvent([.editingChanged, .editingDidEnd])
            .withLatestFrom(username.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.validateChar(text: text)
            }).disposed(by: disposeBag)
        
        
        self.password.rx.controlEvent([.editingChanged, .editingDidEnd])
            .withLatestFrom(password.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.passwordValidateChar(password: text)
            }).disposed(by: disposeBag)
        
        self.viewModel.isUserNameInvalid
            .asDriver()
            .drive(onNext: { error in
                print("<=== Still have username error \(error)")
                self.isUserError = error
                self.configureSignUpState()
            })
            .disposed(by: disposeBag)
        
        self.viewModel.isPasswordInvalid
            .asDriver()
            .drive(onNext: { error in
                print("<=== Still have password error \(error)")
                self.isPasswordError = error
                self.configureSignUpState()
            })
            .disposed(by: disposeBag)
    }
    
    private func validateChar(text: String) {
        self.username.errorMessage = self.viewModel.usernameValidationMessage(characterCount: text.count)
    }
    
    private func passwordValidateChar(password: String) {
        self.password.errorMessage = self.viewModel.passwordValidateMessage(password: password)
    }
    
    private func configureSignUpState() {
        self.signUpButton.isEnabled = !self.isUserError && !self.isPasswordError && self.checkEmptyField()
        self.signUpButton.alpha = self.signUpButton.isEnabled ? 1.0 : 0.4
    }
    
    private func checkEmptyField()-> Bool {
        return viewModel.isCanProceed(username: username.text ?? "",
                                      password: password.text ?? "")
    }
    
    private func proceedToHomeScreen() {
        
        if viewModel.validateRegisteredUser(username: username.text ?? "") {
            let alert = CDAlertView(title: R.string.localizable.signup_error_title(),
                                    message: R.string.localizable.signup_error_message(), type: .error)
            
            let doneAction = CDAlertViewAction(title: R.string.localizable.ok_button_title())
            
            alert.add(action: doneAction)
            
            alert.show()
        }else {
            viewModel.saveUserCredential(username: username.text ?? "", password: password.text ?? "")
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
        
    }
}


