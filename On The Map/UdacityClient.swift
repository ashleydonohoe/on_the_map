//
//  UdacityClient.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/25/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient: NSObject {
    
    var userID: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    
    
    // Method for building Udacity URL
    func buildUdacityURL(withPathExtension: String?) -> NSURL {
        let components = NSURLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = Constants.ApiPath
        
        return components.URL!
    }
    
    //TODO: Add function for deleting session
    func closeSession() {
        
    }
    
    // API client method for
    func udacityTaskForGetUserInfoMethod(completionHandlerForGet: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // Make URL for request
        let urlString = Constants.BaseURL + Methods.UserInfo + self.userID!
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGet)
        }
        
        task.resume()
        
        return task
    }
    
    func udacityTaskForLoginMethod(jsonBody: String, completionHandlerForLogin: (result:AnyObject?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        let urlString = Constants.BaseURL + Methods.Session
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error:String) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                let alertView = UIAlertView(title: "Login Error", message: "Couldn't login", delegate: self, cancelButtonTitle: "OK")
                alertView.tag = 1
                alertView.show()
                completionHandlerForLogin(result: nil, error: NSError(domain: "udacityTaskForLoginMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForLogin)
            
        }
        
        // 6. Start the request
        task.resume()
        
        return task
        
    }
//
//    func udacityTaskForDeleteSession(completionHandlerForDeleteSession: (result: AnyObject, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//    }
    
    // Function to convert data. Adapted from Movie Manager app in iOS Networking course
    func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
        
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
            completionHandlerForConvertData(result: parsedResult, error: nil)
        }
    }


