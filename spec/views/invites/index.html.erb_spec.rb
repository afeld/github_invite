require 'rails_helper'

RSpec.describe "invites/index", :type => :view do
  before(:each) do
    assign(:invites, [
      Invite.create!(
        :organization_id => 1,
        :organization_name => "Organization Name",
        :team_id => 2,
        :team_name => "Team Name",
        :user_id => 3
      ),
      Invite.create!(
        :organization_id => 1,
        :organization_name => "Organization Name",
        :team_id => 2,
        :team_name => "Team Name",
        :user_id => 3
      )
    ])
  end

  it "renders a list of invites" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Organization Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Team Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
