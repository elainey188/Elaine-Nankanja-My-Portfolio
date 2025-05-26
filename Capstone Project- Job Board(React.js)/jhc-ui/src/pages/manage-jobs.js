import React, { useEffect, useState } from 'react';
import Header from '../components/Header';
import JobPostings from './JobPostings';


function ManageJobs() {
  const [jobPostings, setJobPostings] = useState([]);
 

  useEffect(() => {
    const storedPostings = JSON.parse(localStorage.getItem('jobPostings'));
    if (storedPostings) {
      setJobPostings(storedPostings);
    }
  }, []);

  const handleDelete = (index) => {
    const newJobPostings = [...jobPostings];
    newJobPostings.splice(index, 1);
    setJobPostings(newJobPostings);
    localStorage.setItem('jobPostings', JSON.stringify(newJobPostings));
  }

 


  return (
    <div>
       
      <h1>Manage Jobs</h1>
   
      <JobPostings jobPostings={jobPostings} handleDelete={handleDelete} />
      
    </div>
  );
}

export default ManageJobs;
