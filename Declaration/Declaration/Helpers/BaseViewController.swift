//
//  BaseViewController.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    // MARK: - properties
    
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - public
    
    func showActivityIndicator(_ isShow: Bool) {
        if isShow {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            activityIndicator.style = .medium
            activityIndicator.center.x = self.view.center.x
            activityIndicator.center.y = self.view.center.y - 70
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    func showAlert(title: String = "") {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showDialogAlert(with text: String?) {
        guard var person = UserDefaultsService().loadPerson().last else { return }
        let alert = UIAlertController(title: "Please, add some comments", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your comment here..."
            let updatedText = person.comment
            textField.text = updatedText
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let comment = alert.textFields?.first?.text {
                person.comment = comment
                person.isFavorite = true
                UserDefaultsService().savePerson(person: person)
                print("Your comment: \(comment)")
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    func presentPDFController(link: String?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PDFController") as! PDFController
        controller.link = link
        self.present(controller, animated: true, completion: nil)
    }
    
    func setupTableViewStyle() {
        tableView.tableViewWithoutSelectionAndFooterView()
    }
    
    func displayNoResultsMessage(message: String, in array: [Person?]) {
        if array.count == 0 {
            self.tableView.setEmptyMessage(message)
        } else {
            self.tableView.restore()
        }
    }
}

