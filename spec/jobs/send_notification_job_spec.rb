require 'rails_helper'

RSpec.describe SendNotificationJob, type: :job do
  describe "#perform_later" do
    it "executes the job" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SendNotificationJob.perform_later
      }.to have_enqueued_job
    end
  end
end
