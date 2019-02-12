//
//  ItemCell.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/01.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import UIKit
import Kingfisher

protocol ItemCellModel {
    var title: String { get }
    var userProfileImageURL: URL? { get }
    var userId: String { get }
    var createdAt: Date { get }
}

class ItemCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userIdLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!

    final var onTapProfileImage: (() -> Void)?

    func setup(with model: ItemCellModel) {
        titleLabel.text = model.title
        userProfileImageView.kf.setImage(with: model.userProfileImageURL)
        userIdLabel.text = model.userId
        createdAtLabel.text = StandardDateFormatter(dateFormat: .dateTime).string(model.createdAt)
    }

    @IBAction func touchUpProfileImageView() {
        onTapProfileImage?()
    }
}
