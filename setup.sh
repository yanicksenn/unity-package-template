#!/bin/bash

replace_in_files() {
  key=$1
  value=$2
  files=$3
  
  sed -i "" "s/$key/$value/g" ${files[@]}
}

read_from_input() {
  label=$1
  
  read -p "$label: " value
  echo "$value"
}

read_and_replace_in_files() {
  local label=$1
  local key=$2
  local files=$3
  
  local value=$(read_from_input $label)
  
  replace_in_files "$key" "$value" $files
  echo "$value"
}

runtime_assembly="Runtime/__TODO_ASSEMBLY_NAME__.asmdef"
runtime_test_assembly="Tests/Runtime/__TODO_TEST_ASSEMBLY_NAME__.asmdef"
files=("package.json" "README.md" "$runtime_assembly" "$runtime_test_assembly")

pkg_name="$(read_and_replace_in_files "Name" "__TODO_NAME__" $files)"
pkg_version="$(read_and_replace_in_files "Version" "__TODO_VERSION__" $files)"
pkg_display_name="$(read_and_replace_in_files "Display Name" "__TODO_DISPLAY_NAME__" $files)"
pkg_description="$(read_and_replace_in_files "Description" "__TODO_DESCRIPTION__" $files)"
pkg_author_name="$(read_and_replace_in_files "Author Name" "__TODO_AUTHOR_NAME__" $files)"
pkg_author_email="$(read_and_replace_in_files "Author Email" "__TODO_AUTHOR_EMAIL__" $files)"

pkg_assembly_name="$(read_and_replace_in_files "Assembly Name" "__TODO_ASSEMBLY_NAME__" $files)"
pkg_assembly_namespace="$(read_and_replace_in_files "Assembly Namespace" "__TODO_ASSEMBLY_NAMESPACE__" $files)"

replace_in_files "__TODO_TEST_ASSEMBLY_NAME__" "$pkg_assembly_name.Tests" $files
replace_in_files "__TODO_TEST_ASSEMBLY_NAMESPACE__" "$pkg_assembly_namespace.Tests" $files

mv "$runtime_assembly" "Runtime/$pkg_assembly_name.asmdef"
mv "$runtime_test_assembly" "Tests/Runtime/$pkg_assembly_name.Tests.asmdef"

#runtime_assembly=Runtime/__TODO_ASSEMBLY_NAME__.asmdef
#test_runtime_assembly=Tests/Runtime/__TODO_TEST_ASSEMBLY_NAME__.asmdef
#assemblies=($runtime_assembly $test_runtime_assembly)
#
#replace "Assembly Name" "__TODO_ASSEMBLY_NAME__" $assemblies
#replace "Test Assembly Name" "__TODO_TEST_ASSEMBLY_NAME__" $test_runtime_assembly $input
#
#replace "Assembly Namespace" "__TODO_ASSEMBLY_NAMESPACE__" $assemblies
#mv $runtime_assembly "Runtime/$input.asmdef"
#
#replace "Test Assembly Namespace" "__TODO_TEST_ASSEMBLY_NAMESPACE__" $test_runtime_assembly
#mv $test_runtime_assembly "Tests/Runtime/$input.asmdef"

echo "Setup done."