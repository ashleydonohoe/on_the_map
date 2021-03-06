//
//  PostStudentLocationViewController.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/29/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI
import MapKit

class PostStudentLocationViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enterLocationView: UIView!
    @IBOutlet weak var postLinkView: UIView!
    let geocoder = CLGeocoder()
    
    @IBOutlet weak var linkTextField: UITextField!
    
    // Variables to hold student location string, coordinates, and link
    var locationString: String?
    var coordinate: CLLocationCoordinate2D?
    var mediaURL: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationTextField.delegate = self
        linkTextField.delegate = self
        postLinkView.hidden = true
        activity.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func findOnMap(sender: AnyObject) {
        
        //1. Check there is text in the locationTextField
        if locationTextField.text!.isEmpty {
            performUIUpdatesOnMain({ 
                self.showAlert("Please enter your location")
            })
        } else {
            locationString = locationTextField.text
            performUIUpdatesOnMain({ 
                self.activity.hidden = false
                
                self.activity.startAnimating()
            })
            
            
        // Code to forward geocode the user's location string. Adapted from http://mhorga.org/2015/08/14/geocoding-in-ios.html
            geocoder.geocodeAddressString(locationString!, completionHandler: { (placemarks, error) in
                
                        if error != nil {
                            print(error)
                            performUIUpdatesOnMain({
                                self.activity.hidden = true
                                self.activity.stopAnimating()
                                self.showAlert("An Error has occurred")
                            })
                            return
                        }
                        if placemarks?.count > 0 {
                            let placemark = placemarks?[0]
                            let location = placemark?.location
                            self.coordinate = location?.coordinate
                            
                            
                            // Hide current View
                            self.enterLocationView.hidden = true
                            
                            // Show new view
                            self.postLinkView.hidden = false
                          
                            // Show map with pointer on coordinate
                            let coordinate = CLLocationCoordinate2D(latitude: self.coordinate!.latitude, longitude: self.coordinate!.longitude)
                            let studentAnnotation = MKPointAnnotation()
                            studentAnnotation.coordinate = coordinate
                            studentAnnotation.title = "\(UdacityClient.sharedInstance().firstName!) \(UdacityClient.sharedInstance().lastName!)"
                            performUIUpdatesOnMain({
                                self.activity.hidden = true
                                self.activity.stopAnimating()
                                self.mapView.centerCoordinate = coordinate
                                self.mapView.addAnnotation(studentAnnotation)
                            })
                        } else {
                            performUIUpdatesOnMain({
                                self.activity.hidden = true
                                self.activity.stopAnimating()
                                self.showAlert("No coordinates found. Please check your location")
                    })
                }
            })
        }
    }
    
    
    @IBAction func postStudentLocation(sender: AnyObject) {
        if linkTextField.text!.isEmpty {
            performUIUpdatesOnMain({
                self.showAlert("Please enter a link")
            })
        } else {
            let lat = Double((coordinate?.latitude)!)
            let long = Double((coordinate?.longitude)!)
            mediaURL = linkTextField.text!
            
            self.activity.hidden = false
            self.activity.startAnimating()
            
            ParseClient.sharedInstance().postStudentLocation(lat, longitude: long, mediaURL: mediaURL!, mapString: locationString!) { (success, errorString) in
                
                
                
                if success {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    performUIUpdatesOnMain({ 
                        self.showAlert("Error posting location")
                    })
                }
                self.activity.stopAnimating()
                self.activity.hidden = true
            }
        }
    }
    
    // Code for showing UIAlertController. Adapted from https://www.appcoda.com/uialertcontroller-swift-closures-enum/
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension PostStudentLocationViewController {
    
    // Methods for hiding the keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
}
