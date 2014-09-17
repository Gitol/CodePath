//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Olivier Nallet on 9/10/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

import UIKit

// Workaround for lack of support for static in class in the current version of Swift
// Also could not figure out passing the parameter to the segue in a reasonable amount of time.
var selectedMovie :MovieInfo? = nil

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    
    var moviesArray :[MovieInfo] = []
    var filteredMovieArray :[MovieInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        let YourApiKey = "tetup3jx2uzhgcx6x8tt3449"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            let moviesNSArray = dictionary["movies"] as? NSArray

            if moviesNSArray != nil {
                self.moviesArray = []
                let count = moviesNSArray!.count
                for i in 0...count - 1 {    // My version of XCode does not know about ..
                    let movieInfo = MovieInfo()
                    let movieDictionary = moviesNSArray![i] as NSDictionary
                    movieInfo.Title = movieDictionary["title"] as NSString
                    movieInfo.Rating = movieDictionary["mpaa_rating"] as NSString
                    movieInfo.Description = movieDictionary["synopsis"] as NSString
                    let postersDictionary = movieDictionary["posters"] as NSDictionary
                    movieInfo.ThumbnailUrl = postersDictionary["thumbnail"] as NSString

                    self.moviesArray.append(movieInfo)
                }
            }
            self.movieTableView.reloadData()
        })
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.rottentomatoes.moviecell") as MovieTableViewCell
        let index = indexPath.row
        let movie = moviesArray[indexPath.row]
        cell.titleLabel.text = movie.Title
        cell.ratingLabel.text = movie.Rating
        cell.descriptionLabel.text = movie.Description
        
        // Update the image
        let url = NSURL.URLWithString(movie.ThumbnailUrl)
        var err: NSError?
        var imageData :NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
        cell.movieImageView.image = UIImage(data:imageData)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: Figure out how we pass the parameter to a segue
        selectedMovie = moviesArray[indexPath.row]
    }

    func filterContentForSearchText(searchText: String) {
        // TODO: Do the right thing with this at some point...
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return false
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return false
    }
}

