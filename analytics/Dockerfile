FROM python:3.10-slim-buster

# Install Postgres and configure a username + password
USER root

# Declare the build arguments
ARG DB_USERNAME
ARG DB_PASSWORD

# Set environment variables so they're available during runtime
ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD

# Install PostgreSQL and dependencies
RUN apt update -y && apt install postgresql postgresql-contrib -y

USER postgres
WORKDIR /db
COPY /db .

# Initialize PostgreSQL with user and database setup
RUN service postgresql start && \
    psql -c "CREATE USER $DB_USERNAME WITH PASSWORD '$DB_PASSWORD';" && \
    psql -c "CREATE DATABASE my_database;" && \
    psql -d my_database -f 1_create_tables.sql && \
    psql -d my_database -f 2_seed_users.sql && \
    psql -d my_database -f 3_seed_tokens.sql && \
    psql -d my_database -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USERNAME;" && \
    psql -d my_database -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USERNAME;"

# Switch to root user to install app dependencies
USER root

WORKDIR /src

# Install Python dependencies
COPY ./analytics/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the app code
COPY analytics/ .

# Start the database and the Flask application
CMD service postgresql start && python app.py