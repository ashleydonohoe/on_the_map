//
//  ParseConstants.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

extension ParseClient {
    
    struct Constants {
        static let ApplicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
//        static let ApiScheme = "https"
//        static let ApiHost = "parse.udacity.com"
//        static let ApiPath = "parse/classes/StudentLocation"
        static let BaseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
    }
    
    struct Parameters {
        static let Limit = "limit"
        static let Order = "order"
        static let Where = "where"
        static let ObjectId = "objectID"
    }
    
    
    struct JSONResponseKeys {
        static let Results = "results"
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    struct ErrorMessages {
        static let ConnectionError = "Could not connect to Parse server"
        static let DownloadError = "Could not download student data"
        static let SendError = "Could not post location to server"
    }
}