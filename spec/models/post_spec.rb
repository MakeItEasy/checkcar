require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "pre_published_post should be nil" do
    post1 = create(:published_post, catagory: create(:catagory1))
    catagory2 = create(:catagory2)
    post2 = create(:post, catagory: catagory2)
    sleep(1)
    post3 = create(:published_post, catagory: catagory2)
    expect(post3.pre_published_post).to be_nil
  end

  it "pre_published_post should present" do
    catagory = create(:catagory1)
    post1 = create(:published_post, catagory: catagory)
    sleep(1)
    post2 = create(:published_post, catagory: catagory)
    expect(post2.pre_published_post).to eq(post1)
  end

  it "next_published_post should be nil" do
    catagory = create(:catagory1)
    post1 = create(:published_post, catagory: catagory)
    sleep(1)
    post2 = create(:published_post, catagory: catagory)
    expect(post2.next_published_post).to be_nil
  end

  it "next_published_post should present" do
    catagory = create(:catagory1)
    post1 = create(:published_post, catagory: catagory)
    sleep(1)
    post2 = create(:published_post, catagory: catagory)
    expect(post1.next_published_post).to eq(post2)
  end
end
