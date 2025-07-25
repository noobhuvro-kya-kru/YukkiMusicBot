FROM nikolaik/python-nodejs:python3.9-nodejs18


# Fix archive mirror references across all .list files
RUN find /etc/apt/ -name '*.list' -exec sed -i \
    -e 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' \
    -e 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' {} + && \
    apt-get update -y && \
    apt-get upgrade -y && \
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
