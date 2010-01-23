require 'static_paths/static_paths'

require 'spec_helper'
require 'helpers/static'
require 'classes/static_class'

describe StaticPaths do
  include StaticPaths

  it "should list static directories" do
    Helpers::STATIC_DIRS.each do |dir|
      StaticPaths.paths.include?(dir).should == true
    end
  end

  it "should list static directories defined per class/module" do
    Helpers.static_paths.each do |dir|
      Helpers::STATIC_DIRS.include?(dir).should == true
    end
  end

  it "should prevent the addition of non-existant directories" do
    lambda {
      static_dir 'lol'
    }.should raise_error(RuntimeError)
  end

  it "should prevent the addition of non-directories" do
    lambda {
      static_dir __FILE__
    }.should raise_error(RuntimeError)
  end
end
