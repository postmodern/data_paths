require 'data_paths/data_paths'

require 'spec_helper'
require 'helpers/data'
require 'classes/data_class'
require 'methods_examples'

describe DataPaths do
  describe "instance methods" do
    subject { Class.new { include DataPaths } }

    it_should_behave_like "Methods"
  end

  describe "class methods" do
    subject { DataClass }

    it_should_behave_like "Methods"
  end
end
