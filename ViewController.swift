//
//  ViewController.swift
//  PinerestApplication
//
//  Created by EROSYIP on 18/1/2018.
//  Copyright © 2018 EROSYIP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var actvityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK : - Properties
    
    let viewModel = ViewModel(client:UnsplashClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let layot = collectionView.collectionViewLayout as? PinterestLayout{
            layot.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets (top:10, left:10, bottom:10, right:10)

    //Init view model
        viewModel.showLoading = {
            if self.viewModel.isLoading{
                self.actvityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            }else{
                self.actvityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        viewModel.showError = {error in print(error)}
        viewModel.reloadData = {self.collectionView.reloadData()}
        viewModel.fetchPotos()
    }


}
// MARK - Flow layyout delegete

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = viewModel.cellViewModels[indexPath.item].image
        let heght = image.size.height
        
        return heght
    }
    
    
        
        }

                    


// MARK : Data source

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let image = viewModel.cellViewModels[indexPath.item].image
        cell.imageView.image = image
        
        return cell
    }
    
}
