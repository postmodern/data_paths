require 'data_paths/finders'

require 'spec_helper'
require 'helpers/data'

describe DataPaths::Finders do
  before(:all) do
    @example = DataClass.new
  end

  it "should find a file" do
    @example.find_data_file('one.txt').should == File.join(Helpers::DATA_DIRS[0],'one.txt')
  end

  it "should find a directory" do
    @example.find_data_dir('dir').should == File.join(Helpers::DATA_DIRS[0],'dir')
  end

  it "should find all matching files" do
    @example.all_data_files('dir/two.txt').should == [
      File.join(Helpers::DATA_DIRS[0],'dir','two.txt'),
      File.join(Helpers::DATA_DIRS[1],'dir','two.txt')
    ]
  end

  it "should find all matching directories" do
    @example.all_data_dirs('dir').should == [
      File.join(Helpers::DATA_DIRS[0],'dir'),
      File.join(Helpers::DATA_DIRS[1],'dir')
    ]
  end

  it "should find all paths matching a pattern" do
    @example.data_glob('*/*.txt').should == [
      File.join(Helpers::DATA_DIRS[0],'dir','two.txt'),
      File.join(Helpers::DATA_DIRS[1],'dir','two.txt')
    ]
  end
end
