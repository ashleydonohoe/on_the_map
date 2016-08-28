//
//  StudentInformation.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    // Student properties
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    
    // Initializing a Student from a dictionary
    init(dictionary: [String:AnyObject]) {
        objectId = dictionary[ParseClient.JSONResponseKeys.objectId] as! String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.uniqueKey] as! String
        firstName = dictionary[ParseClient.JSONResponseKeys.firstName] as! String
        lastName = dictionary[ParseClient.JSONResponseKeys.lastName] as! String
        mapString = dictionary[ParseClient.JSONResponseKeys.mapString] as! String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.mediaURL] as! String
        latitude = dictionary[ParseClient.JSONResponseKeys.latitude] as! Double
        longitude = dictionary[ParseClient.JSONResponseKeys.longitude] as! Double
    }
    
    static func studentsFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        var students = [StudentInformation]()
        
        // Add each student to the array
        for result in results {
            students.append(StudentInformation(dictionary: result))
        }
        
        return students
    }
}