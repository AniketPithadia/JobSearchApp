//
//  NetworkService.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 15/04/24.
//


import Foundation

protocol NetworkingJobsDelegate {
    func networkingDidFinishWithJobList(jobList:  [NSDictionary])
    func networkingDidFinishWithError()
    func networkingDidFinishWithJobDetails(jobDetails : [JobModel])
}

class NetworkingService {
    
    static var shared = NetworkingService()
    
    var jobsDelegate: NetworkingJobsDelegate?
    
    
    func getJobs(searchText : String) {
       
        let headers = [
            "X-RapidAPI-Key": "86fb234b8emsh0257b95f7df25a1p1348ccjsnac4fc1e7a5c7",
            "X-RapidAPI-Host": "jsearch.p.rapidapi.com"
        ]

        
        guard let url = URL(string: "https://jsearch.p.rapidapi.com/search?query=\(searchText)&page=1&num_pages=1") else {
            self.jobsDelegate?.networkingDidFinishWithError()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error While Fetching Data")
                self.jobsDelegate?.networkingDidFinishWithError()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                self.jobsDelegate?.networkingDidFinishWithError()
                return
            }
            
            do {
                if let data = data {
                    let jobObject = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                    let jobs = jobObject?.value(forKey:"data") as? [NSDictionary]
                    
                    DispatchQueue.main.async {
                        self.jobsDelegate?.networkingDidFinishWithJobList(jobList: jobs!)
                    }
                }
            } catch {
                print("Error decoding job details: \(error)")
                self.jobsDelegate?.networkingDidFinishWithError()
            }
        }
        
        task.resume()
    }
    
    func getJobDetailsById(jobId: String) {
        let headers = [
            "X-RapidAPI-Key": "86fb234b8emsh0257b95f7df25a1p1348ccjsnac4fc1e7a5c7",
            "X-RapidAPI-Host": "jsearch.p.rapidapi.com"
        ]
        
        guard var urlComponents = URLComponents(string: "https://jsearch.p.rapidapi.com/job-details") else {
            self.jobsDelegate?.networkingDidFinishWithError()
            return
        }
        
        
        urlComponents.queryItems = [
            URLQueryItem(name: "job_id", value: jobId),
            URLQueryItem(name: "extended_publisher_details", value: "false")
        ]
        
        guard let url = urlComponents.url else {
            self.jobsDelegate?.networkingDidFinishWithError()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error While Fetching Job Details: \(error)")
                self.jobsDelegate?.networkingDidFinishWithError()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                self.jobsDelegate?.networkingDidFinishWithError()
                return
            }
            
            if let data = data {
                do {
                    let responseObject = try JSONDecoder().decode(ResponseModel.self, from: data)
                    if let detailOfJob = responseObject.data {
                        DispatchQueue.main.async{
                            self.jobsDelegate?.networkingDidFinishWithJobDetails(jobDetails: detailOfJob)
                        }
                       
                    } else {
                        print("No job details found")
                        self.jobsDelegate?.networkingDidFinishWithError()
                    }
                } catch {
                    print("Error decoding job details: \(error)")
                    self.jobsDelegate?.networkingDidFinishWithError()
                }
            } else {
                print("No data received")
                self.jobsDelegate?.networkingDidFinishWithError()
            }
        }
        
        task.resume()
    }


}
