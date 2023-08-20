//
//  EndPoints.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import Foundation

class EndPoints {
    public static let BASE_URL = "https://api.themoviedb.org/3/movie"
    public static let popularMovies = BASE_URL + "/popular"
}

class ApiHeader {

    public static var header : [String:String] {
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MmZkMjY4YjYxMDg3ZmNlNjFkYTIwYTk2NTBjMTJjYiIsInN1YiI6IjY0ZTEzY2Y2MjQ5NWFiMDExZGQ0NGU2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nNkRDYPJqytUaTkiVXLggdupIfNebKkvoLHi8M7pfoA"
        return ["Authorization":"Bearer \(token)" ,"Accept":"application/json"]
    }
    

}
