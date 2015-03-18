require 'rails_helper'

describe PostPublishingService do

  subject(:service) { described_class.new(post, params) }
  let(:post) { Fabricate(:post) }
  let(:posts_params) { params["post"] }
  let(:user) { 1 }

  context "has publishing time" do
    let(:params) do
      {
        "post" => {
          "title"      => "new post tile",
          "content"    => "new post content"
        },
        "publish_time" => {
          "time_zone"  => "American Samoa",
          "hour"       => "1:00 pm",
          "date"       => "2015-03-20"
        }
      }.with_indifferent_access
    end
    it "#publish_time" do
      expect(service.publish_time.to_s).to eq("2015-03-20 13:00:00 -1100")
    end
  end

  context "already published" do
    let(:params) do
      {
        "post" => {
          "title"      => "new post tile",
          "content"    => "new post content"
        },
        "published"    => true
      }.with_indifferent_access
    end
    it "#publish_time" do
      expect(service.publish_time).to be_within(1.second).of(Time.now)
    end

  end
end
