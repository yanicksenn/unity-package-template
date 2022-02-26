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

confirm() {
  local message=$1

  read -r -p "$message [y/N]: " response
  case "$response" in
      [yY][eE][sS]|[yY])
          true
          ;;
      *)
          false
          ;;
  esac
}

pkg_name=$(read_from_input "Name")
pkg_version=$(read_from_input "Version")
pkg_display_name=$(read_from_input "Display Name")
pkg_description=$(read_from_input "Description")
pkg_author_name=$(read_from_input "Author Name")
pkg_author_email=$(read_from_input "Author Email")

pkg_assembly_name="$(read_from_input "Assembly Name")"
pkg_assembly_namespace="$(read_from_input "Assembly Namespace")"

pkg_runtime_assembly_name="$pkg_assembly_name"
pkg_runtime_assembly_namespace="$pkg_assembly_namespace"

pkg_test_runtime_assembly_name="$pkg_assembly_name.Tests"
pkg_test_runtime_assembly_namespace="$pkg_assembly_namespace.Tests"

pkg_editor_assembly_name="$pkg_assembly_name.Editor"
pkg_editor_assembly_namespace="$pkg_assembly_namespace.Editor"

pkg_test_editor_assembly_name="$pkg_assembly_name.Editor.Tests"
pkg_test_editor_assembly_namespace="$pkg_assembly_namespace.Editor.Tests"

confirm "Continue with setup?"

runtime_assembly="Runtime/__TODO_ASSEMBLY_NAME__.asmdef"
test_runtime_assembly="Tests/Runtime/__TODO_TEST_ASSEMBLY_NAME__.asmdef"

editor_assembly="Editor/__TODO_ASSEMBLY_EDITOR_NAME__.asmdef"
test_editor_assembly="Tests/Editor/__TODO_TEST_ASSEMBLY_EDITOR_NAME__.asmdef"

files=( \
  "package.json" \
  "README.md" \
  "$runtime_assembly" \
  "$test_runtime_assembly" \
  "$editor_assembly" \
  "$test_editor_assembly")

template_suffix="templ"


echo "Unpacking template files ..."
for file in "${files[@]}"
do
  mv "$file.$template_suffix" "$file"
done


echo "Replacing placeholders ..."
replace_in_files "__TODO_NAME__" "$pkg_name" "${files[@]}"
replace_in_files "__TODO_VERSION__" "$pkg_version" "${files[@]}"
replace_in_files "__TODO_DISPLAY_NAME__" "$pkg_display_name" "${files[@]}"
replace_in_files "__TODO_DESCRIPTION__" "$pkg_description" "${files[@]}"
replace_in_files "__TODO_AUTHOR_NAME__" "$pkg_author_name" "${files[@]}"
replace_in_files "__TODO_AUTHOR_EMAIL__" "$pkg_author_email" "${files[@]}"

replace_in_files "__TODO_ASSEMBLY_NAME__" "$pkg_assembly_name" "${files[@]}"
replace_in_files "__TODO_ASSEMBLY_NAMESPACE__" "$pkg_assembly_namespace" "${files[@]}"

replace_in_files "__TODO_TEST_ASSEMBLY_NAME__" "$pkg_test_runtime_assembly_name" "${files[@]}"
replace_in_files "__TODO_TEST_ASSEMBLY_NAMESPACE__" "$pkg_test_runtime_assembly_namespace" "${files[@]}"

replace_in_files "__TODO_ASSEMBLY_EDITOR_NAME__" "$pkg_editor_assembly_name" "${files[@]}"
replace_in_files "__TODO_ASSEMBLY_EDITOR_NAMESPACE__" "$pkg_editor_assembly_namespace" "${files[@]}"

replace_in_files "__TODO_TEST_ASSEMBLY_EDITOR_NAME__" "$pkg_test_editor_assembly_name" "${files[@]}"
replace_in_files "__TODO_TEST_ASSEMBLY_EDITOR_NAMESPACE__" "$pkg_test_editor_assembly_namespace" "${files[@]}"


echo "Rename file ..."
mv "$runtime_assembly" "Runtime/$pkg_assembly_name.asmdef"
mv "$test_runtime_assembly" "Tests/Runtime/$pkg_assembly_name.Tests.asmdef"
mv "$editor_assembly" "Editor/$pkg_assembly_name.Editor.asmdef"
mv "$test_editor_assembly" "Tests/Editor/$pkg_assembly_name.Editor.Tests.asmdef"

echo "Setup done."
