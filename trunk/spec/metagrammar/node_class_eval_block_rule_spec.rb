require 'rubygems'
require 'spec/runner'

dir = File.dirname(__FILE__)
require "#{dir}/../spec_helper"
require "#{dir}/metagrammar_spec_context_helper"

context "The subset of the metagrammar rooted at the node_class_eval_block rule" do
  include MetagrammarSpecContextHelper
  
  setup do
    @metagrammar = Protometagrammar.new
    @parser = @metagrammar.new_parser
    @metagrammar.root = @metagrammar.nonterminal_symbol(:block)
  end

  specify "parses an empty block" do
    result = @parser.parse('{}')
    result.should be_success
    result.value.should == ""
  end
  
  specify "parses an otherwise empty block with space between the braces" do
    result = @parser.parse('{   }')
    result.should be_success
    result.value.should == "   "
  end

  specify "parses a block with characters other than curly braces between its braces" do
    text = "some_text"
    result = @parser.parse("{#{text}}")
    result.should be_success
    result.value.should == text
  end

  specify "parses a block with Ruby code that uses blocks in it" do
    ruby_code = "[1, 2, 3].map {|x| x + 1}"
    block = "{#{ruby_code}}"
    result = @parser.parse(block)
    result.should be_success
    result.value.should == ruby_code
  end
  
  specify "parses a block with newlines in it" do
    result = @parser.parse("{\ndef a_method\n\nend\n}")
    result.should be_success
  end
  
end