//
//  MovieDetailsView.swift
//  MovieSearch
//
//  Created by Alex Nikolaienko on 8/1/23.
//

import SwiftUI

struct MovieDetailsView: View {
    
    private var movie: MovieModel!
    private var releaseDate: String = ""
    private var imageUrlString: String?

    init(movie: MovieModel) {
        self.movie = movie
        if let releaseDate = movie.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            
            self.releaseDate = dateFormatter.string(from: releaseDate)
        }
        if let posterPath = movie.posterPath {
            imageUrlString = "https://image.tmdb.org/t/p/original\(posterPath)"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let imageUrlString = imageUrlString {
                    AsyncImage(url: URL(string: imageUrlString)!, scale: 2) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else if phase.error != nil {
                            Text("404")
                                .font(.system(size: 10))
                                .multilineTextAlignment(.center)
                        } else {
                            ProgressView()
                                .font(.largeTitle)
                        }
                    }
                    .frame(width: 70, height: 140)
                }
                VStack(alignment: .leading) {
                    Text(movie.title).font(.title)
                    Text(releaseDate).foregroundColor(.gray)
                    if let voteAverage = movie.voteAverage {
                        Text("Viewer rating…").foregroundColor(.gray).padding(.top, 3.0)
                        Text(String(voteAverage)).font(.headline)
                        ProgressView(value: movie.voteAverage, total: 10)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            List {
                Text("OVERVIEW").font(.headline).foregroundColor(.gray)
                Text(movie.overview)
            }
            .padding(.top, 13.0)
            .listStyle(.plain)
        }
        .padding(.leading, 20.0)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let movieModel = MovieModel(movieWebModel: MovieWebModel(id: 10, title: "Hitman piu", release_date: "2007-11-21", poster_path: "/h69UJOOKlrHcvhl5H2LY74N61DQ.jpg", vote_average: 6.8, overview: "“Hitman“ tells the story of Ben (played by Cesar), a man seeking revenge for the brutal death of his family committed by the very people who hired him to kill people. Along the way, he meets Gina (Sam Pinto) which compounds the situation and brings Ben to a crossroad. The story happens in just 48 hours with one scene vital to"))
        
        MovieDetailsView(movie: movieModel)
    }
}
