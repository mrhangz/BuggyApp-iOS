//
//  FirstViewController.swift
//  BuggyApp
//
//  Created by Teerawat Vanasapdamrong on 28/6/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import UIKit
import Kingfisher

class FirstViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  
  var countries: [Country]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getCountries()
  }
  
  func getCountries() {
    APIManager.shared.getCountries() { [weak self] result in
      switch result {
      case .success(let countries):
        self?.countries = countries
        self?.tableView.reloadData()
      case .failure(let error):
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self?.present(alert, animated: true)
      }
    }
  }
}

extension FirstViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CurrencyCell
    if let country = countries?[indexPath.row] {
      cell.nameLabel.text = country.name
      cell.capitalLabel.text = "Capital: \(country.capital)"
      cell.flagImageView.kf.setImage(with: URL(string: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"))
    }
    return cell
  }
}

extension FirstViewController: UITableViewDelegate {
  
}
