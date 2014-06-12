require 'rails_helper'

RSpec.describe "invites/show", :type => :view do
  before(:each) do
    @invite = assign(:invite, Invite.create!(
      :organization_id => 1,
      :organization_name => "Organization Name",
      :team_id => 2,
      :team_name => "Team Name",
      :user_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Organization Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Team Name/)
    expect(rendered).to match(/3/)
  end
end
