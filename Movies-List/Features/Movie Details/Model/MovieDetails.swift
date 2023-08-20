//
//  MovieDetail.swift
//  Movies-List
//
//  Created by Mahad on 8/21/23.
//

import Foundation

public struct MovieDetails: Codable {
    public let genres: [Genre]
    public let backdropPath: String?
    public let id: Int
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: String?
    public let tagline: String?
    public let title: String?
    public let runtime: Int
    
    public var posterURL: URL {
        guard let baseURL = URL(string: EndPoints.imageURL) else {
            preconditionFailure("Unable to build URL")
        }
        return baseURL.appendingPathComponent(posterPath ?? "")
    }
    
    public var backdropURL: URL {
        guard let baseURL = URL(string: EndPoints.imageURL) else {
            preconditionFailure("Unable to build URL")
        }
        return baseURL.appendingPathComponent(backdropPath ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case genres
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case tagline
        case title
        case backdropPath = "backdrop_path"
        case runtime
    }
    
    public struct Genre: Codable {
        public let name: String
    }
}
