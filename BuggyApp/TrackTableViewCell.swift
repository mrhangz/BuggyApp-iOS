//
//  TrackTableViewCell.swift
//  BuggyApp
//
//  Created by Sakarn Limnitikarn on 2/7/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import UIKit
import Kingfisher

class TrackTableViewCell: UITableViewCell {
  static let CellIdentifier: String = "TrackTableViewCell"
  
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configCell(track: Track) {
    trackLabel.text = track.trackName
    artistLabel.text = track.artistName
    priceLabel.text = "\(track.trackPrice) \(track.currency)"
    artworkImageView.kf.setImage(with: URL(string: track.artworkUrl))
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    artworkImageView.image = nil
  }
}
