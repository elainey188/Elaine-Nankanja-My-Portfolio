import React, { useState } from 'react';
import "./home.css";
import MyProfile from "./MyProfile";
import { Link, useNavigate } from "react-router-dom";
import logo from '../images/jhc logo.png';

import ProfileRender from './ProfileRender';

const Register = ({ history }) => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isRegistered, setIsRegistered] = useState(false);
  const [location, setLocation] = useState("");
  const [bio, setBio] = useState("");
  const [NavigateToProfile, setNavigateToProfile] = useState(false);

  const navigate = useNavigate();
 


  const handleNavigateToProfile = () => {
    setNavigateToProfile(true);
  };

  
  const handleSubmit = (event) => {
    event.preventDefault();
  
    if (!name || !email || !password || !location) {
      setName("");
      setEmail("");
      setPassword("");
      setLocation("");
      setBio("");
      alert("Please fill in all fields");
    } else {
      const enteredEmail = email.trim();
      const storedEmail = localStorage.getItem('email');
  
      if (storedEmail !== null && storedEmail === enteredEmail) {
       
        console.log('Email already registered!');
        alert('User With This Email Already exists!');
      } else {
        
        localStorage.setItem('email', enteredEmail);
        console.log('Registration successful!');
        setIsRegistered(true);
        localStorage.setItem('user', JSON.stringify({ name, email, location, bio }));
        alert("Registration successful! You can now login.");
        localStorage.setItem('userEmail', email);
      }
  
      console.log(`Name: ${name}, Email: ${email}, Password: ${password}, Location: ${location}`);
    }
  };
  

  const handleAutofill = (event) => {
   
   

    
      event.preventDefault();
      setName('John Doe');
      setEmail('johndoe@example.com');
      setPassword('password');
      setBio('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
      setLocation('San Francisco, CA');
      event.target.reset();

    if (isRegistered) {
      return (
        <MyProfile name={name} email={email} location={location} bio={bio} />
      );
    }
  };


return ( <div style={{ textAlign: "center", maxWidth: "500px", margin: "0 auto", padding: "2rem" }}>
<Link to="/" style={{ float: 'left' }}>
  <img src={logo} alt="JobHubCentral Logo" className="logo" style={{ width: '50px', height: '50px' }} />
</Link>
<h1 style={{ marginBottom: "20px", fontSize: "2em" }}>Register</h1>
{!isRegistered ? (
  <form onSubmit={handleSubmit} onReset={handleAutofill}>
    <div style={{ marginBottom: "20px" }}>
      <label htmlFor="name" style={{ display: "block", fontSize: "1.2em", marginBottom: "5px" }}>Name</label>
      <input type="text" id="name" value={name} onChange={(event) => setName(event.target.value)}
        style={{ width: "100%", padding: "12px", border: "1px solid #ccc", borderRadius: "4px", boxSizing: "border-box", fontSize: "1.2em" }} />
    </div>
    <div style={{ marginBottom: "20px" }}>
      <label htmlFor="email" style={{ display: "block", fontSize: "1.2em", marginBottom: "5px" }}>Email</label>
      <input type="email" id="email" value={email} onChange={(event) => setEmail(event.target.value)}
        style={{ width: "100%", padding: "12px", border: "1px solid #ccc", borderRadius: "4px", boxSizing: "border-box", fontSize: "1.2em" }} />
    </div>
    <div style={{ marginBottom: "20px" }}>
      <label htmlFor="password" style={{ display: "block", fontSize: "1.2em", marginBottom: "5px" }}>Password</label>
      <input type="password" id="password" value={password} onChange={(event) => setPassword(event.target.value)}
        style={{ width: "100%", padding: "12px", border: "1px solid #ccc", borderRadius: "4px", boxSizing: "border-box", fontSize: "1.2em" }} />
    </div>
    <div style={{ marginBottom: "20px" }}>
      <label htmlFor="bio" style={{ display: "block", fontSize: "1.2em", marginBottom: "5px" }}>About Me</label>
      <textarea id="bio" value={bio} onChange={(event) => setBio(event.target.value)}
        style={{ width: "100%", padding: "12px", border: "1px solid #ccc", borderRadius: "4px", boxSizing: "border-box", fontSize: "1.2em" }} />

    </div>
    <div style={{ marginBottom: "20px" }}>
      <label htmlFor="location" style={{ display: "block", fontSize: "1.2em", marginBottom: "5px" }}>Location</label>
      <input type="text" id="location" value={location} onChange={(event) => setLocation(event.target.value)}
        style={{ width: "100%", padding: "12px", border: "1px solid #ccc", borderRadius: "4px", boxSizing: "border-box", fontSize: "1.2em" }} />
    </div>

    <button type="submit"

style={{ backgroundColor: "#3f51b5", color: "#fff", padding: "12px", borderRadius: "4px", fontSize: "1.2em", width: "100%" }}>Register</button>
<button type="reset"
style={{ backgroundColor: "#ccc", color: "#fff", padding: "12px", borderRadius: "4px", fontSize: "1.2em", width: "100%", marginTop: "10px" }}>Autofill</button>
</form>
) : (
<div>


<p style={{ fontSize: "1.5em", fontWeight: "bold" }}> <p>Thanks for registering, {name}!</p>
</p>
<p>Your account has been created.</p>
<a href="/pages/Login" className="login-link">
              Continue to login?
            </a>

            <br />
           <h1>Profile Updated!</h1>
         
     
            <MyProfile name={name} bio={bio} email={email} location={location}  />

</div>
)}

</div>
);
}

export default Register;