#!/usr/bin/env bash

OMIT_IMAGES=( 'sdit' 'custom' )

# runtime exec flags
update_flag=''
# migration=''
verbose='false'

print_usage() {
  printf "Usage:\t$> scripts/./seed.sh -[rustdm]
  -u    update stored docker images to latest version\n" ;
}

while getopts 'rustdm:v' flag; do
case "${flag}" in
    u) update_flag='true' ;;
    # m) migration="${OPTARG}" ;;
    v) verbose='true' ;;
    *) print_usage
    exit 1 ;;
esac
done

update_images () {
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
      if [[ $PASS == false ]]; then
        echo "docker image pull \"${image}\"";
      fi
    done;
  fi
}

update_images;
