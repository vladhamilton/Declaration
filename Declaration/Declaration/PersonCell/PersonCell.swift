//
//  PersonCell.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

// MARK: - protocols

protocol PersonCellDelegate: class {
    func openUserDeclarationAction(link: String?)
}
protocol PersonCellCommentDelegate: class {
    func showCommentAlert()
}

class PersonCell: UITableViewCell {
    
    // MARK: - properties
    
    var indexCallback: ((_ isFavorite: Bool) -> Void)?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var placeOfWorkLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var favoritesButton: ToggleButton!
    
    var person: Person? {
        didSet {
            guard let person = person else { return }
            nameLabel.text = "\(person.lastname) \(person.firstname)".capitalized
            placeOfWorkLabel.text = person.placeOfWork.capitalizingFirstLetter()
            positionLabel.text = person.position?.capitalizingFirstLetter()
            if positionLabel.text == "Ні" {
                positionLabel.text = "Посада не вказана"
            }
            favoritesButton.setImage(#imageLiteral(resourceName: "Star"), for: .normal)
            if let isFavorite = person.isFavorite {
                favoritesButton.activateButton(bool: isFavorite)
            }
        }
    }
    
    weak var delegate: PersonCellDelegate?
    weak var delegateComment: PersonCellCommentDelegate?
    
    // MARK: - override
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - actions
    
    @IBAction private func profileButtonPressed(_ sender: Any) {
        delegate?.openUserDeclarationAction(link: person?.linkPDF)
        print("profileButtonPressed")
    }
    @IBAction private func favoritesButtonPressed(_ sender: Any) {
        self.indexCallback?(favoritesButton.isOn)
        delegateComment?.showCommentAlert()
        print("favoritesButtonPressed")
    }
}
