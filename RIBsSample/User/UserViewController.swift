//
//  UserViewController.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol UserPresentableListener: ItemListPresentableListener {
    
}

final class UserViewController: UITableViewController, UserPresentable {
    private let disposeBag = DisposeBag()
    private let user: User
    private let headerView = UserHeaderView.nib.instantiate(withOwner: nil, options: nil).first as! UserHeaderView
    
    weak var listener: UserPresentableListener?
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(ItemCell.nib, forCellReuseIdentifier: ItemCell.name)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        headerView.setup(with: user)
        
        listener?.items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: ItemCell.name, cellType: ItemCell.self)) { (_, item, cell) in
                cell.setup(with: item)
                cell.onTapProfileImage = { [weak self] in
                    self?.listener?.didSelectUser(item.user)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Item.self)
            .asDriver()
            .drive(onNext: { item in
                self.listener?.didSelectItem(item)
            })
            .disposed(by: disposeBag)
    }
}

extension UserViewController: ItemListViewControllable {}

extension User: UserHeaderViewModel {
    var imageURL: URL? {
        return URL(string: profileImageURL)
    }
}
