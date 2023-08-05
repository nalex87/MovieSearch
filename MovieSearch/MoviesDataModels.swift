//
//  MoviesDataModels.swift
//  MovieSearch
//
//  Created by Alex Nikolaienko on 8/1/23.
//

import Foundation

struct MoviesWebModel: Codable {
    var page: Int = 0
    var results: [MovieWebModel] = []
    var total_pages: Int = 0
    var total_results: Int = 0
}

struct MovieWebModel: Codable {
    var id: Int
    var title: String
    var release_date: String
    var poster_path: String?
    var vote_average: Double?
    var overview: String
}

struct MovieModel: Codable, Hashable {
    var id: Int
    var title: String
    var releaseDate: Date?
    var posterPath: String?
    var voteAverage: Double?
    var overview: String
    
    init(movieWebModel: MovieWebModel) {
        let dateFormattter = DateFormatter()
        dateFormattter.dateFormat = "yyyy-MM-dd"
        self.id = movieWebModel.id
        self.title = movieWebModel.title
        self.releaseDate = dateFormattter.date(from: movieWebModel.release_date)
        self.posterPath = movieWebModel.poster_path
        self.voteAverage = movieWebModel.vote_average
        self.overview = movieWebModel.overview
    }
}
