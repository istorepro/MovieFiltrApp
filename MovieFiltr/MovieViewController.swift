//
//  MovieViewController.swift
//  MovieFiltr
//
//  Created by Serge Itie Kone Dossongui on 1/17/16.
//  Copyright © 2016 Serge Itie Kone Dossongui. All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    

    @IBOutlet weak var labelfiltertypeOfMovie: UILabel!
    @IBOutlet var CollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var movies : [NSDictionary]?  // create an dictionary array to hold movies from responseDictionary
    var searchController: UISearchController! // declare a searchController Variable
    var LoadedMovies : [Movie] = []
    var searchResults : [Movie] = []
    var a: Movie?
    var filter: [NSDictionary]?
    var endPoint : String! = "top_rated"
    var apiKeyForMovieDataBase = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var secondEndPoint : String!
    var headTitle : [String] = ["Movies","Tv Shows"]
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var filterView: UIView!

       override func viewDidLoad() {
         super.viewDidLoad()
        
     //hide the view display by the filter
       self.filterView.alpha = 0
       
    
     
        
        
        
        //set view of the navigaiton controller
       navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .Plain, target: nil, action: nil)
       
       // title = "Movies"
        if(self.secondEndPoint == "movie"){
            
          title = self.headTitle[0]
        }
        else{
            
            
            title = self.headTitle[1]
    
                

        }
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
    labelfiltertypeOfMovie.text = "Top Rated"
       CallApi()
    
        

        
        /***** refresh Control******/
        let refreshControl = UIRefreshControl() //initialize the refresh Control
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged) //Bind the action to the refresh control
        tableView.insertSubview(refreshControl, atIndex: 0) //Insert the refresh control into the list
        
        /***search bar******/
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false // show result in sametableView
        tableView.tableHeaderView = searchController.searchBar
        
    
        
        /* customize the search bar ****/
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor(red: 30.0/255.0, green:
            30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        searchController.searchBar.placeholder = "Search Movies...in"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if searchController.active {
            
            self.filterView.alpha = 0
            return  searchResults.count
            
        }else{
            
            if let movies = movies{
                
                return movies.count
            }else{
                
                
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIDentifier = "MovieCell"
        let cellOfTableView = tableView.dequeueReusableCellWithIdentifier(cellIDentifier, forIndexPath: indexPath) as! MovieTableViewCell
        
        
        
        
        //let OneMovie = movies![indexPath.row]
        let OneMovie = (searchController.active) ? searchResults[indexPath.row] : LoadedMovies[indexPath.row]
        
        

        
       /**** debuging of tableView without data*****/
       // let  a = LoadedMovies[indexPath.row]
       // cell.textLabel?.text = "row\(indexPath.row)"]
      
        
        /****set cell using simple data******/
//        cell.titleLabel.text = OneMovie["title"] as? String
//       cell.overviewLabel.text = OneMovie["overview"] as? String
        //let posterPath = OneMovie["poster_path"] as? String

        /****set cell using class******/
        //set poster image to imageView whether there is a poster or not
        
        
        
        if(OneMovie.imageCell == "none")
        {
            cellOfTableView.imageview.image = nil
        }
        else{
        
        
        let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
        let posterUrl = NSURL(string: posterBaseUrl + OneMovie.imageCell)
        cellOfTableView.imageview!.setImageWithURL(posterUrl!)
        }

        cellOfTableView.titleLabel.text = OneMovie.title
        cellOfTableView.overviewLabel.text = OneMovie.overview

       
        
       // set poster image to imageView whether there is a poster or not
       /* let posterPath = OneMovie.imageCell
        let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
        let posterUrl = NSURL(string: posterBaseUrl + posterPath)
        cell.imageView!.setImageWithURL(posterUrl!)*/
        
    
        return cellOfTableView
    
    }
    
    //implement an action to update the list
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // Make network request to fetch latest data
        // Do the following when the network request comes back successfully:
        // Update tableView data source
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func updateSearchResultsForSearchController(searchController:
            UISearchController) {
            if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
           
                //display number of result in the windows  depending of the number of results
//                resultsLabel.text =  searchResults.count > 1 ? String(format: "%d results found ",searchResults.count) : String(format: "%d result found ",searchResults.count)
          
    } }
    
    
    
    func filterContentForSearchText(searchText: String) {
        
            searchResults =  searchText.isEmpty ? LoadedMovies: LoadedMovies.filter({ (a : Movie) -> Bool in
        let nameMatch = a.title.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return nameMatch != nil         })
    }

   
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
  //segue to show tabelView controller
        if segue.identifier == "showMovieDetails" {
            
            self.filterView.alpha = 0
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destinationViewController as! MovieDetailsViewController
                //pass only the book class
               destinationViewController.MovieOfDetailsView = searchResults[indexPath.row]
                
                //hide tab bar in details view
                destinationViewController.hidesBottomBarWhenPushed = true
                
                
            }
        }
        
            if segue.identifier == "showCollectionView" {
                
                
                    self.filterView.alpha = 0
                    let destinationViewController = segue.destinationViewController as! MovieCollectionViewController
                    //pass only the book class
                    destinationViewController.moviesC = self.movies
                destinationViewController.SecondEndPoint = self.secondEndPoint
                
                 destinationViewController.hidesBottomBarWhenPushed = true
            
        }
        
    }
    
    
    @IBAction func dislpayFilterView(sender: AnyObject) {
        
        
        UIView.animateWithDuration(0.1, animations:
            {
               
                if(self.filterView.alpha == 1){
                // This causes first view  second view and Main view to fade in
                self.filterView.alpha = 0
               
                }else{
                    
                self.filterView.alpha = 1
                    
                }
        })
    }
    
    
    @IBAction func showButtonA(sender: AnyObject) {
        
       self.filterView.alpha = 0
      
        if(self.secondEndPoint == "movie"){
            
            labelfiltertypeOfMovie.text = "Now playing"
            endPoint = "now_playing"
        }
        
        if(self.secondEndPoint == "tv"){
            
            labelfiltertypeOfMovie.text = "On Air"
            endPoint = "on_the_air"
        }
        
                CallApi()
        tableView.reloadData()
        
    }
    
    @IBAction func showButtonB(sender: AnyObject) {
        
        self.filterView.alpha = 0
        if(self.secondEndPoint == "movie"){
            
            labelfiltertypeOfMovie.text = "Top Rated"
            endPoint = "top_rated"
        }

        if(self.secondEndPoint == "tv"){
            
            labelfiltertypeOfMovie.text = "Top Rated"
            endPoint = "top_rated"
        }


       
        CallApi()
        tableView.reloadData()
        
    }

   
    @IBAction func showButtonC(sender: AnyObject) {
       
        self.filterView.alpha = 0
        
        if(self.secondEndPoint == "movie"){
            
            labelfiltertypeOfMovie.text = "Up Coming"
            endPoint = "upcoming"
        }

        
        
        if(self.secondEndPoint == "tv"){
            
            labelfiltertypeOfMovie.text = "Popular"
            endPoint = "popular"
        }
               CallApi()
        tableView.reloadData()
}
    
            
    
