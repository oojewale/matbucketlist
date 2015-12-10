module Booleanizer
  class ::String
    def to_b
      return true if !self.nil? && (self == true || downcase == "true")
      return false if self.nil? || downcase == "false" || self == false
      false
    end
  end
end
