//
//  TableViewController.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import WebKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var studentInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activity.hidden = true

    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        print("logging out")
        UdacityClient.sharedInstance().udacityTaskForDeleteSession { (result, error) in
            if error == nil {
                performUIUpdatesOnMain({
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                print("Could not end session: \(error)")
            }
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance().studentLocations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentInfoCell")! as UITableViewCell
        let student = Model.sharedInstance().studentLocations[indexPath.row]
        cell.textLabel!.text = student.firstName + " " + student.lastName
        cell.detailTextLabel?.text = student.mapString
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let student = Model.sharedInstance().studentLocations[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let app = UIApplication.sharedApplication()
        if let link = student.mediaURL as? String {
            app.openURL(NSURL(string: link)!)
        }
    }
    
    
    // Clears the current studentLocations and grabs the latest 100
    @IBAction func refreshStudentData(sender: AnyObject) {
        Model.sharedInstance().studentLocations = []
        getData()
    }
    
    // Gets latest 100 student pins
    func getData() {
        activity.hidden = false
        activity.startAnimating()
        ParseClient.sharedInstance().getStudentInformation { (success, errorString) in
            if success {
                print("Student info gathered")
                performUIUpdatesOnMain({
                    self.studentInfoTable.reloadData()
                })
            } else {
                print(errorString)
                self.showAlert("Could not download student data!")
            }
            
            performUIUpdatesOnMain({ 
                self.activity.hidden = true
                self.activity.stopAnimating()
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
