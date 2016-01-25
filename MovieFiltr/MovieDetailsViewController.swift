//
//  MovieDetailsViewController.swift
//  MovieFiltr
//
//  Created by Serge Itie Kone Dossongui on 1/18/16.
//  Copyright © 2016 Serge Itie Kone Dossongui. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageDetailsView: UIImageView!
    @IBOutlet weak var titleDetailsLabel: UILabel!
    @IBOutlet weak var OverViewDetailsLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var releaseDateDetailsLabel: UILabel!
    @IBOutlet weak var Rating: UILabel!
    @IBOutlet weak var imageRatingStart: UIImageView!
    @IBOutlet weak var imagePopularityeye: UIImageView!
    
    @IBOutlet weak var PopularityLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var MovieOfDetailsView : Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set view of the navigaiton controller
      navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .Plain, target: nil, action: nil)
        
        title = MovieOfDetailsView.title
        
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
       /*     let posterPathOfDetailsView = MovieOfDetailsView.imageCell
            let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPathOfDetailsView )
            imageDetailsView!.setImageWithURL(posterUrl!)*/
        
        
        //subsitute code to display image
        let posterPathOfDetailsView = MovieOfDetailsView.imageCell
        let posterSmall = "https://image.tmdb.org/t/p/w45"
        let posterLarge = "https://image.tmdb.org/t/p/original"
        
        let smallImageRequest = NSURLRequest(URL: NSURL(string: posterSmall + posterPathOfDetailsView )!)
        let largeImageRequest = NSURLRequest(URL:NSURL(string: posterLarge + posterPathOfDetailsView)!)
        
        
        
        self.imageDetailsView.setImageWithURLRequest(
            smallImageRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                    // smallImageResponse will be nil if the smallImage is already available
                    // in cache (might want to do something smarter in that case).
                    self.imageDetailsView.alpha = 0.0
                    self.imageDetailsView.image = smallImage;
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        
                        self.imageDetailsView.alpha = 1.0
                        
                        }, completion: { (sucess) -> Void in
                            
                            // The AFNetworking ImageView Category only allows one request to be sent at a time
                            // per ImageView. This code must be in the completion block.
                            self.imageDetailsView.setImageWithURLRequest(
                                largeImageRequest,
                                placeholderImage: smallImage,
                                success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                    
                                    self.imageDetailsView.image = largeImage;
                                    
                                },
                                failure: { (request, response, error) -> Void in
                                    // do something for the failure condition of the large image request
                                    // possibly setting the ImageView's image to a default image
                            })
                    })
                },
                failure: { (request, response, error) -> Void in
                    // do something for the failure condition
                    // possibly try to get the large image
            })
    


        
        
        //set title
        titleDetailsLabel.text = MovieOfDetailsView.title.capitalizedString
        
        //set Overview
        OverViewDetailsLabel.text = MovieOfDetailsView.overview
 
        //resize the label to fit the length of the overview 
        OverViewDetailsLabel.sizeToFit()
        
        releaseDateDetailsLabel.text = String(format: "Release Date:\(MovieOfDetailsView.releaseDate)")
        
        PopularityLabel.text = String(format: "%.2f views ",MovieOfDetailsView.numberOfView)
        
        Rating.text = String(format: "%.2f ",MovieOfDetailsView.Rating)

        // Do any additional setup after loading the view.
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
