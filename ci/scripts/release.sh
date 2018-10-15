#!/usr/bin/env bash
#
#  LICENSE
# 
#  This file is part of Teclib Fastlane Plugin Test Report.
#
#  Fastlane Plugin Test Report is a subproject of Teclib'
# 
#  Fastlane Plugin Test Report is free software: you can redistribute
#  it and/or modify it under the terms of the MIT License.
#
#  Fastlane Plugin Test Report is distributed in the hope that it will
#  be useful, but WITHOUT ANY WARRANTY; without even the implied 
#  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
#  See the MIT license for further details.
#  -------------------------------------------------------------------
#  @author    Naylin Medina - <nmedina@teclib.com>
#  @copyright Copyright Teclib. All rights reserved.
#  @license   MIT https://opensource.org/licenses/MIT
#  @link      https://github.com/TECLIB/fastlane-plugin-test_report/
#  @link      https://teclib.github.io/fastlane-plugin-test_report/
#  @link      http://www.teclib-edition.com/en/
#  -------------------------------------------------------------------
#

GITHUB_COMMIT_MESSAGE=$(git log --format=oneline -n 1 ${CIRCLE_SHA1})

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* ]]; then

    # Generate CHANGELOG.md and increment version
    IS_PRERELEASE="$( cut -d '-' -f 2 <<< "$CIRCLE_BRANCH" )";

    if [[ $CIRCLE_BRANCH != "$IS_PRERELEASE" ]]; then
        PREFIX_PRERELEASE="$( cut -d '.' -f 1 <<< "$IS_PRERELEASE" )";
        yarn standard-version -m "ci(release): generate CHANGELOG.md for version %s" --prerelease "$PREFIX_PRERELEASE"
    else
        yarn standard-version -m "ci(release): generate CHANGELOG.md for version %s"
    fi

    # Get version number from package.json
    export GIT_TAG=$(jq -r ".version" package.json)
    # Copy CHANGELOG.md to gh-pages branch
    yarn gh-pages -- -m "ci(docs): generate CHANGELOG.md for version ${GIT_TAG}"
    # Push commits and tags to origin branch
    git push --follow-tags origin $CIRCLE_BRANCH
    # Create release with conventional-github-releaser
    yarn conventional-github-releaser -p angular -t $GITHUB_TOKEN

    # get gem path
    GEM=$(find ./ -name '*.gem' | head -1)
    
    # Update release name
    yarn github-release edit \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "Test Report v${GIT_TAG}" \
    
    # Upload example code release
    yarn github-release upload \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "${GIT_TAG}" \
    --file ${GEM}
    
    # Update develop branch
    git fetch origin develop
    git checkout develop
    git clean -d -x -f
    git merge $CIRCLE_BRANCH
    git push origin develop

    # Update master branch
    git fetch origin master
    git checkout master
    git clean -d -x -f
    git merge $CIRCLE_BRANCH
    git push origin master

    # Remove release branch
    #git push origin :$CIRCLE_BRANCH
fi