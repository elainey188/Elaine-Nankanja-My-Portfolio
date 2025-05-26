import React, { useState } from "react";
import { Link } from "react-router-dom";
import './home.css';
import logo from '../images/jhc logo.png';


const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loginSuccess, setLoginSuccess] = useState(false);
  const [goToUpload, setGoToUpload] = useState(false);

  const handleSubmit = (event) => {
    event.preventDefault();
  
    try {
      const storedEmail = localStorage.getItem('email');
      const storedPassword = localStorage.getItem('password');
  
      if (email === storedEmail && password === storedPassword) {
        setLoginSuccess(true);
        setGoToUpload(true);
      } else {
        setLoginSuccess(true);
        setGoToUpload(true);
      }
    } catch (error) {
      alert("Unable to retrieve stored email and password");
    }
  };
  

  return (
    
    <div className="login-container">
       
      <h1 className="login-heading">Login </h1>
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="email">Email</label>
          <input
            type="email"
            id="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="password">Password</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            required
          />
          <p className="forgot-password-link">
            <Link to="/forgot-password">Forgot password?</Link>
          </p>
        </div>

        <button className="login-button" type="submit">
          Login
        </button>
      </form>
      <p className="login-register-link">
        Don't have an account? <Link to="/pages/Register">Register</Link>
      </p>
      {loginSuccess && (
  <div className="login-popup">
    <div className="login-popup-inner">
      <div className="login-success">
        <p>Login Success!</p>
      </div>
      <div className="login-links">
        <p>
          <Link
            to="/"
            onClick={() => setGoToUpload(false)}
          >
            Return to Home
          </Link>{" "}
          or{" "}
          <Link
            to="/pages/upload"
            onClick={() => setGoToUpload(true)}
          >
            Continue to add Resume/Coverletter
          </Link>
        </p>
      </div>
      <button className="close-popup-button" onClick={() => setLoginSuccess(false)}>X</button>
    </div>
  </div>
)}



    </div>
  );
};

export default Login;
