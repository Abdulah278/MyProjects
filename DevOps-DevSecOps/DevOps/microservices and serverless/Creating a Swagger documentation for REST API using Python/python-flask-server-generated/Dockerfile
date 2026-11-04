FROM python:3.11-slim

WORKDIR /usr/src/app

# install build deps needed by some Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential libffi-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

ENTRYPOINT ["python3"]
CMD ["-m", "swagger_server"]