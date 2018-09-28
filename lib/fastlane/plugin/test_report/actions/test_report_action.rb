require 'fastlane/action'
require_relative '../helper/test_report_helper'
require "erb"
require "nokogiri"

module Fastlane
  module Actions
    class TestReportAction < Action
      def self.run(params)
        UI.message("The test_report plugin is working!")

        report = File.read(File.expand_path(params[:path]))
        doc = Nokogiri::XML(File.open(report))
        test_suite_name = @doc.xpath('//test_suite').attr("name")

        template = '---
        layout: testReport
        ---
        
        <div class="total row">
    <div class="col-sm-12">
        <h2>Test Results</h2>
    </div>
    <div class="col-sm-12">
        <h2> 8 tests</h2>
    </div>
</div>
<% test_suite_name.each do |name| %>
<div>
    <div class="test-suite row failing" onclick="changeDisplay('test-1')">
        <h4 class="col-sm-12"><%= name %></h4>
        <h4 class="col-sm-12">1 tests</h4>
    </div>
<% end %>
    <div id="test-1">

        <div class="failing row">
            <div class="title col-sm-12 dropdown-item">
                <p>testTakeScreenshots</p>
            </div>
            <div class="time col-sm-12 dropdown-item">
                <p>29.457s</p>
            </div>
        </div>
    </div>
</div>'

        result = ERB.new(template).result(binding())

        open('test-report/index.html', 'w') do |f|
          f.puts result
        end

      end

      def self.description
        "Create customized HTML template for test reports"
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
          FastlaneCore::ConfigItem.new(key: :path,
                                  env_name: "TEST_REPORT_PATH",
                               description: "Path to the test report",
                             default_value: './fastlane/test_output/report.xml')
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
