//
//  PostStudentLocationViewController.swift
//  On The Map
//
//  Created by Gabriele on 8/29/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI

class PostStudentLocationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enterLocationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func findOnMap(sender: AnyObject) {
        
        //2. Grab the text if there is and assume it's the user's location if so
        //3. Forward geocode to latitude/longitude
        //3.1 If it fails, show alert
        //3.2 Else hide enterLocationView and display enterLinkView
        //        enterLocationView.hidden = true
        
        
        
        //1. Check there is text in the locationTextField
        if locationTextField.text!.isEmpty {
            performUIUpdatesOnMain({ 
                self.showAlert("Please enter your location")
            })
        } else {
            let locationString = locationTextField.text
            print(locationString)
            
            let geocoder = CLGeocoder()
            
        // Code to forward geocode the user's location string. Adapted from http://mhorga.org/2015/08/14/geocoding-in-ios.html
            geocoder.geocodeAddressString(locationString!, completionHandler: { (placemarks, error) in
                        if error != nil {
                            print(error)
                            performUIUpdatesOnMain({
                                self.showAlert("An Error has occurred")
                            })
                            return
                        }
                        if placemarks?.count > 0 {
                            let placemark = placemarks?[0]
                            let location = placemark?.location
                            let coordinate = location?.coordinate
                            print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                            
                            
                            // Hide current View
                            // Show new view
                            // Show map with pointer on coordinate
    
                            
                            
                            
                            
                            
                            
                        } else {
                            print("No coordinates found")
                            performUIUpdatesOnMain({ 
                                self.showAlert("No coordinates found. Please check your location")
                    })
                }
            })
        }
    }
    
    
    // Code for showing UIAlertController. Adapted from https://www.appcoda.com/uialertcontroller-swift-closures-enum/
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
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
