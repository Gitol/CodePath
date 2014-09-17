//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Olivier Nallet on 9/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieRatingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Somehow the text does not start at the top of the description
        movieDescriptionTextView.setContentOffset(CGPointZero, animated: false)
        
        // Do any additional setup after loading the view.
        movieTitleLabel.text = selectedMovie?.Title
        movieDescriptionTextView.text = selectedMovie?.Description
        movieRatingLabel.text = selectedMovie?.Rating
        
        // Update the image
        let url = NSURL.URLWithString(selectedMovie!.FullSizeImageUrl)
        var err: NSError?
        var imageData :NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
        movieImageView.image = UIImage(data:imageData)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/
}
