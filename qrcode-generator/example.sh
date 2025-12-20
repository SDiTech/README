# #!/usr/bin/bash

desired_formats=("PNG" "SVG" "UTF8" )

unset -v input_file

while getopts i: opt; do
        case $opt in
                i) input_file=$OPTARG ;;
                *)
                        echo 'Error in command line parsing' >&2
                        exit 1
        esac
done

shift "$(( OPTIND - 1 ))"

create_output_directory() {
   #create an output directory for the files if it doesn't already exist

  local script_directory="$(cd "$(dirname "$0")"; pwd)"
  output_directory="$script_directory/_output"

  if [[ ! -d "${output_directory}" ]]; then
        printf "${output_directory} does not exist\n";
        printf "Creating Directory...\n";
        mkdir -p "${output_directory}";
        printf "Complete\n";
  fi
  return 1;

} 



check_valid_arguments() {
    # check required argument provided
    file_type_check=$(awk -F'.' '{print $2}' <<< "$input_file")
    valid_type=txt

    if [ -z "$input_file" ]; then
            echo 'Missing -i argument option' >&2
            exit 1
    fi
    
    if [[ $file_type_check != $valid_type ]] || [[ ! -f $input_file ]]; then
            echo 'Invalid input file type or input file does not exist' >&2
            exit 1
    fi
}

for format in "${desired_formats[@]}"; do

    create_output_directory
    check_valid_arguments

    output_file=$(awk -F'.' '{print $1}' <<< "$input_file")
    lowercase_format=$(echo "$format" | awk '{print tolower($0)}')

    qrencode -r "$input_file" -t "$format" -o "$output_directory"/"$output_file"."$lowercase_format"

    # Test Code
    # echo "Running Command: qrencode -r $input_file -t $format -o $output_directory/$output_file.$lowercase_format"
done



#debug
# create_output_directory