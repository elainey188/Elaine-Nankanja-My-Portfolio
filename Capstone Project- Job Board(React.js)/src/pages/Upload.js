import React, { useState } from 'react';
import { Link } from "react-router-dom";
import logo from '../images/jhc logo.png';

function UploadFiles() {
  const [cvFile, setCvFile] = useState(null);
  const [coverLetterFile, setCoverLetterFile] = useState(null);

  const handleCvUpload = (event) => {
    setCvFile(event.target.files[0]);
  };

  const handleCoverLetterUpload = (event) => {
    setCoverLetterFile(event.target.files[0]);
  };
  const quotes = [
    "Choose a job you love, and you will never have to work a day in your life. - Confucius",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
    "The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. - Steve Jobs",
    "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. - Steve Jobs",
    "The future depends on what you do today. - Mahatma Gandhi",
    "The best way to predict the future is to create it. - Peter Drucker",
    "Work to become, not to acquire. – Elbert Hubbard",
    "Don't confuse having a career with having a life – Hillary Clinton",
    "Be so good they can't ignore you – Steve Martin.",
    "If opportunity doesn't knock, build a door. – Milton Berle."
  ];
  
  const handleSubmit = (event) => {
    event.preventDefault();
   
    const quote = quotes[Math.floor(Math.random() * quotes.length)];
    const message = `Thank you for submitting your files! ${quote}`;
    alert(message);
    window.location.reload();
  };
  


  return (
<div style={{ margin: '50px auto', maxWidth: '600px' }}>
<Link to="/" style={{ float: 'left' }}>
  <img src={logo} alt="JobHubCentral Logo" className="logo" style={{ width: '50px', height: '50px' }} />
</Link>

  <form onSubmit={handleSubmit}>
    <div style={{ marginBottom: '20px' }}>
      <h1 style={{ marginBottom: '10px', fontSize: '24px' }}>Upload your CV</h1>
      <label htmlFor="cv-file" style={{ display: 'inline-block', marginBottom: '10px', fontWeight: 'bold', color: '#333', backgroundColor: 'none' }}>Choose file:</label>
      <input 
  type="file" 
  id="cv-file" 
  onChange={handleCvUpload} 
  style={{ 
    display: 'inline-block', 
    padding: '10px', 
    border: '1px solid #ccc', 
    borderRadius: '5px', 
    backgroundColor: '#fff', 
    color: '#333', 
    fontSize: '16px', 
    fontWeight: 'bold', 
    boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)', 
    cursor: 'pointer' 
  }} 
/>

  
      {cvFile && <p style={{ marginTop: '10px' }}>Selected file: {cvFile.name}</p>}
    </div>

    <div style={{ marginBottom: '20px' }}>
      <h1 style={{ marginBottom: '10px', fontSize: '24px' }}>Upload your Cover Letter</h1>
      <label htmlFor="cover-letter-file" style={{ display: 'inline-block', marginBottom: '10px', fontWeight: 'bold', color: '#333', backgroundColor: 'none' }}>Choose file:</label>
      <input 
  type="file" 
  id="cover-letter-file" 
  onChange={handleCoverLetterUpload} 
  style={{ 
    display: 'inline-block', 
    padding: '10px', 
    border: '1px solid #ccc', 
    borderRadius: '5px', 
    backgroundColor: '#fff', 
    color: '#333', 
    fontSize: '16px', 
    fontWeight: 'bold', 
    boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)', 
    cursor: 'pointer' 
  }} 
/>

     
      {coverLetterFile && <p style={{ marginTop: '10px' }}>Selected file: {coverLetterFile.name}</p>}
    </div>

    <button type="submit" style={{ padding: '10px 20px', backgroundColor: '#007bff', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>Submit</button>
  </form>
</div>

  );
}

export default UploadFiles;
