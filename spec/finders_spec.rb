require 'spec_helper'
require 'helpers/data'

require 'data_paths/finders'

describe DataPaths::Finders do
  subject do
    Class.new {
      include DataPaths
      include DataPaths::Finders
    }.new
  end

  it "should find a file" do
    subject.find_data_file('one.txt').should == File.join(Helpers::DATA_DIRS[0],'one.txt')
  end

  it "should find a directory" do
    subject.find_data_dir('dir').should == File.join(Helpers::DATA_DIRS[0],'dir')
  end

  it "should find all matching files" do
    subject.all_data_files('dir/two.txt').should == [
      File.join(Helpers::DATA_DIRS[0],'dir','two.txt'),
      File.join(Helpers::DATA_DIRS[1],'dir','two.txt')
    ]
  end

  it "should find all matching directories" do
    subject.all_data_dirs('dir').should == [
      File.join(Helpers::DATA_DIRS[0],'dir'),
      File.join(Helpers::DATA_DIRS[1],'dir')
    ]
  end

  it "should find all paths matching a pattern" do
    subject.data_glob('*/*.txt').should == [
      File.join(Helpers::DATA_DIRS[0],'dir','two.txt'),
      File.join(Helpers::DATA_DIRS[1],'dir','two.txt')
    ]
  end
end
