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

protocol SearchPresentableListener: class {
    func search(with keyword: String) -> Single<Items>
    func didSelectItem(_ item: Item)
    func didSelectUser(_ user: User)
}

class SearchViewController: UITableViewController, SearchPresentable {
    weak var listener: SearchPresentableListener?

    private let searchController = UISearchController(searchResultsController: nil)
    private var items = BehaviorRelay<Items>(value: [])
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil

        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        let searchButtonClicked = searchController.searchBar.rx.searchButtonClicked
            .withLatestFrom(searchController.searchBar.rx.text.orEmpty.asDriver())

        searchButtonClicked
            .flatMap{ [weak self] text -> Single<Items> in
                guard let listener = self?.listener else { return .just([]) }
                return listener.search(with: text)
            }
            .catchError{ error -> Observable<[Item]> in
                print(error.localizedDescription)
                return .just([])
            }
            .bind(to: items)
            .disposed(by: disposeBag)

        searchButtonClicked
            .subscribe(onNext: { _ in
                self.searchController.isActive = false
                self.searchController.searchBar.text = nil
            })
            .disposed(by: disposeBag)

        items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: ItemCell.self)) { (_, item, cell) in
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

extension SearchViewController: SearchViewControllable {
    func present(view: ViewControllable) {
        navigationController?.pushViewController(view.uiviewController, animated: true)
    }
}

extension Item: ItemCellModel {
    var userProfileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }

    var userId: String {
        return user.id
    }
}
