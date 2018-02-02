//
//  ViewController.swift
//  IPopMovies
//
//  Created by Marcio on 29/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import UIKit

class DashboardViewController: UICollectionViewController, DashboardViewContract {

    @IBOutlet weak var waitingLoadView: UIActivityIndicatorView!
    private var presenter: DashboardPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = DashboardPresenter(view: self)
        self.presenter.loadData(orderBy: MovieOrderBy.POPULARITY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getListMovieCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! DashboardCollectionViewCell
        let movie: Movie = self.presenter.getMovie(index: indexPath.row)
        cell.titleMovie.text = movie.title
        cell.waitLoadingImage.startAnimating()
        presenter.getPicture(posterPath: movie.posterPath, movieImage: cell.imageMovie, waitloadingView: cell.waitLoadingImage)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailSegue" {
            let cell = sender as! DashboardCollectionViewCell
            if let indexPath = self.collectionView?.indexPath(for: cell){
                let viewControllerDestination = segue.destination as! MovieDetailsViewController
                viewControllerDestination.movie = self.presenter.getMovie(index: indexPath.row)
            }
        }
    }
    
    func updateCollectionView(){
        DispatchQueue.main.async {
            self.reloadCollectionViewData()
            self.waitingLoadView.stopAnimating()
        }
    }
    
    @IBAction func orderByAction(_ sender: Any) {
        let orderBy = presenter.getOrderBy()

        let orderByAction = UIAlertController.init(title: "Order By",
                                                   message: "",
                                                   preferredStyle: .actionSheet)
        
        let popAction = UIAlertAction.init(title: "Popularity", style: .default,
                                           handler: {(alert: UIAlertAction!) in self.reorderMovies(orderBy: MovieOrderBy.POPULARITY)})
        popAction.isEnabled = orderBy != MovieOrderBy.POPULARITY
        orderByAction.addAction(popAction)
        
        let rateAction = UIAlertAction.init(title: "Rating", style: .default,
                                            handler: {(alert: UIAlertAction!) in self.reorderMovies(orderBy: MovieOrderBy.RATING)})
        rateAction.isEnabled = orderBy != MovieOrderBy.RATING
        orderByAction.addAction(rateAction)
        
        present(orderByAction, animated: true, completion: nil)
    }
    
    private func reorderMovies(orderBy: MovieOrderBy){
        if(presenter.orderByWasChanged(orderBy: orderBy)){
            self.presenter.clearData()
            self.reloadCollectionViewData()
            self.showLoading()
            self.presenter.reloadData(orderBy: orderBy)
        }
    }
    
    private func reloadCollectionViewData(){
        self.collectionView?.performBatchUpdates(
            {self.collectionView?.reloadSections(NSIndexSet(index: 0) as IndexSet)}, completion: { (finished:Bool) -> Void in})
        self.collectionView?.reloadData()
    }

    private func showLoading() {
        self.waitingLoadView.startAnimating()
    }
    

}

