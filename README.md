# Workout buddy

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

Many individuals struggle to maintain a consistent and organized approach to their gym workouts. Keeping track of exercises, creating custom workout routines, and ensuring data security are common challenges faced by fitness enthusiasts. Existing solutions often lack user-friendly interfaces and comprehensive features, leaving a gap in the market for a robust and intuitive application.

## Product Vision:

**Workout Buddy** aims to revolutionize the way individuals plan, track, and optimize their gym workouts. This all-in-one fitness application is designed to empower users to create, customize, and execute their fitness routines seamlessly. The vision for the product includes:

## Product features and functionalities
### The list of product features and functionalities that deliver value to the stakeholders, aligned with the product vision/problem statement, presented in any form (tabular, diagram, mindmap)
| **Feature/Functionality**          | **Description**                                                                                         | **Status**                  |
|------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------------------|
| User-Friendly Interface            | Intuitive design for easy navigation and a pleasant user experience.                                      | Planned for Delivery           |
| Customizable Workouts              | Empower users to create personalized workout routines.                                                   | Planned for Delivery        |
| Exercise Management               | CRUD functionality for managing individual exercises.                                                  | Planned for Delivery              |
| User Accounts                      | Secure user authentication and personalized accounts.                                                   | Planned for Delivery           |
| Workout Tracking                   | Automatic tracking of completed workouts with visualizations.                                            | Planned for Delivery        |
| Secured Endpoints                  | Implementation of secure endpoints for data protection.                                                 | Planned for Delivery           |
| Cross-Platform Accessibility       | Availability on web (C# using ASP.NET and Chakra UI) and iOS mobile platforms.                            | Planned for Delivery              |
| Database Integration               | Integration with a reliable and scalable database for data storage.                                      | Planned for Delivery        |

# Product Roadmap:

- **Current Release:**
  - User-Friendly Interface
  - User Accounts
  - Database Integration

- **Upcoming Release:**
  - Customizable Workouts
  - Workout Tracking
  - Secured Endpoints


- **Future Release:**
  - Exercise Management
  - Cross-Platform Accessibility


### Identify integration points

1. **Database Integration:**
   - Connection between the application and the database to store and retrieve user data, exercise information, and workout details.

2. **Authentication System:**
   - Integration with an authentication system to ensure secure user access and protect personal information.

3. **External APIs:**
   - Integration with external APIs for features such as exercise data, nutrition information, or fitness tracking devices.

4. **Cross-Platform Integration:**
   - Interaction points between the web version (C# using ASP.NET and Chakra UI) and the iOS mobile app to ensure data consistency and a seamless user experience.

5. **Secure Endpoints:**
   - Integration points where the application communicates with secured endpoints to ensure data privacy and protection during data transmission.

6. **Third-Party Libraries/Frameworks:**
   - Integration with third-party libraries or frameworks for functionalities such as data visualization, analytics, or UI components.





## Non-functional requirements
### Identified NFRs:

1. **Security:**
   - User data must be encrypted during transmission.
   - Secure endpoints should adhere to industry standards.

2. **Performance:**
   - The application should load within 3 seconds.
   - Database queries should have a response time of less than 500 milliseconds.

3. **Scalability:**
   - The system should handle a minimum of 10,000 concurrent users.

### SMART definition of the NFRs

- **Security:**
  - Specific: Encrypt user data during transmission using SSL/TLS.
  - Measurable: Ensure compliance with industry security standards.
  - Achievable: Implement secure coding practices.
  - Relevant: Protect user privacy and data integrity.
  - Time-bound: Complete implementation within the next development sprint.

- **Performance:**
  - Specific: Achieve a page load time of 3 seconds or less.
  - Measurable: Monitor and optimize database queries for a response time under 500 milliseconds.
  - Achievable: Optimize code and utilize caching mechanisms.
  - Relevant: Enhance user experience and engagement.
  - Time-bound: Achieve the specified performance metrics within the next two sprints.

- **Scalability:**
  - Specific: Ensure the system can handle a minimum of 10,000 concurrent users.
  - Measurable: Perform load testing to validate scalability.
  - Achievable: Optimize server infrastructure and application architecture.
  - Relevant: Accommodate future growth in user base.
  - Time-bound: Complete scalability testing and optimization within the next release cycle.
