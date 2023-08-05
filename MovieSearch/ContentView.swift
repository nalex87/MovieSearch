//
//  ContentView.swift
//  MovieSearch
//
//  Created by Alex Nikolaienko on 8/1/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @ObservedObject var moviesData = MoviesData()
    
    var body: some View {
        NavigationView {
            HStack {
                if searchText.isEmpty {
                    Text("No results").foregroundColor(.gray)
                } else {
                    List {
                        ForEach(moviesData.movies, id: \.self) { movie in
                            NavigationLink {
                                MovieDetailsView(movie: movie)
                            } label: {
                                MovieRowView(movie: movie)
                            }
                        }
                        if moviesData.moviesListFull == false && searchText.isEmpty == false {
                            ProgressView().onAppear {
                                moviesData.fetchMovies(searchText: searchText)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Movie Search")
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { searchText in
            moviesData.fetchMovies(searchText: searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
