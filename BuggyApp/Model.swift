//
//  Model.swift
//  BuggyApp
//
//  Created by Teerawat Vanasapdamrong on 28/6/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Country: Codable {
  let name: String
  let alpha2Code: String
  let capital: String
  let population: Int64
  let latlng: [Double]
  let currencies: [Currency]
  let languages: [Language]
  let flag: String
}

struct Currency: Codable {
  let code: String?
  let name: String?
  let symbol: String?
}

struct Language: Codable {
  let name: String
  let nativeName: String
}

struct Track {
  let artistId : Int
  let artistName: String
  let collectionName: String
  let trackName: String
  let artworkUrl: String
  let collectionPrice: Double
  let trackPrice: Double
  let releaseDate: String
  let trackTimeMillis: Int
  let country: String
  let currency: String
  let primaryGenreName: String
}

extension Track {
  init(json: JSON) {
    artistId = json["artistId"].intValue
    artistName = json["artistName"].stringValue
    collectionName = json["collectionName"].stringValue
    trackName = json["trackName"].stringValue
    artworkUrl = json["artworkUrl100"].stringValue
    collectionPrice = json["collectionPrice"].doubleValue
    trackPrice = json["trackPrice"].doubleValue
    releaseDate = json["releaseDate"].stringValue
    trackTimeMillis = json["trackTimeMillis"].intValue
    country = json["country"].stringValue
    currency = json["currency"].stringValue
    primaryGenreName = json["primaryGenreName"].stringValue
  }
}
