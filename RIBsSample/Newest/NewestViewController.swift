//
//  NewestViewController.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol NewestPresentableListener: ItemListPresentableListener {
    func didTapSearchButton()
}

final class NewestViewController: UITableViewController, NewestPresentable {
    private let disposeBag = DisposeBag()
    private let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    
    weak var listener: NewestPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新着"
        navigationItem.rightBarButtonItem = searchButton
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTapSearchButton()
            })
            .disposed(by: disposeBag)
        
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(ItemCell.nib, forCellReuseIdentifier: ItemCell.name)
        
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

extension NewestViewController: ItemListViewControllable {}
