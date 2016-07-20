FROM peopleai/highcharts

MAINTAINER Kirill Klenov <horneds@gmail.com>

WORKDIR /app

EXPOSE 3003

VOLUME ["/var/log/people"]

# Default command
CMD ["/app/docker-entrypoint.sh"]

