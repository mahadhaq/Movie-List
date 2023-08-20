//
//  PopularMoviesViewModel.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import Foundation


protocol PopularMoviesViewDelegate: AnyObject {
    func successfullyReceivedMoviesList()
    func failedToReceivedMoviesList(message: String)
}

class PopularMoviesViewModel {
    // MARK: - Properties
    var popularMoviesList = [MovieSummary]()
    var totalPages = 0
    weak var delegate: PopularMoviesViewDelegate?
    var page: Int32 = 1
    var isPageRefreshing:Bool = false
    
    // MARK: - Set up
    
    func set(view: PopularMoviesViewDelegate) {
        self.delegate = view
    }
    
    // MARK: - Network Manager calls
    
    func fetchMoviesList() {
        let params = ["page": page] as [String: AnyObject]
        NetworkClient.shared.getRequest(EndPoints.popularMovies, parameters: params, headers: ApiHeader.header) { (list: PopularMoviesDataModel) in
            self.totalPages = list.totalPages
            if self.page == 1 {
                self.popularMoviesList = list.results
            }
            else {
                self.popularMoviesList.append(contentsOf: list.results)
            }
            self.isPageRefreshing = false
            if self.popularMoviesList.count > 0 {
                self.delegate?.successfullyReceivedMoviesList()
            }
            else {
                self.delegate?.failedToReceivedMoviesList(message: "No Data Found")
            }
        } failure: { error in
            print("Failed to fetch records")
            self.delegate?.failedToReceivedMoviesList(message: error)
        }

    }
}
