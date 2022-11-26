FROM postgres:9.6

COPY ./create_user.sh /docker-entrypoint-initdb.d/10-create_user.sh
COPY ./create_db.sh     /docker-entrypoint-initdb.d/20-create_db.sh

RUN mkdir -p /var/lib/postgresql/dayly
RUN apt-get update; \
    apt-get install -y cron

COPY ./backup_script.sh /var/lib/postgresql/dayly/backup_script.sh
COPY ./dayly_backup /var/lib/postgresql/dayly/dayly_backup


RUN mkdir -p /var/lib/postgresql/backups/initial
RUN chown -R postgres:postgres /var/lib/postgresql/backups
RUN mkdir -p /var/lib/postgresql/backups/buffer
RUN chown -R postgres:postgres /var/lib/postgresql/backups
RUN chmod 711 /var/lib/postgresql/dayly/backup_script.sh
RUN crontab /var/lib/postgresql/dayly/dayly_backup
