//
//  PopularMovieCell.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import UIKit
import SDWebImage

class PopularMovieCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(movie:MovieSummary) {
        let url = URL(string: EndPoints.imageURL)?.appendingPathComponent(movie.posterPath ?? "")
        self.imgView.sd_setImage(with: url, completed: nil)
        self.titleLbl.text = movie.title
        self.descriptionLbl.text = movie.overview
    }
}
