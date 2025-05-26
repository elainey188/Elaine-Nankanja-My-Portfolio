import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import './App.css';


import Home from './pages/Home';
import Jobs from './pages/JobOfInterest';
import Employers from './pages/Employers';
import Login from './pages/Login';
import Register from './pages/Register';
import Upload from './pages/Upload';
import MyProfile from './pages/MyProfile';
import PostJob from './pages/post-job';
import JobPostings from './pages/JobPostings';
import ManageJobs from './pages/manage-jobs';
import Update from './pages/update';
import ProfileRender from './pages/ProfileRender';
import ViewApplicants from './pages/view-applicants';
import JobOfInterest from './pages/JobOfInterest';
import ForgotPassword from './pages/forgot-password';






function App() {
  const [jobPostings, setJobPostings] = useState([]);
  useEffect(() => {
    const storedJobPostings = JSON.parse(localStorage.getItem('jobPostings'));
    if (storedJobPostings) {
      setJobPostings(storedJobPostings);
    }
  }, []);
  const jobs = [
    {
      id: 1,
      title: 'Front-end Developer',
      company: 'Acme Corp',
      salary: 'Less than 50,000',
      description: 'We are seeking a skilled front-end developer to join our team and help us build beautiful, responsive web applications. As a front-end developer at Acme Corp, you will work closely with our design and back-end teams to implement user interfaces that are both aesthetically pleasing and functional. The ideal candidate will have experience with modern front-end technologies such as React, Angular, or Vue.js, as well as a strong understanding of web development best practices.',
      location: 'San Francisco, CA',
      jobType: 'Full-time',
      industry: 'Technology',
      experienceLevel: 'Mid-level',
      postingDate: '2023-03-11'
    },
    {
      id: 2,
      title: 'Back-end Developer',
      company: 'Globex Corporation',
      salary: '50000 - 100000',
      description: 'We are seeking an experienced back-end developer to join our team and help us build robust and scalable web applications. As a back-end developer at Globex Corporation, you will be responsible for designing, implementing, and maintaining the server-side logic that powers our web applications. The ideal candidate will have a strong understanding of back-end web development frameworks such as Node.js, Django, or Ruby on Rails, as well as experience working with databases and RESTful APIs.',
      location: 'New York, NY',
      jobType: 'Full-time',
      industry: 'Technology',
      experienceLevel: 'Senior-level',
      postingDate: '2023-03-10'
    },
    {
      id: 3,
      title: 'Data Analyst',
      company: 'ABC Consulting',
      salary: 'Less than 50000',
      description: 'We are seeking a data analyst to help us analyze and interpret complex data sets. As a data analyst at ABC Consulting, you will be responsible for collecting, analyzing, and reporting on a variety of data sources to help inform business decisions. The ideal candidate will have experience with data visualization tools such as Tableau or Power BI, as well as a strong understanding of statistical analysis techniques.',
      location: 'Chicago, IL',
      jobType: 'Full-time',
      industry: 'Consulting',
      experienceLevel: 'Entry-level',
      postingDate: '2023-03-09'
    },
    {
      id: 4,
      title: 'Marketing Manager',
      company: 'XYZ Company',
      salary: '100000 - 150000',
      description: 'We are seeking a marketing manager to help us develop and execute marketing strategies that drive growth for our company. As a marketing manager at XYZ Company, you will be responsible for managing our marketing team, as well as developing and implementing campaigns across a variety of channels. The ideal candidate will have experience with digital marketing, as well as a strong understanding of branding and messaging.',
      location: 'Los Angeles, CA',
      jobType: 'Full-time',
      industry: 'Marketing',
      experienceLevel: 'Mid-level',
      postingDate: '2023-03-08'
    },
    {
      id: 5,
      title: 'Software Engineer',
      company: '123 Software',
      salary: 'More than 150000',
      description: 'We are seeking a software engineer to join our team and help us develop high-quality software applications. As a software engineer at 123 Software, you will be responsible for designing, developing, and testing software solutions for our clients. The ideal candidate will have experience with programming languages such as Java, Python, or C++, as well as a strong understanding of software development methodologies and best practices.',
      location: 'Seattle, WA',
      jobType: 'Full-time',
      industry: 'Technology',
      experienceLevel: 'Mid-level',
      postingDate: '2023-03-07'
    },
    {
      id: 6,
title: 'Graphic Designer',
company: 'Design Co.',
salary: 'Less than 50000',
description: 'We are seeking a creative and talented graphic designer to join our team and help us develop visually appealing designs. As a graphic designer at Design Co., you will be responsible for creating visual concepts that communicate ideas that inspire, inform, or captivate our clients audiences. The ideal candidate will have experience with design software such as Adobe Creative Suite, as well as a strong understanding of design principles and trends.',
location: 'Denver, CO',
jobType: 'Full-time',
industry: 'Design',
experienceLevel: 'Entry-level',
postingDate: '2023-03-06'
    },
 
{
id: 7,
title: 'Financial Analyst',
company: 'Financial Services Inc.',
salary: '100000 - 150000',
description: 'We are seeking a financial analyst to join our team and help us analyze financial data and prepare financial reports. As a financial analyst at Financial Services Inc., you will be responsible for gathering and analyzing financial data, creating financial models, and preparing reports for internal and external stakeholders. The ideal candidate will have experience with financial analysis tools such as Excel or SQL, as well as a strong understanding of financial statements and accounting principles.',
location: 'Houston, TX',
jobType: 'Full-time',
industry: 'Finance',
experienceLevel: 'Mid-level',
postingDate: '2023-03-05'
},
{
id: 8,
title: 'Human Resources Manager',
company: 'HR Solutions',
salary: '50000 - 100000',
description: 'We are seeking a human resources manager to join our team and help us manage our employees and their needs. As a human resources manager at HR Solutions, you will be responsible for recruiting and hiring new employees, developing employee policies and procedures, and managing employee benefits and compensation. The ideal candidate will have experience with HR software and tools, as well as a strong understanding of HR best practices and employment laws.',
location: 'Atlanta, GA',
jobType: 'Full-time',
industry: 'Human Resources',
experienceLevel: 'Senior-level',
postingDate: '2023-03-04'
},
{
id: 9,
title: 'Product Manager',
company: 'Product Co.',
salary: 'Less than 50000',
description: 'We are seeking a product manager to join our team and help us develop and launch new products. As a product manager at Product Co., you will be responsible for defining product strategy, conducting market research, and managing the product development lifecycle. The ideal candidate will have experience with product management tools and methodologies, as well as a strong understanding of user experience design and software development processes.',
location: 'San Diego, CA',
jobType: 'Full-time',
industry: 'Product Management',
experienceLevel: 'Senior-level',
postingDate: '2023-03-03'
}

];


  





  return (
    <div className="App">
      
      <Router>
       
        <Routes>
        <Route path="/job-postings" element={<JobPostings jobPostings={jobPostings} />} />
          <Route path="/" element={<Home jobs={jobs}/>} />
          
          <Route path="/pages/Jobs" element={<Jobs />} />
          <Route path="/pages/Employers" element={<Employers />} />
          <Route path="/pages/Login" element={<Login />} />
          <Route path="/pages/Register" element={<Register/>} />
          <Route path="/pages/Upload" element={<Upload />} />
          <Route path="/pages/MyProfile" element={<MyProfile />} />
          <Route path="/pages/post-job" element={<PostJob />} />
          <Route path="/pages/JobPostings" element={<JobPostings />} />
          <Route  path="/job-postings"element={<JobPostings jobs={jobs} />}

        />
        <Route path="/pages/manage-jobs" element={<ManageJobs />}  />
        <Route path="/pages/update" element={<Update />} />
        <Route path="/pages/view-applicants" element={<ViewApplicants />} />
        <Route path="/pages/ProfileRender" element={<ProfileRender />}  /> 
        <Route path="/pages/forgot-password" element={<ForgotPassword />}  />
        <Route path="/pages/JobOfInterest" element={<JobOfInterest />} />

       


        </Routes>
      </Router>
    
  

     
    </div>
    

    
  );
}

export default App;
