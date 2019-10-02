//
//  UserCell.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Reusable
import Then
import SDWebImage

final class UserCell: UITableViewCell, NibReusable {
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCell()
    }
    
    private func configCell() {
        avataImageView.do {
            $0.layer.cornerRadius = avataImageView.frame.width / 2
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.red.withAlphaComponent(0.6).cgColor
        }
    }
    
    func setContentForCell(_ user: User) {
        avataImageView.sd_setImage(with: URL(string: user.avatarUrl))
        nameLabel.text = "User name: \(user.name)"
        userTypeLabel.text = "Account type: \(user.type)"
    }
    
}
