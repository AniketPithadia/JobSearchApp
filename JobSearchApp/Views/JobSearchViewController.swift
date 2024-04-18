//
//  JobSearchViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 15/04/24.
//
import UIKit

class JobSearchViewController: UITableViewController, UISearchBarDelegate, NetworkingJobsDelegate {
    
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var userSelectedJob : NSDictionary = [:]

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate?.employerNames.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = appDelegate?.employerNames[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        NetworkingService.shared.jobsDelegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count > 2 {
            NetworkingService.shared.getJobs(searchText: searchText)
        }
        if searchText.count == 0 {
            appDelegate?.employerNames = []
            appDelegate?.jobList = []
            tableView.reloadData()
        }
    }
    
    func networkingDidFinishWithJobList(jobList: [NSDictionary]) {
        
        appDelegate?.jobList = jobList
        let employerNames = jobList.compactMap { $0["employer_name"] as? String }
        appDelegate?.employerNames = employerNames
        tableView.reloadData()
    }
    
    func networkingDidFinishWithError() {
        print("Error inside Service")
    }
    func networkingDidFinishWithJobDetails(jobDetails: [JobModel]) {
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEmployerName = appDelegate?.employerNames[indexPath.row]
        userSelectedJob = (appDelegate?.jobList.first { ($0["employer_name"] as? String) == selectedEmployerName })!
       
        performSegue(withIdentifier: "showJobDetails", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobDetails" {
            if let jobDetailsVC = segue.destination as? JobDetailsViewController {
                jobDetailsVC.selectedJob = userSelectedJob
                
            }
        }
    }
}
