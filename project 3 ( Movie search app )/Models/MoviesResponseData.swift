//
//  MoviesResponseData.swift
//  project 3 ( Movie search app )
//
//  Created by robusta on 19/04/2024.
//

import Foundation

struct MoviesResponseData: Codable {
    
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
}
