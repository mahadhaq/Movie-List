//
//  MovieDetailsVC.swift
//  Movies-List
//
//  Created by Mahad on 8/21/23.
//

import UIKit

class MovieDetailsVC: UIViewController {
    // MARK: - Properties
    var viewModel = MovieDetailsViewModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var backdropImgView: UIImageView!
    @IBOutlet weak var posterImgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var GenreLbl: UILabel!
    @IBOutlet weak var tagline: UILabel!

    @IBOutlet weak var overviewLbl: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Details"
        viewModel.set(view: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchMovieDetails()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func calculateTime(_ timeValue: Int) -> String {
        let timeMeasure = Measurement(value: Double(timeValue), unit: UnitDuration.minutes)
        let hours = timeMeasure.converted(to: .hours)
        if hours.value > 1 {
            let minutes = timeMeasure.value.truncatingRemainder(dividingBy: 60)
            return String(format: "%.f %@ %.f %@", hours.value, "h", minutes, "m")
        }
        return String(format: "%.f %@", timeMeasure.value, "m")
    }
}

// MARK: - Extensions

extension MovieDetailsVC: MovieDetailsViewDelegate {
    func successfullyReceivedMovieDetails() {
        if let movie = viewModel.movieDetail {
            self.backdropImgView.sd_setImage(with: movie.backdropURL, completed: nil)
            self.posterImgView.sd_setImage(with: movie.posterURL, completed: nil)
            self.titleLbl.text = movie.title
            self.overviewLbl.text = movie.overview
            self.tagline.text = movie.tagline
            self.dateTimeLbl.text = "\(movie.releaseDate ?? "") \u{2022} \(self.calculateTime(movie.runtime)) "
            self.GenreLbl.text = movie.genres.map { $0.name }.joined(separator: ", ")
        }
    }
    
    func failedToReceivedMovieDetails() {
        self.backdropImgView.sd_setImage(with: viewModel.selectedMovie.backdropURL, completed: nil)
        self.posterImgView.sd_setImage(with: viewModel.selectedMovie.posterURL, completed: nil)
        self.titleLbl.text = viewModel.selectedMovie.title
        self.overviewLbl.text = viewModel.selectedMovie.overview
        self.dateTimeLbl.text = viewModel.selectedMovie.releaseDate
    }
    
    
}
