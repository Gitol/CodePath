//
//  MovieInfo.swift
//  Rotten Tomatoes
//
//  Created by Olivier Nallet on 9/15/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

import Foundation

class MovieInfo {
    var Title: String = ""
    var Rating: String = ""
    var Description: String = ""
    var ThumbnailUrl: String = ""
    var FullSizeImageUrl: String {
        get
        {
            // Original size is in another url in the Rotten Tomatoes API...
            return ThumbnailUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        }
    }
}

