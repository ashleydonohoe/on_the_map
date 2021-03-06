//
//  MapViewController.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
//    var studentLocations = [StudentInformation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewWillAppear(animated: Bool) {
        // Grabs student data and makes map points
        getData()
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
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            let link = NSURL(string:((view.annotation?.subtitle)!)!)
            if let toOpen = link {
                if app.canOpenURL(toOpen) {
                    app.openURL(toOpen)
                } else {
                    showAlert("Cannot open URL")
                }
            }
        }
    }
    

    
    @IBAction func logout(sender: AnyObject) {
        print("logging out")
        UdacityClient.sharedInstance().udacityTaskForDeleteSession { (result, error) in
            if error == nil {
                performUIUpdatesOnMain({
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                self.showAlert("Could not log out!")
            }
        }
    }
    
    @IBAction func refreshStudentData(sender: AnyObject) {
        Model.sharedInstance().studentLocations = []
        getData()
    }
    
    // Code for showing UIAlertController. Adapted from https://www.appcoda.com/uialertcontroller-swift-closures-enum/
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // Function to get student data
    func getData() {
        
        activity.hidden = false
        activity.startAnimating()
        // Get latest student data
        ParseClient.sharedInstance().getStudentInformation { (success, errorString) in
            if success {
                print("Student info gathered")
                performUIUpdatesOnMain({
                    
                    // Get data for the map markers. Code adapted from PinSample app
                    var annotations = [MKPointAnnotation]()
                    
                    // Get coordinatates, names, and web links from each student
                    for student in Model.sharedInstance().studentLocations {
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
                self.showAlert("Could not download student data!")
            }
            
            performUIUpdatesOnMain({ 
                self.activity.hidden = true
                self.activity.stopAnimating()
            })
            
        }

    }
    
    
}
