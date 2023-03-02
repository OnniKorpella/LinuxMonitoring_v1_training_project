#!/bin/bash
chmod +x dop_file
. ./dop_file


if [[ -z $1 ]]; then
    echo "Error 1: You should pass the path" >&2;
    exit 1;
elif (( $# > 1 )); then
    echo "Error 2: You must pass only 1 param and no more" >&2;
    exit 2;
elif [[ ! $1 =~ /$ ]]; then
    echo "Error 3: The path should end with \"/\"" >&2;
    exit 3;
elif [ ! -d "$1" ]; then
    echo "Directory $1 does not exists" >&2;
    exit 4;
fi


START_POINT=$(date +%s%N)
echo "Total number of folders (including all nested ones) = $(find $1 -type d| wc -l)"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
du -h $1 2>/dev/null | sort -hr | head -5 | awk 'BEGIN{i=1}{printf "%d - %s, %s\n", i, $2, $1; i++}'
echo "Total number of files = $(ls -laR $1 2>/dev/null | grep ^- | wc -l)"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $(find $1 2>/dev/null -type f -name "*.conf" | wc -l | awk '{print $1}')"
echo "Text files = $(find $1 2>/dev/null -type f -name "*.txt" | wc -l | awk '{print $1}')"
echo "Executable files = $(find $1 2>/dev/null -type f -executable | wc -l | awk '{print $1}')"
echo "Log files (with the extension .log) = $(find $1 2>/dev/null -type f -name "*.log" | wc -l | awk '{print $1}')"
echo "Archive files = $(find $1 2>/dev/null -type f -name "*.zip" -o -name "*.7z" -o -name "*.rar" -o -name "*.tar" | wc -l | awk '{print $1}')"
echo "Symbolic links = $(find $1 2>/dev/null -type l | wc -l | awk '{print $1}')"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"

top_ten_files_large_weight $1

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"

top_ten_executables_files $1

END_POINT=$(date +%s%N)
DIFF=$(bc -l <<< "scale=1; ($END_POINT - $START_POINT)/1000000000");
echo "Script execution time (in seconds) = $DIFF";
