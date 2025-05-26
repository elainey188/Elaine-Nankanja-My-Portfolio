import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';
import { useNavigate } from 'react-router-dom';

function JobPostings({ jobPostings, handleDelete }) {
  const currentPath = window.location.pathname;
  const navigate = useNavigate();
  const [jobOfInterestList, setJobOfInterestList] = useState([]);

  const handleUpdate = (jobPosting) => {
    navigate('/pages/update', { state: { jobPosting } });
  };

  const handleAddJobOfInterest = (jobPosting) => {
    const updatedJobOfInterestList = [...jobOfInterestList, jobPosting];
    setJobOfInterestList(updatedJobOfInterestList);
    localStorage.setItem('jobOfInterestList', JSON.stringify(updatedJobOfInterestList));
    navigate('/pages/Login');
  };
  

  return (
    <div className="job-listings">
      {!jobPostings ? null : jobPostings.length === 0 ? (
        <div>No job postings yet</div>
      ) : (
        jobPostings.map((jobPosting, index) => (
          <div key={index} className="job-listing">
            <div className="job-header">
              <h4>{jobPosting.job_title}</h4>
              <h3>{jobPosting.company_name}</h3>
              <p>
                <strong>Salary: </strong>
                {jobPosting.salary}
              </p>
              <p>
                <strong>Description: </strong>
                {jobPosting.job_description}
              </p>
              <p>
                <strong>Location: </strong>
                {jobPosting.location}
              </p>
              <p>
                <strong>Industry: </strong>
                {jobPosting.industry}
              </p>
              <p>
                <strong>Type: </strong>
                {jobPosting.job_type}
              </p>
              <p>
                <strong>Date Posted: </strong>
                {jobPosting.datePosted}
              </p>
              {currentPath === '/pages/manage-jobs' ? null : (
                <button className="apply-button" onClick={() => handleAddJobOfInterest(jobPosting)}>
                  Apply
                </button>
              )}
              {currentPath === '/' ? null : (
                <p>
                  <button className="delete-button" onClick={() => handleDelete(jobPosting)}>
                    <FontAwesomeIcon icon={faTrash} /> Delete
                  </button>

                  <button className="update-button" onClick={() => handleUpdate(jobPosting)}>
                    <FontAwesomeIcon icon={faEdit} /> Update
                  </button>
                </p>
              )}
            </div>
          </div>
        ))
      )}
  </div>
  )}

  
export default JobPostings;