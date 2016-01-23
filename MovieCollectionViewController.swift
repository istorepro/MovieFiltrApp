//
//  MovieCollectionViewController.swift
//  MovieFiltr
//
//  Created by Serge Itie Kone Dossongui on 1/20/16.
//  Copyright © 2016 Serge Itie Kone Dossongui. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var LoadedCollectionMovies: [Movie] = []
    var moviesC : [NSDictionary]?
    var OneCollectionMovie : Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView .dataSource = self
        collectionView.delegate = self
       // set LoadedCollectionMovies
        for (var i = 0; i < self.moviesC?.count;i++){
            
            
            var dumy = ""
            if let posterPath = self.moviesC![i]["poster_path"] as? String {
                
                dumy = self.moviesC![i]["poster_path"] as! String
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                dumy = "none"
            }
            
            
            
          self.LoadedCollectionMovies.append(Movie(title: self.moviesC![i]["title"] as! String, overview: self.moviesC![i]["overview"] as! String, imageCell: dumy, releaseDate: self.moviesC![i]["release_date"] as! String, numberOfView : self.moviesC![i]["popularity"] as! Double, Rating : self.moviesC![i]["vote_average"] as! Double))
        }
        
            


        //set the datasource
      //  collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     func numberOfSectionsInCollectionView(CollectionView:
        UICollectionView) -> Int {
        return 1
    }
     func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
       
        if let moviesC = moviesC{
            
            return 20
        }else{
            
            
            return 0
        }

       
    }
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
         let cellIDentifier = "cellCollectionView"
        let cellOfCollectionView = collectionView.dequeueReusableCellWithReuseIdentifier(cellIDentifier,
        forIndexPath: indexPath) as! MovieCollectionViewCell
                
                 OneCollectionMovie = LoadedCollectionMovies[indexPath.row]
          
                let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
                let posterUrl = NSURL(string: posterBaseUrl + OneCollectionMovie.imageCell)
                cellOfCollectionView.imageViewOfCollection.setImageWithURL(posterUrl!)
            //set title in collection view
            cellOfCollectionView.TitleOfCollectionView.text = OneCollectionMovie.title
            cellOfCollectionView.numberOfviewLabel.text = String(format: "%.2f views ",OneCollectionMovie.numberOfView)
 
    
                
        // Configure the cell
    
        return cellOfCollectionView
    }
    
    
    

    
    
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            //segue to show tabelView controller
            if segue.identifier == "showDetailsImage" {
            
            if let indexPath = collectionView?.indexPathsForSelectedItems(){
            let destinationViewController = segue.destinationViewController as! MovieDetailsViewController
            //pass only the book class
           destinationViewController.MovieOfDetailsView = OneCollectionMovie
            
            //hide tab bar in details view
            destinationViewController.hidesBottomBarWhenPushed = true
            
            
            }
            }
    }*/


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
