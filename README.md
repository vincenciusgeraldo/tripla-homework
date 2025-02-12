# Sleep Tracker API

This project is a Sleep Tracker API built with Ruby on Rails. It allows users to record their sleep and awake times, and view sleep trackers of their followers.

## Prerequisites

- Ruby
- Rails
- Bundler
- MySQL

## Setup

1. Clone the repository:

   ```sh
   git clone https://github.com/vincenciusgeraldo/sleep-tracker-api.git
   cd sleep-tracker-api
   ```

2. Install dependencies:

   ```sh
   bundle install
   ```

3. Set up the database:

   ```sh
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the server:

   ```sh
   rails server
   ```

## Running Tests

To run the test suite, use the following command:

```sh
bundle exec rspec
```

## API Endpoints

### Record Sleep

- **URL:** `/sleep-trackers/sleep`
- **Method:** `POST`
- **Description:** Records the sleep time for the current user.
- **Response:**
    - `201 Created` if the sleep record is created successfully.
    - `409 Conflict` if the sleep record is already recorded.

### Record Awake

- **URL:** `/sleep-trackers/awake`
- **Method:** `POST`
- **Description:** Records the awake time for the current user.
- **Response:**
    - `200 OK` if the awake time is recorded successfully.
    - `404 Not Found` if no sleep record is found.

### Followers' Sleep Trackers

- **URL:** `/sleep-trackers/followers`
- **Method:** `GET`
- **Description:** Retrieves the sleep trackers of the current user's followers.
- **Response:**
    - `200 OK` with the list of sleep trackers.

## Authentication

This API uses JWT for authentication. Include the token in the `Authorization` header as follows:

```
Authorization: Bearer <token>
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.