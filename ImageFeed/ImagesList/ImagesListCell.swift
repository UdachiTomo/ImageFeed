//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by User on 22.02.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var dateCell: UILabel!
    
    @IBOutlet weak var likeCell: UIButton!
}
