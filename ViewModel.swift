//
//  ViewModel.swift
//  PinerestApplication
//
//  Created by EROSYIP on 28/1/2018.
//  Copyright © 2018 EROSYIP. All rights reserved.
//

import UIKit

struct CellViewModels {
    let image: UIImage
}


class ViewModel  {
    // MARK: Properties
    private let client: APIClient
    private var photos: Photos = []{
        didSet{
            self.fetchPhoto()
        }
    }
    var cellViewModels: [CellViewModels] = []
    
    // MARK: UI
    var isLoading: Bool = false{
        didSet{
            showLoading?()
        }
    }
    
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    init(client:APIClient) {
        self.client = client
    }
    
    func fetchPotos()  {
        if let client = client as? UnsplashClient{
            self.isLoading = true
            let endpoint = UnspashEndpoint.photos(id: UnsplashClient.apiKey, order: .popular)
            client.fetch(with: endpoint) {(either) in
                switch either{
                case .success(let photos):
                    self.photos = photos
                case .error (let error):
                    self.showError?(error)
                }
            }
        }
    }
    
    private func fetchPhoto(){
        let group = DispatchGroup()
        
        self.photos.forEach { (photos) in
            DispatchQueue.global(qos: .background).async(group: group){
                group.enter()
            
            guard let imagData = try? Data(contentsOf: photos.urls.small) else {
                self.showError?(APIError.unknown)
                return
            }
            guard let image = UIImage(data: imagData) else {
                self.showError?(APIError.unknown)
                return
            }
        self.cellViewModels.append(CellViewModels(image: image))
                group.leave()
        }
        
            group.notify(queue: .main){
        self.isLoading = false
            self.reloadData?()
        }
        }
        
        
    }
    
}
