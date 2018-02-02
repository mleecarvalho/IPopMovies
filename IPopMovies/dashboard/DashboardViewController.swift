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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! DashboardCollectionViewCell
        let movie: Movie = self.presenter.getMovie(index: indexPath.row)
        cell.titleMovie.text = movie.title
        cell.waitLoadingImage.startAnimating()
        presenter.getPicture(posterPath: movie.posterPath, movieImage: cell.imageMovie, waitloadingView: cell.waitLoadingImage)
        
        return cell
    }
 
    func showLoading() {
        self.waitingLoadView.startAnimating()
    }
    
    func updateCollectionView(){
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.waitingLoadView.stopAnimating()
        }
    }
    
    func openItem(movie: Movie) {
        
    }
    
    @IBAction func orderByAction(_ sender: Any) {
        let orderByAction = UIAlertController.init(title: "Order By",
                                                   message: "",
                                                   preferredStyle: .actionSheet)
        let popAction = UIAlertAction.init(title: "Popularity", style: .default,
                                           handler: {(alert: UIAlertAction!) in self.reorderMovies(orderBy: MovieOrderBy.POPULARITY)})
        let rateAction = UIAlertAction.init(title: "Rating", style: .default,
                                            handler: {(alert: UIAlertAction!) in self.reorderMovies(orderBy: MovieOrderBy.RATING)})
        orderByAction.addAction(popAction)
        orderByAction.addAction(rateAction)
        
        present(orderByAction, animated: true, completion: nil)
    }
    
    private func reorderMovies(orderBy: MovieOrderBy){
        if(presenter.orderByWasChanged(orderBy: orderBy)){
  //          self.collectionView?.deleteItems(at: (self.collectionView?.indexPathsForVisibleItems)!)
            self.showLoading()
            presenter.reloadData(orderBy: orderBy)
        }
    }
    
}

