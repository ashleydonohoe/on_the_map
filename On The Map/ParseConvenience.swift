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
    
    func postStudentLocation(latitude: Double, longitude: Double, mapString: String, completionHandlerForPostLocation: (success: Bool, errorString: String?) -> Void) {
    }
}


