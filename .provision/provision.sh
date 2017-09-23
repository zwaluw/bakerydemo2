#!/usr/bin/env bash


# su - ubuntu    -c "sudo -S true"
# ## su - ubuntu    -c "sudo useradd ubuntu   "
# su - ubuntu    -c "touch /home/ubuntu   /.bashrc"
# su - ubuntu    -c "sudo chown -R ubuntu   :ubuntu    /home/ubuntu   "
PROJECT_NAME=$1

PROJECT_DIR=/home/ubuntu/bakerydemo
VIRTUALENV_DIR=$PROJECT_DIR/venv

PYTHON=$VIRTUALENV_DIR/bin/python3
PIP=$VIRTUALENV_DIR/bin/pip


# Virtualenv setup for project
su - ubuntu    -c "virtualenv --python=python3 $VIRTUALENV_DIR"
# Replace previous line with this if you are using Python 2
# su - ubuntu    -c "virtualenv --python=python2 $VIRTUALENV_DIR"

#su - ubuntu    -c "echo $PROJECT_DIR > $VIRTUALENV_DIR/.project"
su - ubuntu    -c "source $VIRTUALENV_DIR/bin/activate"

# Upgrade PIP
su - ubuntu    -c "$PIP install --upgrade pip"

# Install PIP requirements
su - ubuntu    -c "$PIP install -r $PROJECT_DIR/requirements/base.txt"


# Set execute permissions on manage.py as they get lost if we build from a zip file
chmod a+x $PROJECT_DIR/manage.py

# copy local settings file
cp $PROJECT_DIR/bakerydemo/settings/local.py.example $PROJECT_DIR/bakerydemo/settings/local.py
# add .env file for django-dotenv environment variable definitions
echo DJANGO_SETTINGS_MODULE=$PROJECT_NAME.settings.local > $PROJECT_DIR/.env

# Run syncdb/migrate/load_initial_data/update_index
su - ubuntu    -c "$PYTHON $PROJECT_DIR/manage.py migrate --noinput && \
                 $PYTHON $PROJECT_DIR/manage.py load_initial_data && \
                 $PYTHON $PROJECT_DIR/manage.py update_index"


# Add a couple of aliases to manage.py into .bashrc
# touch /home/ubuntu   /.bashrc
cat << EOF >> /home/ubuntu/.bashrc
export PYTHONPATH=$PROJECT_DIR

#alias dj="./manage.py"
#alias djrun="dj runserver 0.0.0.0:8000"

source $VIRTUALENV_DIR/bin/activate
export PS1="[$PROJECT_NAME \W]\\$ "
cd $PROJECT_DIR
EOF
su - ubuntu -c "sudo ufw allow 8000"
# su - ubuntu    -c "gunicorn --bind 0.0.0.0:8000 $PROJECT_DIR.wsgi:application"

# cat << EOF >> /home/ubuntu   /gunicorn.service

# EOF
# su - ubuntu    -c "sudo mv /home/ubuntu   /gunicorn.service /etc/systemd/system/gunicorn.service"
# su - ubuntu    -c "sudo systemctl start gunicorn && \
# 				 sudo systemctl enable gunicorn"


# su - ubuntu    -c "sudo mv /home/ubuntu   /$PROJECT_NAME /etc/nginx/sites-available/$PROJECT_NAME"
# su - ubuntu    -c "sudo ln -s /etc/nginx/sites-available/$PROJECT_NAME /etc/nginx/sites-enabled"
# su - ubuntu    -c "sudo nginx -t"
# su - ubuntu    -c "sudo systemctl restart nginx"

sudo cp /home/ubuntu/bakerydemo/.provision/gunicorn.conf /etc/systemd/system/gunicorn.service
sudo chmod 644 /etc/systemd/system/gunicorn.service
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

# nginx
sudo apt-get -y install nginx
sudo service nginx start

# set up nginx server
sudo cp /home/ubuntu/bakerydemo/.provision/nginx.conf /etc/nginx/sites-available/site.conf
sudo chmod 644 /etc/nginx/sites-available/site.conf
sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
sudo service nginx start
sudo systemctl restart nginx
# clean /var/www
#sudo rm -Rf /var/www

# symlink /var/www => /vagrant
#ln -s /vagrant /var/www

