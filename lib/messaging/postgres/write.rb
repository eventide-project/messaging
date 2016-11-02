module Messaging
  module Postgres
    class Write
      # include Messaging::Write
      include Log::Dependency

      def self.logger
        @logger ||= Log.get(self)
      end

      def self.build_event_writer
        logger.trace "Building event writer"
        logger.debug "Built event writer"
      end
    end
  end
end
