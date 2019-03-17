//
//  UserCell.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import UIKit

protocol UserHeaderViewModel {
    var id: String { get }
    var itemsCount: Int { get }
    var followersCount: Int { get }
    var imageURL: URL? { get }
}

class UserHeaderView: UIView {
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var itemsCountLabel: UILabel!
    @IBOutlet var followersCountLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    func setup(with model: UserHeaderViewModel) {
        idLabel.text = model.id
        itemsCountLabel.text = String(model.itemsCount)
        followersCountLabel.text = String(model.followersCount)
        profileImageView.kf.setImage(with: model.imageURL)
    }
}
