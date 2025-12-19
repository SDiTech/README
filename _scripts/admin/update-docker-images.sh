#!/usr/bin/env bash

# This script will address necessary actions with docker which include:
# updating images
# removing images after update
ROOTDIR=$(pwd)
OMIT_IMAGES=( 'sdit' 'custom' 'postgis' 'jupyter' )
# MIGRATIONDIR="${ROOTDIR}/Migrations"

# runtime exec flags
remove_flag=''
update_flag=''
# migration=''
verbose='false'

print_usage() {
  printf "Usage:\t$> scripts/./seed.sh -[rustdm]
  -r    remove untagged images
  -u    update images to latest version\n" ;
}

while getopts 'rustdm:v' flag; do
case "${flag}" in
    r) remove_flag='true' ;;
    u) update_flag='true' ;;
    # m) migration="${OPTARG}" ;;
    v) verbose='true' ;;
    *) print_usage
    exit 1 ;;
esac
done

start_docker () {
  #pgrep -f docker > /dev/null || systemctl start docker
  if ! pgrep -x "docker" > /dev/null
  then
    systemctl start docker;
  fi
}

update_images () {
  # docker image list --format "table {{.Repository}}:{{.Tag}}" | tail -n+2
  if [ $update_flag ]; then
    IMAGES=$(docker image list --format "table {{.Repository}}:{{.Tag}}" | tail -n+2)
    for image in $IMAGES; do
      PASS=false
      for omit in "${OMIT_IMAGES[@]}"; do
        if [[ $image == "${omit}"* ]]; then
        #   echo "${image} found matching ${omit}";
          PASS=true;
        fi
      done;
      if [ $PASS == false ]; then
        docker image pull "${image}";
      fi
    done;
  fi
}

remove_images () {
  if [ $remove_flag ]; then
    docker image prune
  fi
}


start_docker;
update_images;
remove_images;
