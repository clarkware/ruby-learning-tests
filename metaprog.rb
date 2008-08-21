module Mixin
  
  def self.included(base)
   base.extend(ClassMethods)
   base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :class_variable

    def class_var(s)
      self.class_variable = s
    end
  end
  
  module InstanceMethods
    def instance_method
      puts self.class.class_variable
    end
  end
  
end

class Mike
  
  include Mixin
    
  class_var "bar"
  
end

m = Mike.new
m.instance_method
