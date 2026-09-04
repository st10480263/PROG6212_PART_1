# RaceDay - Event Management Platform

## 1. System Overview
**RaceDay** is a web-based, full-stack event management platform designed specifically for the South African road running, cycling, and walking community. Many community and athletic events across South Africa rely on paper forms, manual spreadsheets, and disconnected channels, leaving organisers overwhelmed and participants underserved. 

RaceDay addresses this by providing a unified platform where:
* **Event Organisers** can create and administer events, establish distance categories and entry pricing, and publish official race results.
* **Participants** can discover upcoming races, register for specific distances, view their entry history, and track their performance rankings.

This project represents **Part 1: Architecture, Data Modelling, and API Planning** of a multi-part Portfolio of Evidence (PoE).

---

## 2. System Architecture & Database Model (Section A)

The database schema is fully normalised and comprises **six (6) core relational entities** designed to enforce referential integrity and support future platform expansion:

1. **`Users`**: Stores profile and authentication details for both organisers and participants using role discrimination (`Role = 'Organiser' | 'Participant'`).
2. **`Venue`**: Normalises event locations with city and provincial data.
3. **`Events`**: Central entity created by organisers and hosted at specific venues.
4. **`Categories`**: Represents distinct race distances and pricing tiers per event (e.g., 42.2km Marathon, 21.1km Half, 5km Fun Walk).
5. **`Enrolments`**: Resolves the many-to-many relationship between participants and race categories, recording entry dates and confirmation states.
6. **`Results`**: Stores finish times, finishing ranks, and completion statuses linked directly to individual participant enrolments.

### Entity Relationship Diagram (ERD)
* The official diagram is located in the repository under: [`/docs/PROG_ERD.jpeg`](./docs/PROG_ERD.jpeg) (or `/docs/PROG_ERD.pdf`).

---

## 3. API Endpoint Plan (Section B)

The system exposes a RESTful API structure designed for client integration in Part 2. The endpoint plan covers authentication, user profile management, event creation, participant enrolment, and race result retrieval.

| HTTP Method | Route | Description | Role Required | Request Body (JSON) | Expected Response |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **POST** | `/api/auth/register` | Register a new user account | None (Public) | `{"fullName": "...", "email": "...", "password": "...", "phoneNumber": "...", "role": "Participant"}` | `201 Created` - User created with token |
| **POST** | `/api/auth/login` | Authenticate user and issue JWT | None (Public) | `{"email": "...", "password": "..."}` | `200 OK` - JWT token and role payload; `401 Unauthorized` |
| **GET** | `/api/users/profile` | Retrieve the authenticated user profile | Authenticated | None | `200 OK` - User profile object; `404 Not Found` |
| **PUT** | `/api/users/profile` | Update contact information | Authenticated | `{"phoneNumber": "..."}` | `200 OK` - Updated user record |
| **GET** | `/api/events` | List all upcoming race events | None (Public) | None | `200 OK` - Array of Event objects |
| **POST** | `/api/events` | Create a new race event | Organiser | `{"venueID": 1, "eventName": "...", "eventType": "Running", "eventDate": "2026-11-01"}` | `201 Created` - Event details; `403 Forbidden` |
| **GET** | `/api/events/{id}` | Get event details and categories | None (Public) | None | `200 OK` - Event object with nested categories |
| **POST** | `/api/events/{id}/categories` | Add a distance category to an event | Organiser | `{"categoryName": "21.1km Half", "distance": "21.1 km", "entryFee": "R250.00"}` | `201 Created` - Category object |
| **GET** | `/api/events/{id}/categories` | Get categories for an event | None (Public) | None | `200 OK` - Array of Category objects |
| **POST** | `/api/enrolments` | Enter a participant into an event category | Participant | `{"categoryID": 2}` | `201 Created` - Enrolment details; `409 Conflict` (Already entered) |
| **GET** | `/api/enrolments/my-entries` | View logged-in user's race entries | Participant | None | `200 OK` - Array of participant enrolments |
| **POST** | `/api/results` | Record official participant race result | Organiser | `{"enrolmentID": 1, "finishTime": "01:48:22", "position": "42", "status": "Finished"}` | `201 Created` - Result record; `400 Bad Request` |
| **GET** | `/api/results/event/{eventId}` | View public event leaderboard | None (Public) | None | `200 OK` - Sorted leaderboard array |
| **GET** | `/api/results/my-history` | View personal race performance history | Participant | None | `200 OK` - Historic result records |

---

## 4. Database Setup & Execution (Section C)

The database script creates the `Prog_Database` database, establishes all relational tables with appropriate constraints (Primary Keys, Foreign Keys, and Not Nulls), and populates realistic seed data.

### Prerequisites
* Microsoft SQL Server Management Studio (SSMS) 19 or later / Azure Data Studio.

* <img width="1132" height="394" alt="Screenshot 2026-09-04 214350" src="https://github.com/user-attachments/assets/a73b39b9-b6ff-4243-a6f4-5af5997bbadf" />

