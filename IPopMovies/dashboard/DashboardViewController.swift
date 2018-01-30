//
//  ViewController.swift
//  IPopMovies
//
//  Created by Marcio on 29/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import UIKit

class DashboardViewController: UICollectionViewController, DashboardViewContract {

    @IBOutlet weak var collectionViewCell: UICollectionViewCell!
    private var presenter: DashboardPresenterContract
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionCellSetup()
        self.presenter = DashboardPresenter(view: self);
        self.presenter.loadData(orderBy: MovieOrderBy.POPULARITY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! DashboardCollectionViewCell
   //     cell.imageMovie.image = UIImage(cgImage: "")
        cell.titleMovie.text = ""
        
        return cell
    }
 
    private func collectionCellSetup(){
        let itemSize = UIScreen.main.bounds.width / 2 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
    }
    
    func fillList(movies: [Movie]) {
        self.presenter.updateList(movies: movies)
    }
    
    func showLoading() {
        
    }
    
    func openItem(movie: Movie) {
        
    }
    
    func requestPicture(posterPath: String, movieImage: UIImageView) {
        self.presenter.getPicture(posterPath: posterPath, movieImage: movieImage)
    }
    

}
