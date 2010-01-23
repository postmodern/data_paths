require 'static_paths/finders'

require 'spec_helper'
require 'helpers/static'

describe StaticPaths::Finders do
  before(:all) do
    @example = StaticClass.new
  end

  it "should find a file" do
    @example.find_static_file('one.txt').should == File.join(Helpers::STATIC_DIRS[0],'one.txt')
  end

  it "should find a directory" do
    @example.find_static_dir('dir').should == File.join(Helpers::STATIC_DIRS[0],'dir')
  end

  it "should find all matching files" do
    @example.all_static_files('dir/two.txt').should == [
      File.join(Helpers::STATIC_DIRS[0],'dir','two.txt'),
      File.join(Helpers::STATIC_DIRS[1],'dir','two.txt')
    ]
  end

  it "should find all matching directories" do
    @example.all_static_dirs('dir').should == [
      File.join(Helpers::STATIC_DIRS[0],'dir'),
      File.join(Helpers::STATIC_DIRS[1],'dir')
    ]
  end

  it "should find all paths matching a pattern" do
    @example.static_glob_all('*/*.txt').should == [
      File.join(Helpers::STATIC_DIRS[0],'dir','two.txt'),
      File.join(Helpers::STATIC_DIRS[1],'dir','two.txt')
    ]
  end
end
