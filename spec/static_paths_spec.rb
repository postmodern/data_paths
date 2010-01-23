require 'static_paths/static_paths'

require 'spec_helper'
require 'helpers/static'
require 'classes/static_class'
require 'methods_examples'

describe StaticPaths do
  describe "instance methods" do
    include StaticPaths

    before(:all) do
      @context = self
    end

    it_should_behave_like "Methods"
  end

  describe "class methods" do
    before(:all) do
      @context = StaticClass
    end

    it_should_behave_like "Methods"
  end
end
