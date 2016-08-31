//
//  PostStudentLocationViewController.swift
//  On The Map
//
//  Created by Gabriele on 8/29/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class PostStudentLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enterLocationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func findOnMap(sender: AnyObject) {
        enterLocationView.hidden = true
    }

}
