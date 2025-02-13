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

<details>
  <summary>Example Response</summary>

  ```json
  {
    "id": 1,
    "sleep_at": "2023-10-10T22:00:00Z",
    "awake_at": null,
    "duration": null
  }
  ```
</details>

### Record Awake

- **URL:** `/sleep-trackers/awake`
- **Method:** `POST`
- **Description:** Records the awake time for the current user.
- **Response:**
    - `200 OK` if the awake time is recorded successfully.
    - `404 Not Found` if no sleep record is found.

<details>
  <summary>Example Response</summary>

  ```json
  {
    "id": 1,
    "sleep_at": "2023-10-10T22:00:00Z",
    "awake_at": "2023-10-11T06:00:00Z",
    "duration": 28800
  }
  ```
</details>

### Followers' Sleep Trackers

- **URL:** `/sleep-trackers/followers`
- **Method:** `GET`
- **Description:** Retrieves the sleep trackers of the current user's followers.
- **Response:**
    - `200 OK` with the list of sleep trackers.

<details>
  <summary>Example Response</summary>

  ```json
  [
    {
      "id": 2,
      "name": "Bob",
      "sleep_at": "2023-10-10T22:00:00Z",
      "awake_at": "2023-10-11T05:00:00Z",
      "duration": 25200
    },
    {
      "id": 3,
      "name": "Charlie",
      "sleep_at": "2023-10-10T22:00:00Z",
      "awake_at": "2023-10-11T04:00:00Z",
      "duration": 21600
    }
  ]
  ```
</details>

### Follow User

- **URL:** `/users/:id/follow`
- **Method:** `POST`
- **Description:** Follows the user with the specified ID.
- **Response:**
  - `200 OK` if the user is followed successfully.
  - `409 Conflict` if the user is already being followed.

<details>
  <summary>Example Response</summary>

  ```json
  {
    "message": "Followed"
  }
  ```
</details>

### Unfollow User

- **URL:** `/users/:id/unfollow`
- **Method:** `POST`
- **Description:** Unfollows the user with the specified ID.
- **Response:**
  - `200 OK` if the user is unfollowed successfully.
  - `409 Conflict` if the user is not being followed.

<details>
  <summary>Example Response</summary>

  ```json
  {
    "message": "Unfollowed"
  }
  ```
</details>

## Authentication

This API uses JWT for authentication. Include the token in the `Authorization` header as follows:

```
Authorization: Bearer <token>
```


## Authentication

This API uses JWT for authentication. Include the token in the `Authorization` header as follows:

```
Authorization: Bearer <token>
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.