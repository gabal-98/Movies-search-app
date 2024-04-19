//
//  MoviesManager.swift
//  project 3 ( Movie search app )
//
//  Created by robusta on 19/04/2024.
//

import Foundation

protocol MoviesManagerDelegate {
    func didFailWithError(sender: MoviesManager , error: Error)
    func didFinishSearching(sender: MoviesManager , result: [Movie])
}

class MoviesManager {
    
    let baseURL = "https://www.omdbapi.com/?"
    let api_key = "b84359c"
    
    var delegate: MoviesManagerDelegate?
    
    func search(for movie: String){
        
        let stringURL = "\(baseURL)s=\(movie)&apikey=\(api_key)"
        if let url = URL(string: stringURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(sender: self, error: error!)
                }
                if let safeData = data {
                    let moviesResult = self.parseJsonData(data: safeData)
                    self.delegate?.didFinishSearching(sender: self, result: moviesResult)
                }
            }
            task.resume()
        }
    }
    
    func parseJsonData(data: Data) -> [Movie]{
        let decoder = JSONDecoder()
        let decodedData = try! decoder.decode(MoviesResponseData.self, from: data)
        return decodedData.Search
    }
}
