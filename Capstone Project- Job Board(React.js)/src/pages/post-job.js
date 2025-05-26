import React, { useState } from 'react';
import './post-job.css';
import { useNavigate} from 'react-router-dom';
import JobPostings from './JobPostings';

function PostJob() {
  const [jobPostings, setJobPostings] = useState(
    JSON.parse(localStorage.getItem('jobPostings') || '[]')
  );
  const [job_title, setJobTitle] = useState('');
  const [company_name, setCompanyName] = useState('');
  const [salary, setSalary] = useState('');
  const [job_description, setJobDescription] = useState('');
  const [location, setLocation] = useState('');
  const [industry, setIndustry] = useState('');
  const [job_type, setJobType] = useState('');
  const [error, setError] = useState('');
  const [newJobPosted, setNewJobPosted] = useState(null);

  const navigate = useNavigate();

  const handleSubmit = (event) => {
    event.preventDefault();

    if (!job_title || !company_name || !job_description || !location || !industry ) {
      setError('Please fill out all required fields');
      return;
    }

    const newJobPosting = {
      job_title,
      company_name,
      salary,
      job_description,
      location,
      industry,
      job_type,
      datePosted: new Date().toLocaleDateString('en-US'),

    };
    
    const updatedJobPostings = [...jobPostings, newJobPosting];
    localStorage.setItem('jobPostings', JSON.stringify(updatedJobPostings));

    setJobPostings(updatedJobPostings);
    setJobTitle('');
    setCompanyName('');
    setSalary('');
    setJobDescription('');
    setLocation('');
    setIndustry('');
    setJobType('');
    setError('');

    setNewJobPosted(newJobPosting);

    setTimeout(() => {
      navigate('/');
    }, 2000);
  };

  const handleDelete = (index) => {
    const updatedJobPostings = [...jobPostings];
    updatedJobPostings.splice(index, 1);
    localStorage.setItem('jobPostings', JSON.stringify(updatedJobPostings));
    setJobPostings(updatedJobPostings);
  };

  const handleApply = (index) => {
    const updatedJobPostings = [...jobPostings];
    updatedJobPostings[index].applicants = updatedJobPostings[index].applicants ? updatedJobPostings[index].applicants + 1 : 1;
    localStorage.setItem('jobPostings', JSON.stringify(updatedJobPostings));
    setJobPostings(updatedJobPostings);
  };

  const canSubmit = job_title && company_name && job_description && location && industry;


    return (
      <div>
      <form onSubmit={handleSubmit}>
        <h1>POST A JOB!</h1>
        {error && <div className="error">{error}</div>}
        <label>
          POSITION:
          <input type="text" name="job_title" value={job_title} onChange={(event) => setJobTitle(event.target.value)} required />
        </label>
         
        <label>
          COMPANY NAME: 
          <input type="text" name="company_name" value={company_name} onChange={(event) => setCompanyName(event.target.value)} required />
        </label>
        <label>
          EXPECTED SALARY:
          <select name="salary" value={salary} onChange={(event) => setSalary(event.target.value)} required>
          <option value="Any">Any</option>
            <option value="Negotiable">Negotiable</option>
            <option value="less than 50000"> Less than 50000</option>
            <option value="50000 - 100000"> 50000 - 100000</option>
            <option value="100000 - 150000"> 100000 - 150000</option>
            <option value="more than 150000"> More than 150000</option>
  </select>
</label>
<label>
DESCRIPTION:
<textarea type="text" name="description" value={job_description} onChange={(event) => setJobDescription(event.target.value)} required />
</label>


<label>
LOCATION:
<input type="text" name="location" value={location} onChange={(event) => setLocation(event.target.value)} required />
</label>
<label>
INDUSTRY
<select id="industry" name="industry" value={industry} onChange={(event) => setIndustry(event.target.value)} required>
<option value="Any">Any</option>
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
<option value="Engineering">Engineering</option>
<option value="Arts">Arts</option>
</select>
</label>
<label>
TYPE:
<select id="jobtype" name="jobtype" value={job_type} onChange={(event) => setJobType(event.target.value)} required>
<option value="Any">Any</option>
<option value="Full-time">Full-Time</option>
<option value="Part-time">Part-Time</option>
<option value="Contract">Contract</option>
<option value="Temporary">Temporary</option>
</select>
</label>
<label></label>
<button type="submit" onClick={handleSubmit}>POST</button>
        </form>
        {newJobPosted && (
        <div className="success">
          Job "{newJobPosted.job_title}" posted successfully!
        </div>
      )}
      
    </div>
  );
}

export default PostJob;