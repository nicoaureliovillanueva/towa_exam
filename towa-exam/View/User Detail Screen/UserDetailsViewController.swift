//
//  UserDetailsViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/6/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CDAlertView

class UserDetailsViewController: BaseViewController {
    
    // MARK: Variable Declaration
    
    var viewModel = UserDetailsViewModel()
    
    let disposeBag = DisposeBag()
    
    let distanceView = DistanceScreenViewController()
    
    // MARK: UI Declaration
    
    private lazy var userProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.userlist_placeholder()
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.accent_light_color()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.color.main_background()
        label.font = FontManager.title
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.color.main_background()
        label.font = FontManager.regular
        return label
    }()
    
    private lazy var phonelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.main_background()
        label.font = FontManager.regular
        return label
    }()
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.main_background()
        label.font = FontManager.regular
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.main_background()
        label.font = FontManager.regular
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.main_background()
        label.font = FontManager.regular
        return label
    }()
    
    private lazy var checkDistance: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.check_distance_title(),
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\u{f2f5}", style: .plain, target: self, action: #selector(logout))
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "FontAwesome5Free-Solid", size: 20)!,
            NSAttributedString.Key.foregroundColor : R.color.accent_light_color() ?? .white
        ], for: .normal)

    }
    
    // MARK: Private fuction for UI Configuration and Bindings
    
    private func configureUI() {
        
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        containerView.addSubview(userProfile)
        userProfile.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.width.height.equalTo(100)
            make.top.equalTo(containerView.snp.top).inset(-50)

        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(userProfile.snp.bottom).offset(10)
        }
        
        containerView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        containerView.addSubview(phonelabel)
        phonelabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.left.equalTo(containerView.snp.left).inset(40)
        }
        
        containerView.addSubview(websiteLabel)
        websiteLabel.snp.makeConstraints { make in
            make.top.equalTo(phonelabel.snp.bottom).offset(10)
            make.left.equalTo(containerView.snp.left).inset(40)
        }
        
        containerView.addSubview(companyLabel)
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(websiteLabel.snp.bottom).offset(10)
            make.left.equalTo(containerView.snp.left).inset(40)
        }
        
        containerView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom).offset(10)
            make.left.equalTo(containerView.snp.left).inset(40)
        }
        
        containerView.addSubview(checkDistance)
        checkDistance.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(containerView.snp.bottom).inset(20)
        }
        
    }
    
    private func configureBindings() {
        self.viewModel.userDataRelay
            .asDriver()
            .drive(onNext: { user in
                self.nameLabel.text = user?.name
                self.emailLabel.text = user?.email
                self.phonelabel.text = "Phone:\n\(user?.phone ?? "")"
                self.websiteLabel.text = "Website:\n\(user?.website ?? "")"
                self.companyLabel.text = "Company:\n\(user?.company.name ?? "")"
                self.locationLabel.text = "Location:\n\(user?.address.city ?? "")"
            })
            .disposed(by: disposeBag)
        
        checkDistance.rx.tap
            .bind(onNext: { [weak self] in
                self?.showDistance(view: self!.distanceView)
            })
            .disposed(by: disposeBag)
        
        viewModel.userDataRelay
            .asDriver()
            .drive(onNext: { user in
                self.distanceView.viewModel.userDataLocationRelay.accept(user)
            })
            .disposed(by: disposeBag)
    }
    
    private func showDistance(view: UIViewController) {
        self.present(view, animated: true, completion: nil)
    }
    
    private func returnToOnboardingScreen(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func logout() {
        let alert = CDAlertView(title: R.string.localizable.warning_title(),
                                message: R.string.localizable.logout_warning_message(),
                                type: .notification)
        let doneAction = CDAlertViewAction(title: R.string.localizable.ok_button_title(),
                                           font: nil,
                                           textColor: nil,
                                           backgroundColor: nil,
                                           handler: { action in
            self.viewModel.clearUserData()
            self.returnToOnboardingScreen()
            return true
        })
        doneAction.buttonTextColor = .systemBlue
        alert.add(action: doneAction)
        let cancelAction = CDAlertViewAction(title: R.string.localizable.cancel_title())
        cancelAction.buttonTextColor = .systemBlue
        alert.add(action: cancelAction)
        alert.show()
    }
}
