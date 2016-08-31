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
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String ?? "Unknown"
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String ?? "Unknown"
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String ?? "Location Unknown"
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String ?? "No URL provided"
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double ?? 0.00
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double ?? 0.00
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