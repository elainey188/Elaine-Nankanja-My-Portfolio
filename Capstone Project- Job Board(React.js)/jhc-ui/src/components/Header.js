import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faUser } from '@fortawesome/free-solid-svg-icons';

import './header.css';
import logo from '../images/jhc logo.png';

function Header() {
  const [isLoggedIn, setIsLoggedIn] = useState(false); // State to keep track of login status

  // Function to handle user logout
  const handleLogout = () => {
    setIsLoggedIn(false);
  }

  return (
    <header className="header">
      <div className="logo-container">
        <Link to="/">
          <img src={logo} alt="JobHubCentral Logo" className="logo" />
        </Link>
        <h2>JOBHUBCENTRAL</h2>
      </div>
      <nav>
        <ul>
          <li><Link to="/pages/Jobs" className="header-link">My Jobs</Link></li>
          <li><Link to="/pages/Employers" className="header-link">Employers</Link></li>
          <li><Link to="/pages/Login" className="header-link">Sign In</Link></li>
          <li><Link to="/pages/Upload" className="header-link">Upload Resume/Cover Letter</Link></li>
          <Link to="/pages/MyProfile" className="header-link">
  <li><FontAwesomeIcon icon={faUser} /></li>
</Link>

        </ul>
      </nav>
    </header>
  );
}

export default Header;
