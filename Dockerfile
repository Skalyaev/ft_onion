FROM debian:latest

RUN apt-get update -y \
    && apt-get install -y \
    sudo \
    nginx \
    openssh-server \
    tor

RUN rm -f /etc/nginx/sites-enabled/* && \
    rm -f /var/www/html/* && \
    echo "nginx ALL=(ALL) NOPASSWD: /usr/sbin/service ssh start, /usr/sbin/service tor start" > /etc/sudoers.d/nginx

COPY ./.env                 /.env
COPY ./website/*            /var/www/html/
COPY ./nginx.conf           /etc/nginx/nginx.conf
COPY ./sshd_config          /etc/ssh/sshd_config
COPY ./torrc                /etc/tor/torrc
COPY ./entrypoint.sh        /entrypoint.sh
COPY ./ssh/authorized_keys  /tmp/authorized_keys

RUN useradd -m -s /bin/bash nginx && \
    echo "nginx:$(cat /.env | grep USR_PASS | cut -d '=' -f 2)" | chpasswd && \
    mkdir -p /home/nginx/.ssh && \
    mv /tmp/authorized_keys /home/nginx/.ssh/authorized_keys && \
    chown -R nginx:nginx /home/nginx && \
    chmod 700 /home/nginx/.ssh && \
    chmod 600 /home/nginx/.ssh/authorized_keys && \
    rm -f /.env

RUN chmod +x /entrypoint.sh && \
    touch /run/nginx.pid && \
    chown -R nginx:nginx /run/nginx.pid && \
    chown -R nginx:nginx /var/www/html && \
    chown -R nginx:nginx /var/lib/nginx && \
    chown -R nginx:nginx /var/log/nginx

USER nginx

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
