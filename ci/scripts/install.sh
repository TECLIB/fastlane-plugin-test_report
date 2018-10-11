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

# install node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
     echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo apt-get update && sudo apt-get install yarn

# install dependencies
bundle install --path vendor/bundle

yarn install

# configure git
git config --global user.email $GITHUB_EMAIL
git config --global user.name "Teclib"
git remote remove origin
git remote add origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME.git