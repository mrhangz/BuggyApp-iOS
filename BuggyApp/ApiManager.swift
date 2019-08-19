//
//  ApiManager.swift
//  BuggyApp
//
//  Created by Teerawat Vanasapdamrong on 28/6/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
  func getCountries(completion: @escaping (Swift.Result<[Country], Error>) -> Void)
  func getArtistInfo(artistName: String, completion: @escaping (Swift.Result<[Track], Error>) -> Void)
}

class APIManager: APIManagerProtocol {
  let baseURL: String = "https://restcountries.eu/rest/v2"
  static let shared: APIManager = APIManager()
  
  func getCountries(completion: @escaping (Swift.Result<[Country], Error>) -> Void) {
    Alamofire.request("\(baseURL)/all")
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success:
          do {
            let countries = try JSONDecoder().decode([Country].self, from: response.data!)
            completion(.success(countries))
          } catch (let error) {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
  
  func getArtistInfo(artistName: String, completion: @escaping (Swift.Result<[Track], Error>) -> Void) {
    let baseURL: String = "http://54.251.183.191:3000/songlist"
    Alamofire.request(baseURL)
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success:
          do {
            let json = try JSON(data: response.data!)
            var tracks: [Track] = json["results"].arrayValue.flatMap({ Track(json: $0) })
            completion(.success(tracks))
          } catch (let error) {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
}
