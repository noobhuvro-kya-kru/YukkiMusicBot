FROM nikolaik/python-nodejs:python3.9-nodejs18

# Fix broken apt sources if using old Debian base
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy and set working directory
COPY . /app/
WORKDIR /app/

# Install Python deps
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir --requirement requirements.txt

# Start your bot
CMD bash start
