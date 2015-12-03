module Api
  module V1
    class DecodedAuthToken < HashWithIndifferentAccess
      def expired?
        Time.at(self[:exp]) <= 5.minutes.from_now
      end
    end
  end
end
