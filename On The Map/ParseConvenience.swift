//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func getStudentInformation(completionHandlerForStudentInfo: (success: Bool, errorString: String?) -> Void) {
        let parameters = [
            ParseClient.Parameters.Limit: 100,
            ParseClient.Parameters.Order: "-updatedAt"
        ]
        
        taskForGETMethod(parameters) { (result, error) in
            if let error = error {
                completionHandlerForStudentInfo(success: false, errorString:  "\(error)")
            } else {
                if let information = result![JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    self.studentLocations = StudentInformation.studentsFromResults(information)
                    completionHandlerForStudentInfo(success: true, errorString: nil)
                }
            }
        }
    }
    
    func postStudentLocation(latitude: Double!, longitude: Double!, mediaURL: String!, mapString: String!, completionHandlerForPostLocation: (success: Bool, errorString: String?) -> Void) {
//        
        let uniqueKey = UdacityClient.sharedInstance().userID!
        let firstName = UdacityClient.sharedInstance().firstName!
        let lastName = UdacityClient.sharedInstance().lastName!
        
        
         let jsonBody = "{\"uniqueKey\":  \"\(uniqueKey)\", \"firstName\":  \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\":\(latitude), \"longitude\": \(longitude)}"
        
        print(jsonBody)
        
//       let jsonBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doeee\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"
        taskForPOSTMethod(jsonBody) { (result, error) in
            if let error = error {
                print(error)
                completionHandlerForPostLocation(success: false, errorString: "Could not connect!")
            } else {
                print(result)
                if let objectID = result![JSONResponseKeys.ObjectId] as? String {
                    print(objectID)
                    completionHandlerForPostLocation(success: true, errorString: nil)
                }
            }
        }
    }
}


