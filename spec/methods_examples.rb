require 'static_paths/static_paths'

require 'spec_helper'
require 'helpers/static'

shared_examples_for "Methods" do
  before(:all) do
    Helpers::STATIC_DIRS.each do |dir|
      @context.static_dir dir
    end
  end

  it "should list static directories" do
    Helpers::STATIC_DIRS.each do |dir|
      @context.static_paths.include?(dir).should == true
    end
  end

  it "should prevent the addition of non-existant directories" do
    lambda {
      @context.static_dir 'lol'
    }.should raise_error(RuntimeError)
  end

  it "should prevent the addition of non-directories" do
    lambda {
      @context.static_dir __FILE__
    }.should raise_error(RuntimeError)
  end
end
