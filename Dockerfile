FROM python:3.9.1
WORKDIR /code
COPY requirements.txt .
RUN apt update
RUN apt-get install -y postgresql-contrib
RUN apt-get install -y libpq-dev gcc # this is required as psycopg2 uses pg_config
RUN apt-get install -y python3-dev
RUN export PATH=/usr/lib/postgresql/X.Y/bin/:$PATH
RUN pip install psycopg2-binary
RUN pip install psycopg2
RUN pip install -r requirements.txt
COPY api-smartfolio/ .
CMD [ "python", "./app.py" ]