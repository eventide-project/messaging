class Log
  class Error < RuntimeError; end

  extend Registry
  include Levels
  include Level
  include Tags
  include Filter
  include Write
  extend SubjectName
  extend Telemetry::Register

  def self.inherited(cls)
    cls.class_exec do
      dependency_module = Module.new do
        define_singleton_method :included do |reciever_class|
          reciever_class.class_exec do
            dependency :logger, cls

            define_method :logger do
              @logger ||= cls.configure self
            end
          end
        end
      end

      const_set :Dependency, dependency_module
    end
  end

  self.inherited(self)

  dependency :clock, Clock::UTC

  initializer :subject

  attr_writer :device

  def device
    @device ||= Defaults.device
  end

  def telemetry
    @telemetry ||= ::Telemetry.build
  end

  def self.build(subject)
    subject = subject_name(subject)
    instance = new(subject)
    Clock::UTC.configure(instance)
    set_defaults(instance)
    instance
  end

  def self.no_defaults(subject)
    instance = new(subject)
    Clock::UTC.configure(instance)
    instance
  end

  def self.bare(subject)
    no_defaults(subject)
  end

  def self.configure(receiver, attr_name: nil)
    attr_name ||= :logger
    instance = get(receiver)
    receiver.public_send("#{attr_name}=", instance)
    instance
  end

  def call(message=nil, level=nil, tag: nil, tags: nil, &blk)
    tags ||= []
    tags = Array(tags)
    tags << tag unless tag.nil?

    assure_level(level)

    tag!(tags)

    if write?(level, tags)
      if block_given?
        message = blk.call
      end
      raise ArgumentError, "Log message not provided" if message.nil?

      write(message, level, tags)
    end
  end

  def tag!(tags)
    tags
  end

  def write?(message_level, message_tags)
    write_level?(message_level) && write_tag?(message_tags)
  end

  def clear
    level_names.each do |level_name|
      remove_level(level_name)
    end
    self.level = nil
  end

  def self.set_defaults(logger)
    logger.class.add_levels(logger)
    logger.level = Defaults.level
    logger.tags = Defaults.tags
  end
end
