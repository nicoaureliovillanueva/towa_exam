//
//  UserListCell.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/8/22.
//

import Foundation
import UIKit
import SnapKit


class UserListCell: UITableViewCell {
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.light_highlight_color()
        view.layer.cornerRadius = 10
        return view
        
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.userlist_placeholder()
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.subTitle
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.smallText
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.smallText
        return label
    }()
    
    let detailsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.info_icon()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = R.color.main_background()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class CustomTableViewCell: UITableViewCell {
        override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                var frame = newFrame
                frame.origin.x += 20
                super.frame = frame
            }
        }
    }
    
    private func configureUI() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        containerView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerView).inset(10)
            make.left.equalTo(10)
            make.width.equalTo(userImageView.snp.height)
        }
        
        containerView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(10)
            make.left.equalTo(userImageView.snp.right).offset(10)
            
        }
        
        containerView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(3)
            make.left.equalTo(userImageView.snp.right).offset(10)
            
        }
        
        containerView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(3)
            make.left.equalTo(userImageView.snp.right).offset(10)
            
        }
        
        containerView.addSubview(detailsIcon)
        detailsIcon.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.right.equalTo(containerView.snp.right).inset(20)
            make.centerY.equalTo(containerView)
            
        }
        
        
    }
    
}
