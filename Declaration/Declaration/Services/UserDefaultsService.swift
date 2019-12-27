//
//  UserDefaultsService.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class UserDefaultsService {
    
    enum UserDefaultsKey: String {
        case favorites
    }
    
    // MARK: - properties
    
    private let defaults = UserDefaults.standard
    
    // MARK: - public
    
    func savePerson(person: Person) {
        
        var array = loadPerson()
        array.append(person)
        
        for element in array {
            if element.id == person.id {
                guard let index = array.firstIndex(of: element) else { return }
                array.remove(at: index)
            }
        }
        
        if person.isFavorite == true {
            array.append(person)
        } else {
            array.removeAll(where: { $0.isFavorite == false })
        }
        array = array.uniques
        
        print("""
            __________________________
            
            \(array)
            
            __________________________
            
            saved
            
            __________________________
            """)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            defaults.set(encoded, forKey: UserDefaultsKey.favorites.rawValue)
            defaults.synchronize()
        }
    }
    
    func loadPerson() -> [Person] {
        var personList: [Person] = []
        if let savedPerson = defaults.object(forKey: UserDefaultsKey.favorites.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let loadedPersonList = try? decoder.decode([Person].self, from: savedPerson) {
                personList = loadedPersonList.uniques
            } else {
                personList = []
            }
        }
        print("""
            __________________________
            
            \(personList)
            
            __________________________
            
            loaded
            
            __________________________
            """)
        return personList
    }
}
