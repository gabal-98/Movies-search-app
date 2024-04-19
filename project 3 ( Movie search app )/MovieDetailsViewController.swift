//
//  MovieDetailsViewController.swift
//  project 3 ( Movie search app )
//
//  Created by robusta on 19/04/2024.
//

import UIKit
import WebKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    let baseURL = "https://en.wikipedia.org/wiki/"
    
    var selectedMovie: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Movie Details"
        searchForMovie(movie: selectedMovie!)
    }
    
    func searchForMovie(movie: String) {
        let fullURL = "\(baseURL)movie"
        if let url = URL(string: fullURL) {
            webView.load(URLRequest(url: url))
        }
    }
}
