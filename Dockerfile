# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install && RAILS_ENV=production rails assets:precompile && RAILS_ENV=production rails db:migrate && RAILS_ENV=production rails db:seed 

# Copy the rest of the application code into the container
COPY . .

# Expose port 3000 (or the port your app listens on)
EXPOSE 3000

# Start your application
CMD ["rails", "server", "-b", "0.0.0.0"]
