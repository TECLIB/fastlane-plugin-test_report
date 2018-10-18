#publish new version

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* ]]; then

export CURRENT_VERSION=$(jq -r ".version" package.json)
yarn standard-version
export NEW_VERSION=$(jq -r ".version" package.json)
ruby ./ci/scripts/version.rb $CURRENT_VERSION $NEW_VERSION
gem build fastlane-plugin-test_report.gemspec
gem push *.gem
