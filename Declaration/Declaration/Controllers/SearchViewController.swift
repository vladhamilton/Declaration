//
//  SearchViewController.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit
import Reachability

class SearchViewController: BaseViewController {
    
    // MARK: - properties
    
    private var timer: Timer?
    private var searchText: String?
    private var networkService = NetworkService()
    private var personList = [Person]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        registerCell()
        setupTableViewStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayNoResultsMessage(message: "No results \nPlease, start searching", in: personList)
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PersonCell
        cell.delegate = self
        cell.delegateComment = self
        cell.person = personList[indexPath.row]
        cell.indexCallback = { [unowned self] isFavorite in
            self.personList[indexPath.row].isFavorite = isFavorite
            UserDefaultsService().savePerson(person: self.personList[indexPath.row])
        }
        return cell
    }
    
    // MARK: - private
    
    private func registerCell() {
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(PersonCell.self)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = #colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    private func noInternetBehaviour() {
        showAlert(title: CustomError.noConnection.message)
        showActivityIndicator(false)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.searchText = searchText
        
        guard let reachability = try? Reachability() else {
            return
        }
        
        switch reachability.connection {
        case .none:
            noInternetBehaviour()
        default:
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                self.tableView.restore()
                self.showActivityIndicator(true)
                self.networkService.fetchPersons(searchText: searchText) { [weak self] (searchResults) in
                    self?.personList = searchResults?.items ?? []
                    self?.showActivityIndicator(false)
                    self?.tableView.reloadData()
                }
            })
            self.showActivityIndicator(false)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchController.searchBar.text = self.searchText
    }
}

// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        self.searchController.searchBar.text = self.searchText
    }
}

// MARK: - PersonCellDelegate

extension SearchViewController: PersonCellDelegate {
    
    func openUserDeclarationAction(link: String?) {
        guard let declarationLink = link else {
            self.showAlert(title: "Лінк на декларацію не знайдено")
            return
        }
        self.presentPDFController(link: declarationLink)
    }
}

// MARK: - PersonCellCommentDelegate

extension SearchViewController: PersonCellCommentDelegate {
    
    func showCommentAlert() {
        self.showDialogAlert(with: nil)
    }
}
