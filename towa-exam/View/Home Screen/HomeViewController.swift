//
//  HomeViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import KeychainSwift

class HomeViewController: BaseViewController {
    
    // MARK: Variable Declaration
    
    let viewModel = HomeViewModel(apiService: request)
    
    let disposeBag = DisposeBag()
    
    let keychain = KeychainSwift()
    
    // MARK: UI Declaration
    
    private lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.main_background()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.home_screen_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.xxxLargeTitle
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.home_screen_sub_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.subTitle
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBindings()
        viewModel.getUserList()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    // MARK: Private fuction for UI Configuration and Bindings
    
    private func configureUI() {
        
        /** Register TableViewCell **/
        
        userTableView.register(UserListCell.self, forCellReuseIdentifier: "Cell")

        /** Setup UI Constraints **/
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalTo(20)
        }
        
        self.view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(22)
            
        }
        
        self.view.addSubview(userTableView)
        userTableView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    
    private func configureBindings() {
        
        viewModel.userListRelay
            .bind(to: userTableView.rx.items(cellIdentifier: "Cell", cellType: UserListCell.self)) { (row, data, cell) in
                cell.selectionStyle = .none
                cell.usernameLabel.text = data?.name
                cell.emailLabel.text = "Email: \(data?.email ?? "")"
                cell.cityLabel.text = "City: \(data?.address.city ?? "")"
            }
            .disposed(by: disposeBag)
        
        
        userTableView.rx.modelSelected(User.self)
            .subscribe(onNext: { user in
                let detailsViewController = UserDetailsViewController()
                detailsViewController.viewModel.userDataRelay.accept(user)
                self.showUserDetails(view: detailsViewController)
            })
            .disposed(by: disposeBag)
        
        userTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func showUserDetails(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
}


// MARK: TableView Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
