#!/usr/bin/with-contenv bashio

INITIAL=1

if [ -f "/data/db.sqlite3" ]; then
  INITIAL=0
fi

cd /etc/server

./manage.py migrate

if [ $INITIAL == 1 ]; then
  bashio::log.info "First startup, creating admin user"
  ./manage.py shell -c "from myauth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')"
fi
