FROM williamyeh/java7
# Install Postgres
RUN \
  apt-get update && \
  apt-get install -y postgresql-9.4 postgresql-client-9.4 && \
  rm -rf /var/lib/apt/lists/*
# Add Tomcat and needed files for CMDBuild
ADD files/apps/apache-tomcat-7.0.67.tar.gz /opt
COPY files/configuration/catalina.properties /opt/apache-tomcat-7.0.67/conf/
COPY files/configuration/tomcat-users.xml /opt/apache-tomcat-7.0.67/conf/
COPY files/configuration/setenv.sh /opt/apache-tomcat-7.0.67/bin/
COPY files/libs/postgresql-9.1-901.jdbc4.jar /opt/apache-tomcat-7.0.67/lib/
COPY files/apps/cmdbuild-2.3.4.war /opt/apache-tomcat-7.0.67/webapps/cmdbuild.war
COPY files/configuration/dms.conf /opt/apache-tomcat-7.0.67/webapps/cmdbuild/WEB-INF/conf/
CMD mkdir -p shared/classes && mkdir -p shared/lib
COPY files/configuration/alfresco-global.properties /opt/apache-tomcat-7.0.67/shared/classes/alfresco-global.properties
COPY files/apps/alfresco.war /opt/apache-tomcat-7.0.67/webapps/alfresco.war
COPY files/apps/share.war /opt/apache-tomcat-7.0.67/webapps/share.war
COPY files/scripts/initialize_db.* /tmp/

# Start Postgres configuration
# Create User for Postgres and Change encoding of database
RUN /etc/init.d/postgresql start && \
    su postgres -c "createuser -w -d -r -s cmdbuildsu" && \
    su postgres -c "createdb -O cmdbuildsu cmdbuildsu" && \
    su postgres -c "createdb -O cmdbuildsu alfresco" && \
    su postgres -c "psql -c \"ALTER USER cmdbuildsu WITH PASSWORD 'cmdbuildsu';\"" && \
    su postgres -c "psql -c \"UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';\"" && \
    su postgres -c "psql -c \"DROP DATABASE template1;\"" && \
    su postgres -c "psql -c \"CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';\"" && \
    su postgres -c "psql -c \"UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';\"" && \
    echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf && \
    echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf
#    export PGPASSWORD=cmdbuild psql -U cmdbuild -d cmdbuild -a -f /tmp/initialize_db.sql
#
# Create data directory for Alfresco
CMD mkdir /var/alfresco/data
#
# Finally start Postgres and Tomcat, leave tail to keep the container running
# Could be optimized to use
CMD /etc/init.d/postgresql start && \
    /opt/apache-tomcat-7.0.67/bin/startup.sh && \
    tail -f /opt/apache-tomcat-7.0.67/logs/catalina.out
