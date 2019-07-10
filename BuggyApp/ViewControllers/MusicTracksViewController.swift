//
//  SecondViewController.swift
//  BuggyApp
//
//  Created by Teerawat Vanasapdamrong on 28/6/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import UIKit

class MusicTracksViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var tracks: [Track] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    tableView.estimatedRowHeight = CGFloat(140.0)
    
    APIManager.shared.getArtistInfo(artistName: "taylorswift") { [weak self] result in
      switch result {
      case .success(let tracks):
        self?.tracks = tracks
      case .failure(let error):
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(dismissAction)
        self?.present(alert, animated: true)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail",
      let viewController = segue.destination as? MusicTrackDetailViewController,
      let selectedTrack = sender as? Track {
      viewController.track = selectedTrack
    }
  }
}

extension MusicTracksViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tracks.isEmpty ? 0 : 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.CellIdentifier, for: indexPath) as? TrackTableViewCell else {
      return UITableViewCell()
    }
    let track: Track = tracks[indexPath.item]
    cell.configCell(track: track)
    return cell
  }
}

extension MusicTracksViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
