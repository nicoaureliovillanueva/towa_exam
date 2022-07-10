//
//  LoginViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import KeychainSwift
import CDAlertView
import SkyFloatingLabelTextField

class LoginViewController: BaseViewController {
    
    // MARK: Variable Declaration
    
    let viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    let keychain = KeychainSwift()
    
    // MARK: UI Declaration
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.login_button_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.xxxLargeTitle
        
        return label
    }()
    
    private lazy var signUpDetail: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.login_sub_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.subTitle
        return label
    }()
    
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
    
    private lazy var rememberUserButton: UIButton = {
        let button = UIButton(type: .custom)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(R.image.uncheck_icon(), for: .normal)
        return button
    }()
    
    private lazy var rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember Me"
        label.font = FontManager.regular
        label.textColor = R.color.accent_light_color()
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.login_button_title(),
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
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.4
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
        
        self.view.addSubview(rememberUserButton)
        rememberUserButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.top.equalTo(password.snp.bottom).offset(25)
            make.width.height.equalTo(18)
        }
        
        self.view.addSubview(rememberMeLabel)
        rememberMeLabel.snp.makeConstraints { make in
            make.left.equalTo(rememberUserButton.snp.right).offset(10)
            make.top.equalTo(password.snp.bottom).offset(22)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(rememberMeLabel.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    private func configureBindings() {
        self.loginButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.proceedToLogin()
            }).disposed(by: disposeBag)
        
        self.rememberUserButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.rememberState()
            }).disposed(by: disposeBag)
        
        
        self.username.rx.controlEvent([.editingChanged, .editingDidEnd])
            .withLatestFrom(username.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] _ in
                self?.validateInput()
            }).disposed(by: disposeBag)
        
        self.password.rx.controlEvent([.editingChanged, .editingDidEnd])
            .withLatestFrom(password.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] _ in
                self?.validateInput()
            }).disposed(by: disposeBag)
    }
    
    private func validateInput() {
        loginButton.isEnabled = viewModel.validateCompletedField(username: self.username.text ?? "",
                                                                 password: self.password.text ?? "")
        
        loginButton.alpha = loginButton.isEnabled ? 1.0 : 0.4
    }
    
    private func proceedToLogin() {
        if self.viewModel.validateUserCrendential(username: self.username.text ?? "",
                                             password: self.password.text ?? "") {
            
            self.viewModel.saveUserCredential(isRememberState: rememberUserButton.isSelected)
            
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        } else {
            let alert = CDAlertView(title: R.string.localizable.login_error_title(),
                                    message: R.string.localizable.login_error_message(),
                                    type: .error)
            let doneAction = CDAlertViewAction(title: R.string.localizable.ok_button_title())
            alert.add(action: doneAction)
            alert.show()
        }
    }
    
    private func rememberState() {
        rememberUserButton.isSelected.toggle()
        
        rememberUserButton.isSelected ? setRemeberMeImage(image: R.image.check_icon()) : setRemeberMeImage(image: R.image.uncheck_icon())
        
    }
    
    private func setRemeberMeImage(image: UIImage?) {
        rememberUserButton.setImage(image, for: .normal)
    }
}
