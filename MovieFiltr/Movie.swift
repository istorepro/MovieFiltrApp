//
//  Movie.swift
//  
//
//  Created by Serge Itie Kone Dossongui on 1/18/16.
//
//

import Foundation

class Movie {
    
    var title = ""
    var overview = ""
    var imageCell = ""
    var releaseDate = ""
    var numberOfView = 0.0
    var Rating = 0.0
    
    
    init(title:String, overview:String, imageCell:String, releaseDate:String, numberOfView:Double, Rating:Double) {
        
        self.title  = title
        self.overview = overview
        self.imageCell = imageCell
        self.releaseDate = releaseDate
        self.numberOfView = numberOfView
        self.Rating = Rating
        
    }
}
