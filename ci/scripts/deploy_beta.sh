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

export CURRENT_VERSION=$(jq -r ".version" package.json)
yarn standard-version --prerelease 'rc'
export NEW_VERSION=$(jq -r ".version" package.json)
ruby ./ci/scripts/version.rb $CURRENT_VERSION $NEW_VERSION

gem build fastlane-plugin-test_report.gemspec
gem push *.gem