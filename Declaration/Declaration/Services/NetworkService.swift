//
//  NetworkService.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import Alamofire
import UIKit

class NetworkService {
   
   func fetchPersons(searchText: String, completion: @escaping  (SearchResponse?) -> Void) {
       let baseURL = "https://public-api.nazk.gov.ua/v1/declaration/?q="
       let urlPath = searchText
       let escapedPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
       guard let url = URL(string: "\(baseURL)\(escapedPath!)") else { return }
       print(url)
       
       Alamofire.request(url).responseData { (dataResponse) in
           if let error = dataResponse.error {
               print(error.localizedDescription)
               completion(nil)
               return
           }
           guard let data = dataResponse.data else { return }
           let decoder = JSONDecoder()
           do {
               let objects = try decoder.decode(SearchResponse.self, from: data)
               print("Objects: ", objects)
               completion(objects)
           } catch let jsonError {
               print("Failed to decode JSON:", jsonError)
               completion(nil)
           }
       }
   }
}
