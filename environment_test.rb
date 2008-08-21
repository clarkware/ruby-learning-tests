#!/usr/bin/env ruby 

require 'test/unit'

class EnvironmentTest < Test::Unit::TestCase
  
  def test_command_line_args
    assert_not_nil(program_name = $0)
    assert_equal(Array, ARGV.class)
  end
  
  def test_load_path
    load_path = $:
    assert_equal(Array, load_path.class)
    assert(load_path.length > 0)
  end
  
  def test_loaded_files
    loaded_files = $"
    assert_equal(Array, loaded_files.class)
    assert(loaded_files.length > 0)
  end
  
  def test_prepend_load_path
    parent_dir = File.join(File.dirname(__FILE__), '..')
    $:.unshift parent_dir
    assert_equal(parent_dir, $:.first)
  end
  
  def test_rescue_from_exit
    begin
      exit 1
      flunk("Should raise SystemExit")
    rescue SystemExit => ex
      assert_equal("exit", ex.message)
    end    
  end
  
  def test_read_environment_variable
    assert_equal('mike', ENV['USER']) 
    assert_equal(`echo $HOME`.chomp, ENV['HOME'])
  end
  
  def test_update_environment_variable
    assert_equal('mike', ENV['USER']) 
    ENV['USER'] = 'joe-bob' 
    assert_equal('joe-bob', ENV['USER'])    
  end
  
  def test_environment_variable_changes_propogate_to_child_processes
    assert_equal('mike', ENV['USER']) 
    fork do 
      assert_equal('mike', ENV['USER']) 
      ENV['USER'] = 'joe-bob' 
      fork do 
        assert_equal('joe-bob', ENV['USER'])
      end 
      Process.wait 
      assert_equal('joe-bob', ENV['USER']) 
    end 
    Process.wait 
    assert_equal('mike', ENV['USER']) 
  end

end
