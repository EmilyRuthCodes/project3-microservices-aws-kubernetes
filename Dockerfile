FROM python:3.10-slim-buster

# Switch to root user to install app dependencies
USER root
WORKDIR /src

# Install Python dependencies
COPY ./analytics/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the app code
COPY analytics/ .

# Start the database and the Flask application
CMD python app.py