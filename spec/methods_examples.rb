require 'data_paths/data_paths'

require 'spec_helper'
require 'helpers/data'

shared_examples_for "Methods" do
  before(:all) do
    Helpers::DATA_DIRS.each do |dir|
      subject.register_data_path dir
    end
  end

  it "should list data directories" do
    Helpers::DATA_DIRS.each do |dir|
      subject.data_paths.should include(dir)
    end
  end

  it "should prevent the addition of non-existant directories" do
    lambda {
      subject.register_data_path 'lol'
    }.should raise_error(RuntimeError)
  end

  it "should prevent the addition of non-directories" do
    lambda {
      subject.register_data_path __FILE__
    }.should raise_error(RuntimeError)
  end
end
