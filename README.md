
# Interview Project

This repository contains the code for the interview project Book Library web application. Follow the instructions below to set up the application on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- **Git**: For cloning the repository.
- **Ruby**: Version 3.0.6 (use a version manager like RVM or rbenv).
- **Rails**: Version 6.1.7.10.
- **Bundler**: For managing gem dependencies.
- **Node.js**: For managing JavaScript dependencies.
- **Yarn**: For installing JavaScript packages.
- **Docker**: For containerizing the application.
- **Docker Compose**: For running multi-container applications.

## Clone the Repository

Start by cloning the repository to your local machine:

```bash
git clone git@github.com:aldodelgado/interview_project.git
cd interview_project
```

## Install Dependencies

Next, install the required gems and JavaScript packages:

```bash
# Install Ruby dependencies
bundle install

# Install JavaScript dependencies
yarn install
```

## Set Up the Database

This project uses Docker to manage the database. Start by bringing up the Docker containers:

```bash
docker compose up -d
```

Now, create the database, run migrations, and seed it with initial data:

```bash
rails db:create
rails db:migrate
rails db:seed
```

## Start the Server

Finally, you can start the Rails server:

```bash
rails server
```

Now, you can access the application by navigating to [http://localhost:3000](http://localhost:3000) in your web browser.

## Troubleshooting

If you encounter issues while following these steps, consider the following:

- Ensure all prerequisites are installed and configured correctly.
- Check for any error messages in the terminal for hints on what might be going wrong.
- If using Docker, ensure that the Docker daemon is running.


## Assumptions and Trade-Offs Made

Due to time constraints, I was unable to complete the implementation of Turbo and Hotwire. Initially, I focused on understanding ISBN formatting, which took longer than anticipated. I left the Turbo and Hotwire setup for last, assuming it would be a straightforward addition. However, when I began configuring them, I encountered dependency issues with Webpacker, which slowed down progress.
