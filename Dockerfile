# Use an official Ruby image as the base
FROM ruby:3.2.2

# Install Node.js, Yarn, and required dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn postgresql-client build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Install JavaScript dependencies
RUN yarn install

# Set environment variables for production
ENV RAILS_ENV=production
ENV DISABLE_DATABASE_ENVIRONMENT_CHECK=1

# Add a dummy SECRET_KEY_BASE to avoid errors during precompilation
ARG SECRET_KEY_BASE=dummy_secret_key
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

# Precompile assets for production
RUN bundle exec rails assets:precompile

# Expose the default Rails port
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]