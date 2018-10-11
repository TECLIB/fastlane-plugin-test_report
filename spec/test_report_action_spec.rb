describe Fastlane::Actions::TestReportAction do
  describe '#run' do

    it 'parse xml with default template' do
      ENV['TEST_REPORT_PATH'] = "../spec/fixture/report.xml"
      ENV['OUTPUT_DIR'] = "../spec/fixture"

      run = Fastlane::FastFile.new.parse("lane :test do
        test_report
      end").runner.execute(:test)

      a = File.read("./spec/fixture/result.html")
      b = File.read("./spec/fixture/index.html")

      File.delete("./spec/fixture/index.html")
      ENV.delete('TEST_REPORT_PATH')
      ENV.delete('OUTPUT_DIR')
    end

    it 'parse xml with custom template' do
      ENV['TEST_REPORT_PATH'] = '../spec/fixture/report.xml'
      ENV['TEMPLATE_PATH'] = "../spec/fixture/template.erb"
      ENV['OUTPUT_DIR'] = '../spec/fixture'

      run = Fastlane::FastFile.new.parse("lane :test do
        test_report
      end").runner.execute(:test)

      a = File.read("./spec/fixture/template.html")
      b = File.read("./spec/fixture/index.html")

      expect(a).to eq(b)

      ENV.delete('TEST_REPORT_PATH')
      ENV.delete('TEMPLATE_PATH')
      ENV.delete('OUTPUT_DIR')
    end
  end
end
