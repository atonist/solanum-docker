....
docker run -d \
    -p 5000:5000 \
    -p 6665-6669:6665-6669 \
    -p 6697:6697 \
    -p 9999:9999 \
    -v /location/to/solanum/config/:/usr/local/etc \
    -v /location/to/solanum/certs/:/certs \
    -v /location/to/solanum/logs:/usr/local/logs \
    dbrown786/solanum-git:latest
....
