//
//  ViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 15/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.shared.getJobs()
        title = "GetWork"
        // Do any additional setup after loading the view.
    }


}

