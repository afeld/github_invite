require 'rails_helper'

RSpec.describe "invites/edit", :type => :view do
  before(:each) do
    @invite = assign(:invite, Invite.create!(
      :organization_id => 1,
      :organization_name => "MyString",
      :team_id => 1,
      :team_name => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit invite form" do
    render

    assert_select "form[action=?][method=?]", invite_path(@invite), "post" do

      assert_select "input#invite_organization_id[name=?]", "invite[organization_id]"

      assert_select "input#invite_organization_name[name=?]", "invite[organization_name]"

      assert_select "input#invite_team_id[name=?]", "invite[team_id]"

      assert_select "input#invite_team_name[name=?]", "invite[team_name]"

      assert_select "input#invite_user_id[name=?]", "invite[user_id]"
    end
  end
end
