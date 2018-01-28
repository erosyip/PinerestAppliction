//
//  UnsplashClient.swift
//  PinerestApplication
//
//  Created by EROSYIP on 28/1/2018.
//  Copyright © 2018 EROSYIP. All rights reserved.
//

import Foundation

class UnsplashClient :APIClient{
    static let baseUrl = "http://api.unsplash.com"
    static let apiKey = "c5b34202a3bedcfcc43a4da57250ef41568e8fdfa16fcba22ad4b49b827178e8"


    func fetch(with endpoint:UnspashEndpoint, completion: @escaping (Either<Photos>) -> Void){
        let request = endpoint.requst
        get(with: request, completion: completion)
        
    }









}

