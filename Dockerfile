FROM python:3.9-slim

WORKDIR /app

COPY ./requirements.txt .

# Use "--no-cache-dir" to omit caching and keep the image small
RUN pip install --no-cache-dir -r requirements.txt

# Explicitly show that the folders are directories with the trailing "/"
COPY ./service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app

# Specify the username
USER theia

# Expose the following port
EXPOSE 8080

# Run the service
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]