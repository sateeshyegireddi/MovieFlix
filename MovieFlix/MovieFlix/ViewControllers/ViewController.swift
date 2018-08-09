//
//  ViewController.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    //MARK: - Outlets
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    //MARK: - Properties
    private var genres = [Genre]()
    private var pageNumber = 1
    private var movies = [Movie]()
    private var selectedMovie: Movie!
    
    //MARK: - View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlayImageView.image = #imageLiteral(resourceName: "bg")
        
        registerCells()
        
        //Get data from API
        getGenres()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Call Web Service APIs
    private func getGenres() {
        
        //Show loading
        self.showActivityIndicator()
        
        //Get all genres from API
        APIHandler().getGenres(with: nil) { [weak self] (success, genres, error) in
            guard let weakSelf = self else { return }
            
            //Hide loading
            weakSelf.hideActivityIndicator()
            
            //On success
            if success {
                
                //Copy genres to original object
                if genres != nil {
                    
                    weakSelf.genres = genres!
                    
                    //Get all movies from API
                    DispatchQueue.main.async {
                        
                        weakSelf.getPopularMovies()
                    }
                }
                
            } else {
                
                Functions().showSimpleAlert(OnViewController: weakSelf, Message: error!)
            }
        }
    }
    
    private func getPopularMovies() {
     
        //Show loading
        self.showActivityIndicator()
        
        //Get all movies from API
        APIHandler().getMovies(with: nil, pageNumber: pageNumber, genres: genres) { [weak self] (success, movies, error) in
            guard let weakSelf = self else { return }
            
            //Hide loading
            weakSelf.hideActivityIndicator()
            
            //On success
            if success {
                
                //Copy genres to original object
                if movies != nil {
                    
                    weakSelf.movies = movies!
                    weakSelf.reloadData()
                }
                
            } else {
                
                Functions().showSimpleAlert(OnViewController: weakSelf, Message: error!)
            }
        }
    }
    
    //MARK: - Functions
    private func registerCells() {
        
        let nib = UINib(nibName: MovieCell.identifier, bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    private func reloadData() {
        
        //Reload collection view
        DispatchQueue.main.async {
            
            self.moviesCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Move user to Movie Details ViewController
        if let movieDetails = segue.destination as? MovieDetailsViewController, segue.identifier == GlobalConstants.SegueId.movieDetails {
            
            //Send the associated mandatory data
            movieDetails.movieId = selectedMovie.id
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width / 2, height: (view.bounds.width / 2) * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        //Setup cell values
        cell.titleLabel.text = movies[indexPath.item].title
        let genreNamesArray = movies[indexPath.item].genres.map { $0.name }
        cell.genreLabel.text = genreNamesArray.joined(separator: " | ")
        cell.setPosterImage(with: movies[indexPath.item].imageUrl)
        
        //Return cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedMovie = movies[indexPath.item]
        performSegue(withIdentifier: GlobalConstants.SegueId.movieDetails, sender: self)
    }
}
