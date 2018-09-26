describe Fastlane::Actions::TestReportAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The test_report plugin is working!")

      Fastlane::Actions::TestReportAction.run(nil)
    end
  end
end
