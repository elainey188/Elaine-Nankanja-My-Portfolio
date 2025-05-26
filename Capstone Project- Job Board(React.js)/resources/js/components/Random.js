import React from 'react';
import ReactDOM from 'react-dom';

const jobsData = [
  {
    id: 1,
    title: 'Web Developer',
    company: 'Acme Inc.',
    location: 'New York, NY',
    salary: '$80,000 - $100,000 per year',
    description: 'We are seeking a skilled web developer to join our team and help us build innovative web applications.',
  },
  {
    id: 2,
    title: 'Software Engineer',
    company: 'Widget Corp.',
    location: 'San Francisco, CA',
    salary: '$90,000 - $120,000 per year',
    description: 'We are looking for a talented software engineer to work on our cutting-edge software products.',
  },
  {
    id: 3,
    title: 'Data Analyst',
    company: 'Globex Corp.',
    location: 'Chicago, IL',
    salary: '$70,000 - $90,000 per year',
    description: 'We are seeking a data analyst to help us analyze complex data sets and provide insights for our business.',
  },
];

const JobListing = ({ job }) => {
  return (
    <div>
      <h2>{job.title}</h2>
      <p>{job.company} - {job.location}</p>
      <p>{job.salary}</p>
      <p>{job.description}</p>
    </div>
  );
};

const JobListings = ({ jobs }) => {
  return (
    <div>
      {jobs.map(job => <JobListing job={job} key={job.id} />)}
    </div>
  );
};

const Random = () => {
  return (
    <div>
      <h1>Job Listings</h1>
      <JobListings jobs={jobsData} />
    </div>
  );
};

ReactDOM.render(<Random />, document.getElementById('random'));
