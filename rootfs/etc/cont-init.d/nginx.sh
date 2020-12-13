#!/usr/bin/with-contenv bashio

declare certfile
declare keyfile

bashio::config.require.ssl
if bashio::config.true 'ssl'; then
    certfile=$(bashio::config 'certfile')
    keyfile=$(bashio::config 'keyfile')

    mv /etc/nginx/servers/etebase-ssl.disabled /etc/nginx/servers/etebase.conf
    sed -i "s#%%certfile%%#${certfile}#g" /etc/nginx/servers/etebase.conf
    sed -i "s#%%keyfile%%#${keyfile}#g" /etc/nginx/servers/etebase.conf

else
    mv /etc/nginx/servers/etebase.disabled /etc/nginx/servers/etebase.conf
fi
