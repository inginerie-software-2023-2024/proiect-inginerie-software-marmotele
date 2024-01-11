# Workout buddy

# Deployment details : 

docker-compose up -d 

Inside mssql container:

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Follyestepisica@12' -Q 'CREATE DATABASE InginerieDB'


dotnet /opt/sqlpackage/sqlpackage.dll /tsn:localhost /tu:SA /tp:'Follyestepisica@12' /A:Import /tdn:InginerieDB /sf:/opt/downloads/df.bacpac



Proiect realizat pentru disciplina "Inginerie Software" din cadrul Facultății de Matematică și Informatică, Universitatea București.

Cerințele din barem pentru livrabilul intermediat se gasesc [aici](https://tinyurl.com/f7u3a3v3) .

## Membrii echipei:

1. [Alexia Aldea](https://github.com/allee15)
2. [Alexandru Andrei]()
3. [George Florea](https://github.com/jovialjoker)
4. [Sergiu Stanciu](https://github.com/Sergiu44)
5. [Dragos Teleaga](https://github.com/dragosteleaga)


## Problem Statement sau Product Vision
### Clear definition of Problem Statement/Product vision

## Problem Statement:

Many individuals struggle to maintain a consistent and organized approach to their gym workouts. Keeping track of exercises, creating custom workout routines, and ensuring data security are common challenges faced by fitness enthusiasts. Existing solutions often lack proper guidance for novice fitness hobbyist that most of the time are overwhelmed with all the fitness information and become confused when it comes to creating a lean and enjoyable path in their fitness journey.

## Product Vision:

**Workout Buddy** aims to revolutionize the way individuals plan, track, and optimize their gym workouts. This all-in-one fitness application is designed to empower users to create, customize, and execute their fitness routines seamlessly. This product incorporates features that are easy to follow and understand. The vision for the product includes:

## Product features and functionalities
### The list of product features and functionalities that deliver value to the stakeholders, aligned with the product vision/problem statement, presented in any form (tabular, diagram, mindmap)
| **Feature/Functionality**          | **Description**                                                                                         | **Status**                  |
|------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------------------|
| User-Friendly Interface            | Intuitive design for easy navigation and a pleasant user experience.                                      | Delivered on 25th November           |
| Customizable Workouts              | Empower users to create personalized workout routines.                                                   | Planned for Delivery        |
| Exercise Management               | CRUD functionality for managing individual exercises.                                                  | Delivered on 25th November              |
| User Accounts                      | Secure user authentication and personalized accounts.                                                   | Delivered on 25th November           |
| Workout Tracking                   | Automatic tracking of completed workouts with visualizations.                                            | Planned for Delivery        |
| Secured Endpoints                  | Implementation of secure endpoints for data protection.                                                 | Delivered on 25th November           |
| Cross-Platform Accessibility       | Availability on web (C# using ASP.NET and Chakra UI) and iOS mobile platforms.                            | Planned for Delivery              |
| Database Integration               | Integration with a reliable and scalable database for data storage.                                      | Delivered on 25th November        |
| Calorie Calculator                 | A service that is capable of calculating the intake calories need by a person based on some parameters   | Delivered on 25th November         |
| Product deployment                 | Making sure the application is deployed so that it can be used world-wide both on mobile and web          | Planned for Delivery             |

# Product Roadmap:

- **Current Release:**
  - User-Friendly Interface
  - Exercise Management
  - User Accounts
  - Database Integration
  - Secured Endpoints
  - Calorie Calculator

- **Upcoming Release:**
  - Customizable Workouts
  - Workout Tracking
  - Cross-Platform Accessibility - iOS mobile application


- **Future Release:**
  - Product deployment

### Identify integration points

1. **Internal Systems:**
   - React App: The React application serves as the user interface and interacts with the REST API to fetch and display data to users.
   - ASP.NET Core REST API: The API, implemented in ASP.NET Core, acts as the middleware between the React app and the MySQL database. It handles requests from the React app, processes business logic, and communicates with the database.
   - MySQL Database: The MySQL database is utilized by the ASP.NET Core API. It stores and retrieves data requested by the React app through the API. Entity Framework is used for data access and management.

2. **External Systems:**
   - Firebase: The MySQL database is seeded to Firebase, an external platform for data storage. This integration provides a backup or an alternative data source, and it may be used for various purposes, such as analytics or mobile application data retrieval.

4. **Data Sources:**
   - MySQL Database: The primary data source for the application, where data is stored and managed. The database is accessed and manipulated by the ASP.NET Core API to fulfill requests from the React app.
   - Firebase Database: Data from the MySQL database is seeded into Firebase, creating an additional data source. This integration may serve purposes beyond the primary data storage, such as providing data to the iOS mobile application.

5. **Other Integration Points:**
   - Entity Framework: The ASP.NET Core API utilizes Entity Framework for seamless communication with the MySQL database. It abstracts the underlying database operations and allows for a more object-oriented approach to data access.
   - iOS Mobile Application: The Firebase data store is used by an iOS mobile application developed by the same team. This application retrieves data stored in Firebase, providing a mobile interface for users to access information from the shared database.

6. **Third-Party Libraries/Frameworks:**
   - Integration with third-party libraries or frameworks for functionalities such as data visualization, analytics, or UI components.





## Non-functional requirements
### Identified NFRs:

1. **Security:**
   - Secure endpoints should adhere to industry standards.
   - Give permission to access certain routes based on credentials
   - Access data/endpoints based on the personal set of user claims

2. **Performance:**
   - The application should compile and load its bundles and files within 3 seconds.
   - Database queries should have a response time of less than 500 milliseconds.
   - The application should run smoothly in a way that the client should not be waiting more than 2 seconds for a page to load

3. **Scalability:**
   - The system should handle a minimum of 10,000 concurrent users.

4. **Integrity:**
   - All numbers and calculations should be considered with an accuracy of 2 decimals
   - The text displayed should be translated in Romanian or English based on user preferences

5. **Availability:**
   - The application will be avaialable wherever you want to use it by installing the mobile version of it
