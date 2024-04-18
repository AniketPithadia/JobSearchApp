//
//  SavedJobsTableViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 18/04/24.
//

import UIKit

class SavedJobsTableViewController: UITableViewController {

    var jobId = ""
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var userSelectedJob : NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        showEmployerNames()
    }
    
    func showEmployerNames(){
        let employerNames = appDelegate?.savedJobs.compactMap { $0["employer_name"] as? String }
        appDelegate?.savedEmployerNames = employerNames ?? []
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate?.savedEmployerNames.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedJobCell", for: indexPath)
        cell.textLabel?.text = appDelegate?.savedEmployerNames[indexPath.row]
        return cell
    }
        
    

   

}
