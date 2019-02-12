//
//  ItemViewController.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/07.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import UIKit
import Kingfisher
import MarkdownView
import RxSwift
import RxCocoa
import WebKit

class ItemHeaderView: UIView {
    @IBOutlet private var userProfileImageView: UIImageView!
    @IBOutlet private var userIdLabel: UILabel!
    @IBOutlet private var createdAtLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!

    func setup(with item: Item) {
        userProfileImageView.kf.setImage(with: item.userProfileImageURL)
        userIdLabel.text = "@" + item.user.id
        createdAtLabel.text = StandardDateFormatter(dateFormat: .dateTime).string(item.createdAt)
        titleLabel.text = item.title
    }
}

class ItemViewController: UIViewController, ItemViewControllable {
    @IBOutlet private var markdownView: MarkdownView!
    @IBOutlet private var indicator: UIActivityIndicatorView!

    private var observation: NSKeyValueObservation?

    private let disposeBag = DisposeBag()
    var item: Item?

    override func viewDidLoad() {
        setup()
    }

    func setup() {
        let nib = UINib(nibName: "ItemHeaderView", bundle: nil)

        guard let item = item,
            let headerView = nib.instantiate(withOwner: self, options: nil).first as? ItemHeaderView else { return }

        headerView.setup(with: item)

        markdownView.load(markdown: item.body)

        guard let scrollView = markdownView.webview?.scrollView else { return }

        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -headerView.frame.height),
            headerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            headerView.widthAnchor.constraint(equalTo: markdownView.widthAnchor)
            ])

        scrollView.contentInset = UIEdgeInsets(top: headerView.frame.height, left: 0, bottom: 0, right: 0)
    }
}

private extension MarkdownView {
    var webview: WKWebView? {
        return subviews.first(where: { $0 is WKWebView }) as? WKWebView
    }
}
