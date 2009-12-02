require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'ostruct'

describe Yammer::Stats do
  
  it "initialises a yammer client" do
    stats = Yammer::Stats.new
    stats.instance_variable_get(:@yammer).should_not be_nil
  end
  
  context "top updaters" do
    
    before(:each) do
      @mock_yammer = mock(Yammer::Client)
      @mock_yammer.stub!("users").and_return([OpenStruct.new(:name => "foo", :stats => OpenStruct.new(:updates => nil))])
      Yammer::Client.stub!("new").and_return(@mock_yammer)
    end
    
    it "can dump results to the screen" do
      stats = Yammer::Stats.new
      File.should_not_receive("open")
      stats.top_updaters(:dump => true)
    end
    
    describe "with files" do
    
      before(:each) do
        @stats = Yammer::Stats.new
        mock_erb = mock(ERB)
        mock_erb.stub!("result")
        ERB.stub!("new").and_return(mock_erb)
      end
    
      it "uses default files if not specified" do
        IO.should_receive("read").with("examples/templates/top_updaters.erb")
        File.should_receive("open").with("top_updaters.xml", 'w')
        @stats.top_updaters
      end
    
      it "reads a specified template" do
        File.stub!("open")      
        IO.should_receive("read").with("foo/bar.erb")
        @stats.top_updaters(:template => "foo/bar.erb")
      end
    
      it "writes to a specified output file" do
        File.should_receive("open").with("foo/myoutput.file", 'w')
        @stats.top_updaters(:output => "foo/myoutput.file")
      end

    end
    
  end
  
end