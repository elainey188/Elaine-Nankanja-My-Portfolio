import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEnvelope, faMapMarkerAlt } from "@fortawesome/free-solid-svg-icons";

function ProfileRender(props) {
 

  

  const { name, bio, email, location } = props;
  const avatarUrls = [
    'https://img.freepik.com/free-icon/priest_318-211734.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/waiter_318-505999.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/student_318-206067.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/business_318-576566.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/student_318-468381.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/businesswoman_318-317790.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/manager_318-210093.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/businessman_318-757984.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/man_318-157531.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/journalist_318-210129.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/user_318-219693.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/maid_318-210090.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/user_318-159714.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/user_318-219692.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/user_318-250953.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-icon/user_318-489769.jpg?size=626&ext=jpg'
  ];

  const randomIndex = Math.floor(Math.random() * avatarUrls.length);
  const randomAvatarUrl = avatarUrls[randomIndex];

  return (
    <div>
      <div className="avatar-frame">
        <img src={randomAvatarUrl} alt="Avatar" />
      </div>
      <h3>{name}</h3>
      <p>{bio}</p>
      <p><FontAwesomeIcon icon={faEnvelope} />{email}</p>
      <p><FontAwesomeIcon icon={faMapMarkerAlt} /> {location}</p>
    </div>
  );
}

export default ProfileRender;
