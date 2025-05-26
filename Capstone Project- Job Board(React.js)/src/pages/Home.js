import React, { useState, useEffect } from 'react';
import './home.css';
import Header from '../components/Header';
import JobPostings from './JobPostings';
import { useNavigate } from 'react-router-dom';


function Home(props) {
  const [jobPostings, setJobPostings] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedSalary, setSelectedSalary] = useState('');
  const [selectedLocation, setSelectedLocation] = useState('');
  const [selectedExperienceLevel, setSelectedExperienceLevel] = useState('');
  const [selectedJobType, setSelectedJobType] = useState('');
  const [selectedIndustry, setSelectedIndustry] = useState('');
  const [jobOfInterestList, setJobOfInterestList] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    const storedJobPostings = JSON.parse(localStorage.getItem('jobPostings')) || [];
    setJobPostings(storedJobPostings);
  }, []);

  const handleDelete = (index) => {
    const newJobPostings = [...jobPostings];
    newJobPostings.splice(index, 1);
    setJobPostings(newJobPostings);
    localStorage.setItem('jobPostings', JSON.stringify(newJobPostings));
  };

  const handleAddJobOfInterest = (jobPosting) => {
    const updatedJobOfInterestList = [...jobOfInterestList, jobPosting];
    setJobOfInterestList(updatedJobOfInterestList);
    localStorage.setItem('jobOfInterestList', JSON.stringify(updatedJobOfInterestList));
    navigate('/pages/Login');
  };

  const handleSearchTermChange = (event) => {
    setSearchTerm(event.target.value);
  };

  const handleSalaryChange = (e) => {
    setSelectedSalary(e.target.value);
  };

  const handleLocationChange = (e) => {
    setSelectedLocation(e.target.value);
  };

  const handleExperienceLevelChange = (e) => {
    setSelectedExperienceLevel(e.target.value);
  };

  const handleJobTypeChange = (e) => {
    setSelectedJobType(e.target.value);
  };

  const handleIndustryChange = (e) => {
    setSelectedIndustry(e.target.value);
  };

  const filteredJobs = jobPostings.filter((jobPosting) => {
    if (searchTerm && !jobPosting.job_title.toLowerCase().includes(searchTerm.toLowerCase())) {
      return false;
    }
    if (selectedLocation && jobPosting.location !== selectedLocation) {
      return false;
    }
    if (selectedSalary && jobPosting.salary !== selectedSalary) {
      return false;
    }
    if (selectedExperienceLevel && jobPosting.experienceLevel !== selectedExperienceLevel) {
      return false;
    }
    if (selectedJobType && jobPosting.jobType !== selectedJobType) {
      return false;
    }
    if (selectedIndustry && jobPosting.industry !== selectedIndustry) {
      return false;
    }
    return true;
  });

  const handleFilter = () => {
    return filteredJobs.map((jobPosting) => (
      <div key={jobPosting.id} className="job-listing">
        <div className="job-header">
        </div>
        <div className="job-body">
          <p><strong>Title:</strong> {jobPosting.jobTitle}</p>
          <p><strong>Salary:</strong> {jobPosting.salary}</p>
          <p><strong>Description:</strong> {jobPosting.jobDescription}</p>
          <p><strong>Date Posted:</strong> {new Date(jobPosting.postingDate).toLocaleDateString()}</p>
          <p><strong>Industry:</strong> {jobPosting.industry}</p>
          <p><strong>Job Type:</strong> {jobPosting.jobType}</p>
          <p><strong>Location:</strong> {jobPosting.location}</p>
        </div>
      </div>
    ));
  };




  return (
     
    <div className="home-container">
      <Header />
      <h1>Find Your Passion, Land Your Dream Job:</h1>
      <p style={{ fontSize: "24px" }}>Start Your Job Search Now!</p>
      <div className="search-filters">
        <input type="text" placeholder="Search jobs" value={searchTerm} onChange={handleSearchTermChange} />
        <div className="filter-group">
          <label htmlFor="salary">Salary:</label>
          <select id="salary" value={selectedSalary} onChange={handleSalaryChange}>
            <option value="">Any</option>
            <option value="">Negotiable</option>
            <option value="less than 50000">Less than 50000</option>
            <option value="50000 - 100000">50000 - 100000</option>
            <option value="100000 - 150000">100000 - 150000</option>
            <option value="more than 150000">More than 150000</option>
          </select>
        </div>
        <div className="filter-group">
          <label htmlFor="location">Location:</label>
          <select id="location" value={selectedLocation} onChange={handleLocationChange}>
            <option value="">Any</option>
            <option value="Remote/Work From Home">Remote/Work From Home</option>
            <option value="New York, NY">New York, NY</option>
            <option value="San Francisco, SF">San Francisco, SF</option>
            <option value="Chicago, IL">Chicago, IL</option>
       
       
          </select>
        </div>
      
        <div className="filter-group">
          <label htmlFor="job-type">Job Type:</label>
          <select id="job-type" value={selectedJobType} onChange={handleJobTypeChange}>
            <option value="">Any</option>
            <option value="Full-time">Full-Time</option>
            <option value="Part-time">Part-Time</option>
            <option value="Contract">Contract</option>
            <option value="Temporary">Temporary</option>
          </select>
        </div>
        <div className="filter-group">
          <label htmlFor="industry">Industry:</label>
          <select id="industry" value={selectedIndustry} onChange={handleIndustryChange}>
            <option value="">Any</option>
            <option value="Technology">Technology</option>
  <option value="Healthcare">Healthcare</option>
  <option value="Finance">Finance</option>
  <option value="Retail">Retail</option>
  <option value="Manufacturing">Manufacturing</option>
  <option value="Education">Education</option>
  <option value="Real Estate">Real Estate</option>
  <option value="Energy">Energy</option>
  <option value="Transportation">Transportation</option>
  <option value="Hospitality">Hospitality</option>
  <option value="Consulting">Consulting</option>
  <option value="Marketing">Marketing</option>
  <option value="Design">Design</option>
  <option value="Human Resources">Human Resources</option>

         </select>
        </div>
        <div className="filter-group" style={{ display: "flex", justifyContent: "center", alignItems: "center", margin: "10px 0", fontFamily: "'Roboto', sans-serif", textAlign: "center" }}>
       

</div>
<>

<p style={{ fontSize: "30px" }}>Available Postings:</p>
        {filteredJobs.length > 0 ? (
          <div>
            {filteredJobs.map((jobPosting) => (
              <div key={jobPosting.id} className="job-listing">
                <div className="job-header"></div>
                <div className="job-body">
                  <h4 >{jobPosting.job_title}</h4>
                  <h3>{jobPosting.company_name}</h3>
                  <p style={{ fontSize: "22px" }}><strong>Salary:</strong> {jobPosting.salary}</p>
                  <p style={{ fontSize: "22px" }}><strong>Description:</strong> {jobPosting.job_description}</p>
                  <p style={{ fontSize: "22px" }}><strong>Industry:</strong> {jobPosting.industry}</p>
                  <p style={{ fontSize: "22px" }}><strong>Job Type:</strong> {jobPosting.job_type}</p>
                  <p style={{ fontSize: "22px" }}><strong>Location:</strong> {jobPosting.location}</p>
                  <p style={{ fontSize: "22px" }}><strong>Date Posted:</strong> {new Date(jobPosting.datePosted).toLocaleDateString()}</p>
                  <button className="apply-button" onClick={() => handleAddJobOfInterest(jobPosting)}>Apply</button>
                </div>
              </div>
            ))}

           </div>
        ) : (
          <p>No jobs found</p>
        )}
      </>
    </div>
  </div>
);






  }

export default Home;
