//
//  PopularMoviesViewModel.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import Foundation


protocol PopularMoviesViewDelegate: AnyObject {
    func successfullyReceivedMoviesList()
}

class PopularMoviesViewModel {
    // MARK: - Properties
    var popularMoviesList = [MovieSummary]()
    weak var delegate: PopularMoviesViewDelegate?
    // MARK: - Set up
    
    func set(view: PopularMoviesViewDelegate) {
        self.delegate = view
    }
    
    // MARK: - Network Manager calls
    
    func fetchMoviesList() {
        NetworkClient.shared.getRequest(EndPoints.popularMovies, parameters: nil, headers: ApiHeader.header) { (list: PopularMoviesDataModel) in
            self.popularMoviesList = list.results
            self.delegate?.successfullyReceivedMoviesList()
        } failure: { error in
            print("Failed to fetch records")
        }

    }
}
