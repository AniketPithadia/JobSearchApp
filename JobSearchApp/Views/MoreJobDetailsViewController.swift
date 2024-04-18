//
//  MoreJobDetailsViewController.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 18/04/24.
//

import UIKit

class MoreJobDetailsViewController: UIViewController ,UITableViewDataSource{
    
    

    
    var jobHighlights : Highlights?
    
    
    
    @IBOutlet weak var QualificationTable: UITableView!
    
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        QualificationTable.dataSource = self
              title = "Job Qualifications"
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if tableView == QualificationTable {
               return jobHighlights?.Qualifications?.count ?? 0
           }
           
           return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == QualificationTable {
            let qcell = tableView.dequeueReusableCell(withIdentifier: "qCell", for: indexPath)
            qcell.textLabel?.text = jobHighlights?.Qualifications?[indexPath.row] ?? "No Qualifications"
            return qcell
        }
        
        return UITableViewCell()
    }
}
