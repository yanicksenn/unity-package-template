#!/bin/bash

replace() {
  label=$1
  key=$2
  files=$3
  
  read -p "$label: " value
  for file in ${files[@]}; do
    sed 's/$key/$value/g' $file
  done
}

files=("package.json" "README.md" "Runtime/__TODO_ASSEMBLY_NAME__.asmdef" "Tests/Runtime/__TODO_TEST_ASSEMBLY_NAME__.asmdef")

replace "Name" "__TODO_NAME__" $files
replace "Version" "__TODO_VERSION__" $files
replace "Display Name" "__TODO_DISPLAY_NAME__" $files
replace "Description" "__TODO_DESCRIPTION__" $files
replace "Author Name" "__TODO_AUTHOR_NAME__" $files
replace "Author Email" "__TODO_AUTHOR_EMAIL__" $files

replace "Assembly Name" "__TODO_ASSEMBLY_NAME__" $files
replace "Assembly Namespace" "__TODO_ASSEMBLY_NAMESPACE__" $files

replace "Test Assembly Name" "__TODO_TEST_ASSEMBLY_NAME__" $files
replace "Test Assembly Namespace" "__TODO_TEST_ASSEMBLY_NAMESPACE__" $files

echo "Setup done."