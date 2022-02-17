#!/bin/bash

replace() {
  label=$1
  key=$2
  files=$3
  
  read -p "$label: " input
  sed -i "" "s/$key/$input/g" ${files[@]}
}

files=(package.json README.md)
replace Name __TODO_NAME__ $files
replace Version __TODO_VERSION__ $files
replace "Display Name" __TODO_DISPLAY_NAME__ $files
replace Description __TODO_DESCRIPTION__ $files
replace "Author Name" __TODO_AUTHOR_NAME__ $files
replace "Author Email" __TODO_AUTHOR_EMAIL__ $files

runtime_assembly=Runtime/__TODO_ASSEMBLY_NAME__.asmdef
test_runtime_assembly=Tests/Runtime/__TODO_test_runtime_assembly_NAME__.asmdef
assemblies=($runtime_assembly $test_runtime_assembly)

replace "Assembly Name" "__TODO_ASSEMBLY_NAME__" $assemblies
replace "Assembly Namespace" "__TODO_ASSEMBLY_NAMESPACE__" $assemblies
mv $runtime_assembly "Runtime/$input.asmdef"

replace "Test Assembly Name" "__TODO_TEST_ASSEMBLY_NAME__" $assemblies
replace "Test Assembly Namespace" "__TODO_TEST_ASSEMBLY_NAMESPACE__" $assemblies
mv $test_runtime_assembly "Tests/Runtime/$input.asmdef"

echo "Setup done."