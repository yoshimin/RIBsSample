//
//  SearchViewController.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/29.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa

protocol SearchPresentableListener: ItemListPresentableListener {
    func search(with keyword: String)
}

class SearchViewController: UITableViewController, SearchPresentable {
    weak var listener: SearchPresentableListener?

    private let searchController = UISearchController(searchResultsController: nil)
    private var items = BehaviorRelay<Items>(value: [])
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "検索"
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(ItemCell.nib, forCellReuseIdentifier: ItemCell.name)
        tableView.tableFooterView = UIView()
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        let searchButtonClicked = searchController.searchBar.rx.searchButtonClicked
            .withLatestFrom(searchController.searchBar.rx.text.orEmpty.asDriver())

        searchButtonClicked
            .subscribe(onNext: { text in
                self.listener?.search(with: text)
                self.searchController.isActive = false
                self.searchController.searchBar.text = nil
            })
            .disposed(by: disposeBag)

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

extension SearchViewController: ItemListViewControllable {}

extension Item: ItemCellModel {
    var userProfileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }

    var userId: String {
        return user.id
    }
}
