require 'spec_helper'

describe "containers/new" do
  before(:each) do
    assign(:container, stub_model(Container,
      :name => "MyString",
      :added_by => 1,
      :updated_by => 1
    ).as_new_record)
  end

  it "renders new container form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", containers_path, "post" do
      assert_select "input#container_name[name=?]", "container[name]"
      assert_select "input#container_added_by[name=?]", "container[added_by]"
      assert_select "input#container_updated_by[name=?]", "container[updated_by]"
    end
  end
end
