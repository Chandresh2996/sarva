sudo apt-get update
sudo apt-get install -y libcairo2-dev


python3.9 -m pip install -r requirements.txt
python3.9 manage.py collectstatic --noinput