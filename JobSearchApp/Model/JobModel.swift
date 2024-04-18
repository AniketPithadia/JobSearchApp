//
//  JobModel.swift
//  JobSearchApp
//
//  Created by Aniket Pithadia on 15/04/24.
//
struct JobModel: Decodable {
    let employer_name: String?
    let employer_website: String?
    let job_publisher: String?
    let job_title: String?
    let job_employment_type: String?
    let job_state: String?
    let job_city: String?
    let job_country: String?
    let job_description: String?
    let job_is_remote: Bool?
    let job_highlights: Highlights?
    let apply_options: [ApplyOption]?
    init() {
            self.employer_name = ""
            self.employer_website = ""
            self.job_publisher = ""
            self.job_title = ""
            self.job_employment_type = ""
            self.job_city = ""
            self.job_state = ""
            self.job_country = ""
            self.job_description = ""
            self.job_is_remote = false
            self.job_highlights = Highlights(Qualifications: [], Responsibilties: [])
            self.apply_options = []
        }
}

struct Highlights: Decodable {
    let Qualifications: [String]?
    let Responsibilties: [String]?
    
}

struct ApplyOption: Decodable {
    let publisher: String?
    let apply_link: String?
}
