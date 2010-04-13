require 'data_paths/data_paths'

require 'spec_helper'
require 'helpers/data'
require 'classes/data_class'
require 'methods_examples'

describe DataPaths do
  describe "instance methods" do
    include DataPaths

    before(:all) do
      @context = self
    end

    it_should_behave_like "Methods"
  end

  describe "class methods" do
    before(:all) do
      @context = DataClass
    end

    it_should_behave_like "Methods"
  end
end
