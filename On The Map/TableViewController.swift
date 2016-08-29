//
//  TableViewController.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import WebKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let udacityClient = UdacityClient()
    let parseClient = ParseClient()

    @IBOutlet weak var studentInfoTable: UITableView!
      var studentLocations = [StudentInformation]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentInfoCell")! as UITableViewCell
        let student = studentLocations[indexPath.row]
        cell.textLabel!.text = student.firstName + " " + student.lastName
        cell.detailTextLabel?.text = student.mapString
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let student = studentLocations[indexPath.row]
        
        let app = UIApplication.sharedApplication()
        if let link = student.mediaURL as? String {
            app.openURL(NSURL(string: link )!)
        }
    }
    
    
    // Gets latest 100 student pins
    func getData() {
        parseClient.getStudentInformation { (success, errorString) in
            if success {
                print("Student info gathered")
                performUIUpdatesOnMain({
                    self.studentLocations = self.parseClient.studentLocations
                    self.studentInfoTable.reloadData()
                })
            } else {
                print(errorString)
            }
        }
    }
}
