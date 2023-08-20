//
//  MovieSummary.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import Foundation


// MARK: - PopularMoviesDataModel
struct PopularMoviesDataModel: Codable {
    let page: Int
    let results: [MovieSummary]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieSummary: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath, releaseDate, title: String?
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
    }
}
