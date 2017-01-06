require_relative 'test_helper.rb'
require '../lib/district_repo.rb'
require 'csv'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :ha