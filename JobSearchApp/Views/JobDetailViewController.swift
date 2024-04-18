//
//  JobDetailViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 18/04/24.
//

import UIKit

class JobDetailViewController: UITableViewController, NetworkingJobsDelegate {

    
    @IBOutlet weak var saveJob: UIButton!
    
    
    @IBOutlet weak var applyJob: UIButton!
    
    var jobDetails: [(String, String)] = []
    var job : JobModel?
    var selectedJob : NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Job Details"
        if let jobId = selectedJob["job_id"] as? String {
                  print("Job ID: \(jobId)")
                  NetworkingService.shared.getJobDetailsById(jobId: jobId)
              } else {
                  print("Job ID not found, redirecting to JobSearchViewController...")
                  navigateToJobSearchViewController()
              }
        
    }
    
       func navigateToJobSearchViewController() {
           if let jobSearchViewController = storyboard?.instantiateViewController(withIdentifier: "JobSearchViewController") as? JobSearchViewController {
               navigationController?.pushViewController(jobSearchViewController, animated: true)
           }
       }
    func networkingDidFinishWithJobList(jobList: [NSDictionary]) {
        
    }
    
    func networkingDidFinishWithError() {
        
    }
    
    func networkingDidFinishWithJobDetails(jobDetails: [JobModel]) {
     if let job = jobDetails.first {
        self.jobDetails.append(("Comapany Name", job.employer_name ?? ""))
        self.jobDetails.append(("Website", job.employer_website ?? ""))
        self.jobDetails.append(("Publisher", job.job_publisher ?? ""))
         self.jobDetails.append(("Title",job.job_title ?? ""))
         self.jobDetails.append(("Description",job.job_description ?? ""))
         self.jobDetails.append(("Job Type",job.job_employment_type ?? ""))
         self.jobDetails.append(("City",job.job_city ?? ""))
         self.jobDetails.append(("State",job.job_state ?? ""))
         self.jobDetails.append(("Country",job.job_country ?? ""))
//         self.jobDetails.append(("Remote Job",job.job_is_remote ?? "false"))
         
        
        // Reload table view data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        let detail = jobDetails[indexPath.row]
        cell.textLabel?.text = detail.0 + ": " + detail.1
        return cell
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
