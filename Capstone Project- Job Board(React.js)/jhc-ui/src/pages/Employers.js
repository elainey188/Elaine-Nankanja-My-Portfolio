import React from "react";
import { Link } from "react-router-dom";
import "./employerDashboard.css";


const EmployerDashboard = () => {
  return (
    <div className="dashboard-container">
    
    <h1>Revolutionize Your Hiring Process</h1>
<p>Find Top Candidates Faster with Our Comprehensive Staffing Tools</p>
      <ul>
        <li><Link to="/pages/post-job">Post a Job</Link></li>
      
        <li><Link to="/pages/manage-jobs">Manage Your Job Postings</Link></li>
        <li><Link to="/pages/view-applicants">View Applicants</Link></li>
      
      </ul>
    </div>
  );
};

export default EmployerDashboard;
