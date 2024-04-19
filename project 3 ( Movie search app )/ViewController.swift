//
//  ViewController.swift
//  project 3 ( Movie search app )
//
//  Created by robusta on 19/04/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var movies = [Movie]()
    let movieManager = MoviesManager()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        movieManager.delegate = self
        
        title = "Movies List"
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        tableView.rowHeight = 250

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "movieDetailsSegue" {
            let index = tableView.indexPathForSelectedRow
            tableView.deselectRow(at: index!, animated: true)
            let vc = segue.destination as? MovieDetailsViewController
            vc?.selectedMovie = movies[index!.row].Title
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell {
            let cellMovie = movies[indexPath.row]
            cell.loadImageFromWeb(stringURL: "\(cellMovie.Poster)")
            cell.titleLabel.text = cellMovie.Title
            cell.yearLabel.text = cellMovie.Year
            cell.typeLabel.text = cellMovie.Type
            return cell
        }else {
            return UITableViewCell()
        }
    }
}


extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let movieName = searchBar.text {
            searchBar.resignFirstResponder()
            movieManager.search(for: movieName)
        }
    }
}


extension ViewController: MoviesManagerDelegate {
    
    func didFailWithError(sender: MoviesManager, error: Error) {
        print(error.localizedDescription)
    }
    
    func didFinishSearching(sender: MoviesManager, result: [Movie]) {
        movies = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "movieDetailsSegue", sender: selectedMovie)
    }
}



