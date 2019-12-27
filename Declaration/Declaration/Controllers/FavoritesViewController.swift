//
//  FavoritesViewController.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    // MARK: - properties
    
    private var favoritesList : [Person] = []
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setupTableViewStyle()
        loadfavoritesListFromUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadfavoritesListFromUserDefaults()
        setupTableViewStyle()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayNoResultsMessage(message: "No favorites \nPlease, add some person", in: favoritesList)
        return favoritesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PersonCell
        cell.delegate = self
        cell.person = favoritesList[indexPath.row]
        cell.indexCallback = { [unowned self] isFavorite in
            self.favoritesList[indexPath.row].isFavorite = isFavorite
            UserDefaultsService().savePerson(person: self.favoritesList[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.favoritesList[indexPath.row]
        showDialogAlert(with: person.comment)
        tableView.reloadData()
    }
    
    override func setupTableViewStyle() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
    }
    
    // MARK: - private
    
    private func registerCell() {
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(PersonCell.self)
    }
    
    private func loadfavoritesListFromUserDefaults() {
        favoritesList = UserDefaultsService().loadPerson().filter {$0.isFavorite == true}
    }
}

// MARK: - PersonCellDelegate

extension FavoritesViewController: PersonCellDelegate {
    
    func openUserDeclarationAction(link: String?) {
        guard let declarationLink = link else {
            self.showAlert(title: "Лінк на декларацію не знайдено")
            return
        }
        self.presentPDFController(link: declarationLink)
    }
}
