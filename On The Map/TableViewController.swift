//
//  TableViewController.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var studentInfoTable: UITableView!
    var students = [[String: AnyObject]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let student1 = ["name": "Ashley", "location": "Cincinnati"]
        let student2 = ["name": "John", "location": "New York City"]
        
        students = [student1, student2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        print("logging out")
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("UdacityLoginViewController") as! LoginViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentInfoCell")! as UITableViewCell
        let student = students[indexPath.row]
        cell.textLabel!.text = student["name"] as? String
        cell.detailTextLabel?.text = student["location"] as? String
        return cell
    }

}
