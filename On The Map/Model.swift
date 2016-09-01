//
//  Model.swift
//  On The Map
//
//  Created by Gabriele on 8/31/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

class Model: NSObject {

   var studentLocations: [StudentInformation]
    
    // Initialize for studentLocations
    override init() {
        studentLocations = [StudentInformation]()
        super.init()
    }
    
    //Allows Model to act as singleton
    class func sharedInstance() -> Model {
        struct Singleton {
            static var sharedInstance = Model()
        }
        return Singleton.sharedInstance
    }
    
    
}