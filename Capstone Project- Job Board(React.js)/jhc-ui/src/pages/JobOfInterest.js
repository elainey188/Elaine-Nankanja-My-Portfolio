import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrash } from '@fortawesome/free-solid-svg-icons';

function JobOfInterest() {
  const [jobOfInterestList, setJobOfInterestList] = useState([]);

  useEffect(() => {
    const storedJobOfInterestList = localStorage.getItem('jobOfInterestList');
    if (storedJobOfInterestList) {
      setJobOfInterestList(JSON.parse(storedJobOfInterestList));
    }
  }, []);

  const handleDelete = (index) => {
    const updatedList = [...jobOfInterestList];
    updatedList.splice(index, 1);
    setJobOfInterestList(updatedList);
    localStorage.setItem('jobOfInterestList', JSON.stringify(updatedList));
  };

  if (!jobOfInterestList || jobOfInterestList.length === 0) {
    return <div><h4>No jobs of interest yet</h4></div>;
  }

  return (
    <div className="job-listings">
      {jobOfInterestList.map((jobPosting, index) => (
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
            <button
  style={{
    backgroundColor: '#007bff',
    color: '#fff',
    border: 'none',
    borderRadius: '5px',
    padding: '5px 20px',
    marginTop: '10px',
    cursor: 'pointer',
    fontSize: '20px',

   
  }}
  onClick={() => handleDelete(jobPosting)}
>
<FontAwesomeIcon icon={faTrash} /> Remove Job
</button>
          </div>
        </div>
      ))}
    </div>
  );
}

export default JobOfInterest;
