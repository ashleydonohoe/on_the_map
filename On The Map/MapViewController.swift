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
    
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
        
        // Get latest student data
        parseClient.getStudentInformation { (success, errorString) in
            if success {
                print("Student info gathered")
                performUIUpdatesOnMain({
                    self.studentLocations = self.parseClient.studentLocations
                    
                    // Get data for the map markers. Code adapted from PinSample app
                    var annotations = [MKPointAnnotation]()
                    
                    // Get coordinatates, names, and web links from each student
                    for student in self.studentLocations {
                        let lat = CLLocationDegrees(student.latitude )
                        let long = CLLocationDegrees(student.longitude )
                        
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        
                        let firstName = student.firstName
                        let lastName = student.lastName
                        let mediaURL = student.mediaURL
                        
                        // Creating annotations with student data
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "\(firstName) \(lastName)"
                        annotation.subtitle = mediaURL
                        
                        annotations.append(annotation)
                    }
                    
                    performUIUpdatesOnMain {
                        // adding annotations to map
                        self.mapView.addAnnotations(annotations)
                    }
                    
                })
            } else {
                print(errorString)
            }
            
        }
    }
    
    
    // Method for the right callout accessory view. Used from PinSample app
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // Method for opening URL on pin tap. Taken from PinSample app
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            let link = annotationView.annotation!.subtitle
            app.openURL(NSURL(string: link!!)!)
        }
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
