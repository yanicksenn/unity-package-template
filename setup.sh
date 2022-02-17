#!/bin/bash

replace_in_files() {
  local key=$1
  local value=$2
  
  shift
  shift
  
  local files=($*)
  sed -i "" "s/$key/$value/g" "${files[@]}"
}

read_from_input() {
  local label=$1
  
  read -p "$label: " value
  echo "$value"
}

read_and_replace_in_files() {
  local label=$1
  local key=$2
  
  shift
  shift
  
  local files=$*
  
  local value=$(read_from_input "$label")
  
  replace_in_files "$key" "$value" "$files"
  echo "$value"
}

runtime_assembly="Runtime/__TODO_ASSEMBLY_NAME__.asmdef"
runtime_test_assembly="Tests/Runtime/__TODO_TEST_ASSEMBLY_NAME__.asmdef"
files=("package.json" "README.md" "$runtime_assembly" "$runtime_test_assembly")

read_and_replace_in_files "Name" "__TODO_NAME__" "${files[@]}" > /dev/null
read_and_replace_in_files "Version" "__TODO_VERSION__" "${files[@]}" > /dev/null
read_and_replace_in_files "Display Name" "__TODO_DISPLAY_NAME__" "${files[@]}" > /dev/null
read_and_replace_in_files "Description" "__TODO_DESCRIPTION__" "${files[@]}" > /dev/null
read_and_replace_in_files "Author Name" "__TODO_AUTHOR_NAME__" "${files[@]}" > /dev/null
read_and_replace_in_files "Author Email" "__TODO_AUTHOR_EMAIL__" "${files[@]}" > /dev/null

pkg_assembly_name="$(read_and_replace_in_files "Assembly Name" "__TODO_ASSEMBLY_NAME__" "${files[@]}")"
pkg_assembly_namespace="$(read_and_replace_in_files "Assembly Namespace" "__TODO_ASSEMBLY_NAMESPACE__" "${files[@]}")"

replace_in_files "__TODO_TEST_ASSEMBLY_NAME__" "$pkg_assembly_name.Tests" "${files[@]}"
replace_in_files "__TODO_TEST_ASSEMBLY_NAMESPACE__" "$pkg_assembly_namespace.Tests" "${files[@]}"

mv "$runtime_assembly" "Runtime/$pkg_assembly_name.asmdef"
mv "$runtime_test_assembly" "Tests/Runtime/$pkg_assembly_name.Tests.asmdef"

echo "Setup done."
