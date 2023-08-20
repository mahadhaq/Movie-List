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
        self.imgView.sd_setImage(with: movie.posterURL, placeholderImage: UIImage(named: "posterPlaceHolder"))
        self.titleLbl.text = movie.title  ?? "N/A"
        self.descriptionLbl.text = movie.overview  ?? "N/A"
    }
}
