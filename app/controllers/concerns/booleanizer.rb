module Booleanizer
  class ::String
    def to_b
      return true if !self.nil? && (self == true || self.downcase == "true")
      return false if self.nil? || self.downcase == "false" || self == false
      false
    end
  end
end