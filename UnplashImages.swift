//
//  UnplashImages.swift
//  PinerestApplication
//
//  Created by EROSYIP on 28/1/2018.
//  Copyright © 2018 EROSYIP. All rights reserved.
//

import Foundation


typealias Photos = [Photo]

struct Photo :Codable{
    let id:  String
    let urls : URLS
}

struct URLS: Codable{
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
    
    
    
}
