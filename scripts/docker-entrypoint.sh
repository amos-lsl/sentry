#!/bin/bash
set -ex

if [ ! -f /.bootstrapped-lib ]; then
    # SENTRY_LIGHT_BUILD=1
    pip install -vvv -e .[dev,tests]
    # yarn install
    touch /.bootstrapped
    # make develop
    echo "SUCCESS: Libraries and dependencies installed!"
fi

if [ ! -f /.bootstrapped-sentry ]; then
    sentry upgrade --noinput
    sentry createuser --email=root@localhost --password=admin --superuser --no-input
    echo "User created

    login: root@localhost
    password: admin


    "
    touch /.bootstrapped-sentry
    echo "SUCCESS: Sentry development environment set up" && exit 0
fi

exec "$@"
