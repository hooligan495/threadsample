require 'spec_helper'

describe "comments/index.html.erb" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment,
        :title => "Title",
        :body => "Body"
      ),
      stub_model(Comment,
        :title => "Title",
        :body => "Body"
      )
    ])
  end

  it "renders a list of comments" #do
#    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Body".to_s, :count => 2
#  end
end
