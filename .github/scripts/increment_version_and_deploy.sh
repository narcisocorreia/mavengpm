#!/bin/bash

# Ensure script stops if there's an error
set -e

# Increment the version number
mvn build-helper:parse-version versions:set \
    -DnewVersion=\${parsedVersion.nextIncrementalVersion} \
    versions:commit

# Extract the new version
new_version=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

# Commit the changes
git add pom.xml
git commit -m "Increment version to $new_version"

# Create a new tag
git tag -a v$new_version -m "Release version $new_version"

# Push changes and tags to GitHub
git push origin main
git push origin v$new_version