#!/usr/bin/with-contenv bashio

declare port
declare certfile
declare keyfile

port=$(bashio::addon.port 80)
if bashio::var.has_value "${port}"; then
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

    sed -i "s/%%port%%/${port}/g" /etc/nginx/servers/etebase.conf
fi
