//
//  MovieDetailsViewModel.swift
//  Movies-List
//
//  Created by Mahad on 8/21/23.
//

import Foundation

protocol MovieDetailsViewDelegate: AnyObject {
    func successfullyReceivedMovieDetails()
    func failedToReceivedMovieDetails()
}

class MovieDetailsViewModel {
    // MARK: - Properties
    var movieDetail:MovieDetails?
    weak var delegate: MovieDetailsViewDelegate?
    var selectedMovie: MovieSummary!
    
    // MARK: - Set up
    
    func set(view: MovieDetailsViewDelegate) {
        self.delegate = view
    }
    
    func fetchMovieDetails() {
        NetworkClient.shared.getRequest(EndPoints.BASE_URL + "/\(selectedMovie.id)", parameters: nil, headers: ApiHeader.header) { (movie: MovieDetails) in
            self.movieDetail = movie
            self.delegate?.successfullyReceivedMovieDetails()
        } failure: { error in
            self.delegate?.failedToReceivedMovieDetails()
        }

    }
}
