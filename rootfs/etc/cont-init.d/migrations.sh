#!/usr/bin/with-contenv bashio

INITIAL=1

if [ -f "/data/db.sqlite3" ]; then
  INITIAL=0
fi

cd /etc/server

./manage.py migrate

# usage: manage.py createsuperuser [-h] [--username USERNAME] [--noinput] [--database DATABASE] [--email EMAIL] [--version] [-v {0,1,2,3}] [--settings SETTINGS] [--pythonpath PYTHONPATH] [--traceback] [--no-color] [--force-color]      
  # [--skip-checks]

if [ $INITIAL == 1 ]; then
  bashio::log.info "First startup, creating admin user"
  ./manage.py shell -c "from myauth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')"
fi
