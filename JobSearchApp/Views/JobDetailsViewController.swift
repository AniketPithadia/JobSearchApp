//
//  JobDetailsViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 16/04/24.
//

import UIKit

class JobDetailsViewController: UIViewController,NetworkingJobsDelegate ,UITableViewDataSource{
   
    
    let networkingService = NetworkingService.shared
    var jobDetails: [(String, String)] = []
    var jobMoreDetails : Highlights?
    var jobApplyOptions : [ApplyOption]?
    var job : [JobModel]?
    var selectedJob : NSDictionary = [:]
    @IBOutlet weak var jobDetailTable: UITableView!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingService.jobsDelegate = self
        checkJobId()
    
    }
    func checkJobId(){
        if let jobId = selectedJob["job_id"] as? String {
            print(selectedJob)
            networkingService.getJobDetailsById(jobId: jobId)
              }
    }
    
    @IBAction func saveJob(_ sender: UIButton) {
        
               guard let jobId = selectedJob["job_id"] else {
                   print("Error getting job Id")
                   return
               }
               
        if let job = appDelegate?.jobList.first(where: { ($0["job_id"] as? String) == jobId as! String }) {
            appDelegate?.savedJobs.append(job)
        }else {
                   print("Employer name not found for jobId: \(jobId)")
               }
           }
    
    func networkingDidFinishWithJobList(jobList: [NSDictionary]) {
        
    }
    
    func networkingDidFinishWithError() {
        print("Error Inside Service")
    }

    func networkingDidFinishWithJobDetails(jobDetails: [JobModel]) {
            if let job = jobDetails.first {
                self.jobDetails = [
                    ("Company", job.employer_name ?? "----"),
                    ("Website", job.employer_website ?? "----"),
                    ("Published By", job.job_publisher ?? "----"),
                    ("Title", job.job_title ?? "----"),
                    ("Job Type", job.job_employment_type ?? "----"),
                    ("City", job.job_city ?? "----"),
                    ("State", job.job_state ?? "----"),
                    ("Country", job.job_country ?? "----")
                ]
                self.jobMoreDetails = job.job_highlights
                self.jobApplyOptions = job.apply_options
                
                
                DispatchQueue.main.async {
                    self.jobDetailTable.reloadData()
                }
            }
        }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobDetails.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        let detail = jobDetails[indexPath.row]
        cell.textLabel?.text = detail.0 + ": " + detail.1
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreDetails" {
            if let moreDetailsVC = segue.destination as? MoreJobDetailsViewController {
                moreDetailsVC.jobHighlights = jobMoreDetails
                
            }
        }
        if segue.identifier == "applyJob" {
            if let applyJobVC = segue.destination as? ApplyJobViewController {
                applyJobVC.jobApply = jobApplyOptions
                
            }
        }
        if segue.identifier == "saveJob" {
            if let saveJobVC = segue.destination as? SavedJobsTableViewController {
                saveJobVC.jobId = selectedJob["job_id"] as! String
                
            }
        }
        
    }
}

