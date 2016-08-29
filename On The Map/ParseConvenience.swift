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
        
        taskForGETMethod(nil, parameters: parameters) { (result, error) in
            if let error = error {
                completionHandlerForStudentInfo(success: false, errorString: "Error occurred")
            } else {
                if let information = result[JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    self.studentLocations = StudentInformation.studentsFromResults(information)
                    print(self.studentLocations)
                    completionHandlerForStudentInfo(success: true, errorString: nil)
                } else {
                    completionHandlerForStudentInfo(success: false, errorString: "Could not get student info")
                }
            }
        }
    }
}