# BabbleBuddyApp
**A modular iOS application built in Swift using SPM and feature-based/clean architecture. Designed for scalability, testability, and team collaboration.**

## Overview
BabbleBuddy is a baby journal tracking iOS application built using modular Swift packages. The architecture supports reusable UI components, isolated feature modules, and clean networking layers.

### Architecture
The project uses a modular architecture with Swift Package Manager, having as main module/entry point app: `BabbleBuddyApp`. Each feature or concern is separated into a module:

- `DesignKit`: Reusable UI components, colors, fonts, icons
- `NetworkingKit`: Handles API calls, decoding, error handling
- `CoreKit`: Shared models, constants, utilities

## Clean Architecture Overview

We follow Clean Architecture principles to ensure **separation of concerns**, **testability**, and **scalability** across our modular app structure.

- **MVVM** is used in the presentation layer to manage UI logic
- **Coordinators** are responsible for handling navigation flow
- **Dependency Injection** is applied across layers for loose coupling and better testability

## Layered Structure

- **Presentation Layer**: SwiftUI/UIKit Views, ViewModels, and Coordinators
- **Domain Layer**: Business logic, Use Cases, and Interactors
- **Data Layer**: Repositories, Network Services (APIs), and local databases

## Architecture Diagram

Below is a visual representation of how responsibilities are split across layers in this project:

![Clean Architecture Overview](https://github.com/user-attachments/assets/63f60eb5-6346-4383-9a7e-56caebf39ea7)
<br><br>
![Clean Architecture in detail](https://github.com/user-attachments/assets/6cb42d21-79d5-4d01-897b-ed4409f7d4b6)

This structure allows each layer to evolve independently, making the app more maintainable and flexible.

## Setup
To start working on the project, you need to clone it by doing:

`git clone https://github.com/cincinnatiai/BabbleBuddyiOS.git` (be sure you are in the right directory where you want to clone it)

If you find an issue when trying to run it, you can:
- change the running version (if the project does not show any proper iOS simulator)
  * Select the BabbleBuddyApp project target
  * Go to "General" tab
  * change the iOS deployment target
  * Run the app (CMD +  R), once the app has been executed, change the iOS version to the latest (optional)
 
### Creating new module
In the case you want to create a new module, you can:
1. Go to File  ->  New  ->  Project
2. Select Framework as template
3. Give a meaningful name
4. When it ask you to select the directory:
   - At the bottom, in the sections "Add to" and "Group", select: BabbleBuddy
5. click Continue.

## GitHub PRs flow
We follow a structured GitHub branching strategy to maintain a clean, collaborative workflow and avoid merge conflicts or instability in the app.

The repository uses the following branches:

- **`main`**  
  Contains stable, production-ready code. Only release-tested code is merged here, typically from `release` or `hotfix` branches.

- **`develop`**  
  The main integration branch for day-to-day development. All `feature` branches are branched from and merged back into `develop`.

- **`prod`** *(optional)*  
  Mirrors the deployed production code. Can be used to track what’s currently live, especially with CI/CD pipelines.

- **`feature/xyz`**  
  Used for developing new features. Created from `develop` and merged back via Pull Requests (PRs) once reviewed and approved.

## PR review guidelines
When creating a Pull Request (PR), please follow these guidelines to ensure consistency and clarity:
- Use a meaningful PR title that describes the change.
- Add a clear description of what the PR is intended to do.
- Explain the solution you've implemented (brief technical summary).
- Provide evidence of the result (screenshots, videos, or before/after comparisons — especially for UI changes or bug fixes).
- If applicable, link to the related ticket (e.g., Jira/Trello).
- If relevant, add a label describing the type of work (bugfix, enhancement, biometrics, etc.).
- Request reviewers for code review.
- Assign the PR to yourself to indicate ownership.

## Acceptance criteria (CI/CD pipeline enforcement to come)
- PR must be approved by all reviewers
- All comments and requested changes must be addressed/resolved.
- All unit tests and UI tests (if applicable) must pass locally.
- New functionality must be covered by tests, if applicable.
- Follow code style and linting rules (e.g., SwiftLint, Prettier).
- No console logs, debug prints, or commented-out code left behind.
- The branch must be up to date with the target branch (develop or main) before merging.
- (Future) All automated CI/CD checks must pass before merging.









