//
//  MoviesData.swift
//  MovieSearch
//
//  Created by Alex Nikolaienko on 8/1/23.
//

import Foundation
import Combine

class MoviesData: ObservableObject {
    @Published var movies = [MovieModel]()
    
    var moviesListFull = false
    
    private var currentPage = 0
    private let perPage = 20
    private var lastSearchText = ""
                    
    private var cancellable: AnyCancellable?
    
    func fetchMovies(searchText: String) {
        if lastSearchText != searchText {
            lastSearchText = searchText
            self.currentPage = 0
            movies.removeAll()
        }
        let formattedSearchText = searchText.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string:
            "https://api.themoviedb.org/3/search/movie?api_key=b11fc621b3f7f739cb79b50319915f1d&language=en-US&query=\(formattedSearchText)&page=\(currentPage+1)&include_adult=false") {
            
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { $0.data }
                .decode(type: MoviesWebModel.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { _ in
                    // handle completion errors
                } receiveValue: { [weak self] movies in
                    self?.moviesListFull = movies.page == movies.total_pages
                    self?.currentPage += 1
                    
                    movies.results.forEach {
                        self?.movies.append( MovieModel(movieWebModel: $0) )
                    }
                }
        }
    }
}
