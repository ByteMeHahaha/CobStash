# CobStash

A React app with a TypeScript API and a COBOL backend for a
general-purpose stash of structured records.

- Author: Ethan Kletschke
- Version: `0.0.3`
- Developed on: Ubuntu (WSL2)
- License: MIT
- Project metadata file: [`project.yaml`](./meta/project.yaml)

---

- [CobStash](#cobstash)
  - [CobStash Plans](#cobstash-plans)
    - [Plans for Backend](#plans-for-backend)
      - [Feature Roadmap](#feature-roadmap)
    - [Plans for API](#plans-for-api)
      - [Feature Roadmap](#feature-roadmap-1)
    - [Plans for Frontend](#plans-for-frontend)
      - [Feature Roadmap](#feature-roadmap-2)

---

## CobStash Plans

CobStash is planned to be a full-stack application with three main parts:

1. COBOL Backend
2. TypeScript API
3. React + TypeScript Frontend

Docker integration through `docker compose` is also planned for this project in
the far future.

### Plans for Backend

The basic idea (and main gimmick) for the backend is that it's actually a
GnuCOBOL app that reads from an `ORGANIZATION INDEXED` file
_(i.e., a file with records identified by a primary key of some sort)_
as opposed to integrating with and connecting to a database like MySQL or
PostgreSQL. The backend reads input from the API via command-line arguments,
performs an operation on the indexed file, and sends output to `stdout`.

#### Feature Roadmap

- [x] Read formatted input from CLI Args
- [x] Basic indexed file handling
  - [x] Creating new record from CLI input
  - [x] Reading existing record from CLI input
  - [x] Updating existing record from CLI input
  - [x] Deleting existing record from CLI input
- [x] Output record contents to `stdout`

### Plans for API

#### Feature Roadmap

_**NB: Full feature checklist will be added to as the API is developed.**_

- [ ] Runs on port 3000
- [x] Spawns a child process of the backend
- [x] Successfully reads `stdout` of the backend
- [ ] Processes frontend requests and formats them into
  valid requests for the backend to read

### Plans for Frontend

The frontend of CobStash will be a fully styled React website that interacts
with the backend through the API.

#### Feature Roadmap

_**NB: Full feature checklist will be added to as the frontend is developed.**_

- [ ] Fully styled with SCSS
- [ ] Makes requests to API
