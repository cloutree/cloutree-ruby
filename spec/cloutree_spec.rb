require 'minitest/autorun'
require 'minitest/spec'
require File.expand_path('../../lib/cloutree.rb', __FILE__)


describe Cloutree do
  it "should check configuration" do 
    -> { CC.upload("spec/logo.jpg") }.must_raise Cloutree::Error
  end

  it "should check app_key while configuration" do 
    -> { CC.configure(a: 1) }.must_raise Cloutree::Error
  end

  it "should check app_secret while configuration" do
    -> { CC.configure(app_key: 1) }.must_raise Cloutree::Error
  end    
end