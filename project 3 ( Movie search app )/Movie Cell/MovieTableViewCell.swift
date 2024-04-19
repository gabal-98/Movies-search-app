//
//  MovieTableViewCell.swift
//  project 3 ( Movie search app )
//
//  Created by robusta on 19/04/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var moviePosterURL: String?

    @IBOutlet var posterView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImageFromWeb(stringURL: String) {
        if let url = URL(string: stringURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, _ in
                if let safeData = data {
                    let image = UIImage(data: safeData)
                    self.setPoster(image: image!)
                }
            }
            task.resume()
        }
    }
    
    func setPoster(image: UIImage) {
        DispatchQueue.main.async {
            self.posterView.image = image
        }
    }
}

