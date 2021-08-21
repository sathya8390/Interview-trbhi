
After installing a Docker in instance , use the below Commands to run Elastic search in Docker.

------------------------------------------------

docker pull docker.elastic.co/elasticsearch/elasticsearch:7.14.0

docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.14.0


##########################
Health Check of Elastic Search
########################

#!/bin/bash
mailSentFileFlag="mail_triggered"
status_code=$(curl --write-out %{https_code} --silent --output /dev/null https://test-elastic-server:9200/_cluster/health)
if [[ ( "$status_code" -ne 200 ) && ( ! -f ${mailSentFileFlag} ) ]] ; then
  echo "Elasticsearch is down. Status code $status_code" | mail -s "Elasticsearch monior" "xxxx@gmail.com,xxxx@gmail.com" -r "ElasticSearch Monitor"
  echo "yeah"
  touch ${mailSentFileFlag}
else
  exit 0
fi