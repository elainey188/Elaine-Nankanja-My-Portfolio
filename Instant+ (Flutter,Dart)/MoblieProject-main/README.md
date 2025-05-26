# Instant+ - A Smarter Way to Save

**Project for CSCI 4100U - Mobile Devices**

## Overview

**Instant+** is a user-friendly savings app designed to help users achieve their financial goals through virtual "LockBoxes." With flexible savings durations, automated deposits, and real-time goal tracking, Instant+ makes saving intuitive, rewarding, and empowering. Users can create and manage LockBoxes, set financial goals, and track their progress with visual tools and reminders.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
  - [Functional Requirements](#functional-requirements)
  - [Non-functional Requirements](#non-functional-requirements)
- [Evaluation](#evaluation)
  - [Formative Assessment](#formative-assessment)
  - [Summative Assessment](#summative-assessment)
- [Team Members & Responsibilities](#team-members--responsibilities)

## Features

1. **Flexible Savings Durations**  
   Create virtual LockBoxes with customizable durations (1 week, 1 month, or 1 year) using dialog pickers. LockBox details are securely stored, allowing deposits during the lock period and enabling penalty-free withdrawals at the end.

2. **Goal Tracking & Notifications**  
   Set savings goals and track progress with charts and notifications. Users receive reminders for upcoming milestones and lockbox unlock dates.

3. **Automated Recurring Deposits**  
   Automate savings with weekly or monthly deposits. Snackbars confirm successful deposit scheduling and provide an option to undo.

4. **Savings Visualizations**  
   Interactive charts display the growth of savings over time, helping users monitor deposit patterns and progress towards goals.

5. **Penalty-Free Withdrawals**  
   Upon the completion of a LockBox term, users are notified that their funds are available for withdrawal without fees.

6. **User-friendly Management**  
   Snackbars provide feedback on actions like deposit creation and lockbox setup, ensuring users are informed and in control.

## Requirements

### Functional Requirements
- **Multiple Screens and Navigation**: Smooth navigation between different screens for lockbox management.
- **Dialogs and Pickers**: Dialogs for selecting LockBox terms and deposit options.
- **Notifications**: Reminders and updates for savings milestones and unlock dates.
- **Snackbars**: Immediate feedback for deposit actions with an undo option.
- **Local and Cloud Storage**: Securely store savings and goal data locally.
- **HTTP Requests**: API requests for retrieving and updating savings information.

### Non-functional Requirements
- **Work Quality**: Evaluation of development effort and functionality.
- **User Interface Design**: Usable, intuitive, and visually appealing UI.
- **Code and Design Quality**: Clear, maintainable code with adherence to best practices.

## Evaluation

### Formative Assessment
- **Timeline**: Week 9 code commit; marking in Week 10.
- **Purpose**: Early feedback on code quality, UI, and functional features for improvement.
- **Weight**: 15% of the final grade.
- **Criteria**: Functional requirements (12 marks) and non-functional requirements (3 marks).

### Summative Assessment
- **Timeline**: Final marking at the course end.
- **Requirements**: Fully developed app with a ~5-minute individual demo video.
- **Weight**: 30% of the final grade.
  - **Mobile Application**: 25% (group grade)
  - **Individual Demo**: 5%
- **Criteria**: Functional requirements (5 marks) and non-functional requirements (20 marks).

## Team Members & Responsibilities

- **Jason Badwal**:
  - User sign-in/sign-up
  - Firebase database
  - Firebase Authentication
  - Notifications
- **Arujan Srimohan**:
  - Developed data classes
  - UI and back-end integration with data classes
  - Metrics Page
  - Data Visualization   
- **Elaine Nankanja**:
  - Firebase setup for user auth
  - User profile storage
  - Reset password
  - UI
  - Google sign-in 
- **Abdul Rahim Mohsin**:
  - Designed mockup layout
  - Developed UI layout for modern look
  - Smooth navigation between screens
  - Snack bars
  - Intuitive UI integrations
  - Implemented currency API on homepage
- **Rania Rejdal**:
  - Collaborated on mockup design
  - Basic page setup
  - Data classes development
  - UI and data classes integration
