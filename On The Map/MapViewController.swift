//
//  MapViewController.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let udacityClient = UdacityClient()
    let parseClient = ParseClient()
    
    var studentLocations = [StudentInformation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        studentLocations = parseClient.studentLocations
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
        parseClient.getStudentInformation { (success, errorString) in
            if success {
                print("Student info gathered")
            } else {
                print(errorString)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        print("logging out")
        udacityClient.udacityTaskForDeleteSession { (result, error) in
            if error == nil {
                performUIUpdatesOnMain({ 
                    let controller = self.storyboard?.instantiateViewControllerWithIdentifier("UdacityLoginViewController") as! LoginViewController
                    self.presentViewController(controller, animated: true, completion: nil)
                })
            } else {
                print("Could not end session: \(error)")
            }
        }
    }
}
