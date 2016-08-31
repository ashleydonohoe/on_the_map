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
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String ?? "None"
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String ?? "None"
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String ?? "None"
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String ?? "None"
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String ?? "None"
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String ?? "None"
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as! Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as! Double
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