#!/bin/bash

# Options
PROJECT_NAME="news_crawler"
VENV_NAME="news-crawler"
SETTING_OPTION=""

. ~/.virtualenvs/$VENV_NAME/bin/activate

cat << "EOF"
    ___ _
   /   (_) __ _ _ __   __ _  ___
  / /\ / |/ _` | '_ \ / _` |/ _ \
 / /_//| | (_| | | | | (_| | (_) |
/___,'_/ |\__,_|_| |_|\__, |\___/
     |__/             |___/
   ___             _       _
  / __\ ___   ___ | |_ ___| |_ _ __ __ _ _ __  _ __   ___ _ __
 /__\/// _ \ / _ \| __/ __| __| '__/ _` | '_ \| '_ \ / _ \ '__|
/ \/  \ (_) | (_) | |_\__ \ |_| | | (_| | |_) | |_) |  __/ |
\_____/\___/ \___/ \__|___/\__|_|  \__,_| .__/| .__/ \___|_|
                                        |_|   |_|

This is bootstrap shell script for setup this Django project database, static file, admin user initially.
Please contact administrator when you stuck on the process.

Author : orchwang (github)

EOF

pip_install_confirm() {
    read -r -p "${1:-Install pip libraries from requirements.txt will begin. Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            pip install -r requirements.txt
            echo "Installing Django requirements process success."
            ;;
        *)
            false
            echo "Bootstrap process canceled."
            ;;
    esac
}

migration_confirm() {
    read -r -p "${1:-Django migration process will begin. Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            python3 manage.py makemigrations $SETTING_OPTION
            python3 manage.py migrate $SETTING_OPTION
            echo "Django Migration Model process success."
            ;;
        *)
            false
            echo "Bootstrap process canceled."
            ;;
    esac
}

add_admin_confirm() {
    read -r -p "${1:-It will add Django admin user. Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            read -p 'Username: ' username_var
            read -p 'Email Address: ' email_var
            while true; do
                read -s -p "Password: " password_1
                echo
                read -s -p "Password (again): " password_2
                echo
                [ "$password_1" = "$password_2" ] && break
                echo "Please try again"
            done
            echo "from django.contrib.auth.models import User; User.objects.create_superuser('"$username_var"', '"$email_var"', '"$password_1"')" | python3 manage.py shell $SETTING_OPTION
            echo "Django Registering admin user process success."
            ;;
        *)
            false
            echo "Bootstrap process canceled."
            ;;
    esac
}

collect_static_confirm() {
    read -r -p "${1:-It will run collectstatic command. Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            python3 manage.py collectstatic --noinput $SETTING_OPTION
            echo "Django collect static process success."
            ;;
        *)
            false
            echo "Bootstrap process canceled."
            ;;
    esac
}

pip_install_confirm
migration_confirm
add_admin_confirm
collect_static_confirm