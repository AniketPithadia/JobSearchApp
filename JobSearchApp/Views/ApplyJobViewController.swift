//
//  ApplyJobViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 18/04/24.
//

import UIKit

class ApplyJobViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var applyLinkTable: UITableView!
    
    var jobApply : [ApplyOption]?
    override func viewDidLoad() {
           super.viewDidLoad()
           applyLinkTable.dataSource = self
        title = "Apply Links"
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return jobApply?.count ?? 0
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)
           
           
           guard let applyOption = jobApply?[indexPath.row] else {
               return cell
           }
           
           
           cell.textLabel?.text = applyOption.publisher ?? "Unknown Publisher"
           cell.detailTextLabel?.text = applyOption.apply_link ?? "No Apply Link"
           
           return cell
       }

}
