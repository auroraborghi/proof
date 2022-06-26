#!/bin/bash
# Script to automate start deployment tasks.

# TODO: Find a way to wait for docker intialization before going forward in the script. HEALTHCHECK might do it. If the container is healthy & running () then continue. until bash script?
    # docker inspect kib01-test --format='{{.State.Status}} will give you the status (created, running, dead, etc.)
# TODO: Create function for google-chrome "http://"
# TODO: Find a way to actually have all of these open in one gnome-terminal window with different tabs.

until [ "$()" == "" ]; do
    sleep 0.1;
done;

# For Elasticsearch Docker deployment error (on their side).
sudo systemctl restart docker
# Start Elasticsearch in new tab and wait for Elasticsearch to complete.
docker run --name es01-test --net elastic -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.14.2
# Start Kibana in new tab and wait for it to complete.
gnome-terminal --tab --title="KIBANA" -- bash -c 'docker run --name kib01-test --net elastic -p 127.0.0.1:5601:5601 -e "ELASTICSEARCH_HOSTS=http://es01-test:9200" docker.elastic.co/kibana/kibana:7.14.2; bash'
# Go to backend folder and run the python virtual environment and FASTAPI in a new tab.
gnome-terminal --tab --title="PYVENV" -- bash -c 'cd ~/Developer/proof/backend/ && source .venv/proof/bin/activate && cd ./tools/ && python run.py; bash'
# Start the python virtual environment and then Jupyter Lab in a new tab.
gnome-terminal --tab --title="JUPYTER" -- bash -c "cd ~/Developer/proof/backend/ && source .venv/proof/bin/activate && jupyter lab; bash"
# Test in a new tab to ensure all services are functional.
gnome-terminal --tab --title="TESTING" -- bash -c 'curl localhost:9200 && google-chrome --new-window && google-chrome "http://localhost:5601" && google-chrome "http://localhost:8000/docs"; exec bash -i'