require 'fastlane/action'
require_relative '../helper/test_report_helper'

module Fastlane
  module Actions
    class TestReportAction < Action
      def self.run(params)
        UI.message("The test_report plugin is working!")
      end

      def self.description
        "customized template for test reports[D[D[D[D[D[D[D[D[D[D[D"
      end

      def self.authors
        ["Naylin Medina"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Create HTML for test reports"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "TEST_REPORT_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
