//
//  MovieDetailsViewController.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var movieDetailsTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: - Properties
    var movieId = 0
    private var imageView: UIImageView!
    fileprivate var movieDetails = MovieDetails()
    
    //MARK: - ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup UI
        overlayImageView.image = #imageLiteral(resourceName: "bg")
        movieDetailsTableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0)
        registerCells()

        //Create add strechable imageView
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        imageView.image = #imageLiteral(resourceName: "banner-product")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        view.bringSubview(toFront: backButton)
        
        //Get data from API
        getMovieDetails()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Call Web Service APIs
    private func getMovieDetails() {
        
        //Show loading
        self.showActivityIndicator()

        //Get movieDetails form API
        APIHandler().getMovieDetails(for: movieId) { [weak self] (success, movieDetails, error) in
            guard let weakSelf = self else { return }
            
            //Hide loading
            weakSelf.hideActivityIndicator()
            
            //On success
            if success {
                
                if movieDetails != nil {
                    
                    //Copy genres to original object
                    weakSelf.movieDetails = movieDetails!
                    weakSelf.setPosterImage()
                    weakSelf.reloadData()
                }
            } else {
                
                Functions().showSimpleAlert(OnViewController: weakSelf, Message: error!)
            }
            
        }
    }
    
    //MARK: - Functions
    private func registerCells() {
        
        let nib2 = UINib(nibName: MovieDetailsCell.identifier, bundle: nil)
        movieDetailsTableView.register(nib2, forCellReuseIdentifier: MovieDetailsCell.identifier)
        let nib = UINib(nibName: LabelCell.identifier, bundle: nil)
        movieDetailsTableView.register(nib, forCellReuseIdentifier: LabelCell.identifier)
    }
    
    private func reloadData() {
        
        //Reload collection view
        DispatchQueue.main.async {
            
            self.movieDetailsTableView.reloadData()
        }
    }
    
    private func setPosterImage() {
        
        DispatchQueue.main.async {
            
            self.imageView.loadImageUsingCache(with: "\(GlobalConstants.API.imageUrl)\(GlobalConstants.URL_Keys.origin_image)\(self.movieDetails.imageUrl)")
        }
    }
}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            //Create cell
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCell.identifier, for: indexPath) as! MovieDetailsCell
            
            //Setup cell values
            cell.titleLabel.text = movieDetails.title
            let genreNamesArray = movieDetails.genres.map { $0.name }
            cell.genreLabel.text = genreNamesArray.joined(separator: " | ")
            cell.releaseDateLabel.text = "In theatres from " + movieDetails.releaseDate
            cell.popularityLabel.text = "Popularity: \(movieDetails.popularity)"
            cell.budgetLabel.text = "Cost: US$\(movieDetails.budget)"
            
            //Return cell
            return cell
        case 1:
            //Create cell
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.identifier, for: indexPath) as! LabelCell
            
            //Setup cell values
            cell.titleLabel.text = movieDetails.overview
            
            //Return cell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if imageView != nil {
            
            let y = 300 - (scrollView.contentOffset.y + 300)
            let height = min(max(y, 60), 400)
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        }
    }
}
