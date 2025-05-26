import { useState, useEffect } from 'react';

function UserProfile() {
  const [userData, setUserData] = useState(null);


  useEffect(() => {
    fetch('/api/user')
      .then(response => response.json())
      .then(data => setUserData(data));
  }, []);

  return (
    <div className="user-profile">
      {userData ? (
        <>
          <h1>{userData.name}</h1>
          <p>Email: {userData.email}</p>
          <p>Phone: {userData.phone}</p>
        </>
      ) : (
        <p>Loading...</p>
      )}
    </div>
  );
}