//    
//    @IBAction func switchButton(sender: AnyObject) {
//        
//       //ANIMMATION switch view
//        UIView.animateWithDuration(0.1, animations:
//            {
//                // This causes first view  second view and Main view to fade in
//            let   swapVar = self.viewHolderOfTableView.alpha
//                
//                self.viewHolderOfTableView.alpha =
//                    self.viewHolderOfcollection.alpha
//                self.viewHolderOfcollection.alpha = swapVar
//                
//        })
//
//
//    }
    
    
    func CallApi(){
        
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        //        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let url = NSURL(string:"https://api.themoviedb.org/3/\(secondEndPoint)/\(endPoint)?api_key=\(apiKey)")
        
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            
                          //  self.filter = self.movies
                            self.LoadedMovies = []
                            self.searchResults = []
                            
                            
                            
                            
                            if(self.secondEndPoint == "movie"){
                            
                                
                                self.buttonA.setTitle("Now Playing", forState: UIControlState.Normal)
                                self.buttonB.setTitle("Top Rated", forState: UIControlState.Normal)
                                self.buttonC.setTitle("Up Coming", forState: UIControlState.Normal)
                                
                                
                            // itterate throught the dictionary and set load Movies
                            for (var i = 0; i < self.movies?.count;i++){
                                
                                var dumy = ""
                                if let posterPath = self.movies![i]["poster_path"] as? String {
                                    
                                      dumy = self.movies![i]["poster_path"] as! String
                                }
                                else {
                                    // No poster image. Can either set to nil (no image) or a default movie poster image
                                    // that you include as an asset
                                    dumy = "none"
                                }

                                
                          
                                
                                
                                
                                
                                self.LoadedMovies.append(Movie(title: self.movies![i]["title"] as! String, overview: self.movies![i]["overview"] as! String, imageCell: dumy,releaseDate: self.movies![i]["release_date"] as! String, numberOfView : self.movies![i]["popularity"] as! Double, Rating : self.movies![i]["vote_average"] as! Double))
                                
                                self.searchResults.append(Movie(title: self.movies![i]["title"] as! String, overview: self.movies![i]["overview"] as! String, imageCell: dumy, releaseDate: self.movies![i]["release_date"] as! String, numberOfView : self.movies![i]["popularity"] as! Double, Rating : self.movies![i]["vote_average"] as! Double))
                                
                                
                            }
                                
                }
            if(self.secondEndPoint == "tv"){
                
                
                 self.title = self.headTitle[1]
                
                self.buttonA.setTitle("On Air", forState: UIControlState.Normal)
                self.buttonB.setTitle("Top Rated", forState: UIControlState.Normal)
                self.buttonC.setTitle("Popular", forState: UIControlState.Normal)
                
                
                // itterate throught the dictionary and set load Movies
                for (var i = 0; i < self.movies?.count;i++){
                    
                    var dumy = ""
                    if let posterPath = self.movies![i]["poster_path"] as? String {
                        
                        dumy = self.movies![i]["poster_path"] as! String
                    }
                    else {
                        // No poster image. Can either set to nil (no image) or a default movie poster image
                        // that you include as an asset
                        dumy = "none"
                    }

                
                
                 self.LoadedMovies.append(Movie(title: self.movies![i]["name"] as! String, overview: self.movies![i]["overview"] as! String, imageCell: dumy,releaseDate: self.movies![i]["first_air_date"] as! String, numberOfView : self.movies![i]["popularity"] as! Double, Rating : self.movies![i]["vote_average"] as! Double))
                    
                    
                     self.searchResults.append(Movie(title: self.movies![i]["name"] as! String, overview: self.movies![i]["overview"] as! String, imageCell: dumy, releaseDate: self.movies![i]["first_air_date"] as! String, numberOfView : self.movies![i]["popularity"] as! Double, Rating : self.movies![i]["vote_average"] as! Double))
                
                
                            }
                    }
                            
                            self.tableView.reloadData()
                            
                            
                            
                    }
                }
        });
        task.resume()
                
        

 
    }
    
        
    /* disabled transport Network
    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key><true/>
    </dict>
    */
    
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
