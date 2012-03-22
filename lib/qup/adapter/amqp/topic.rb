class Qup::Adapter::Amqp
  #
  # Internal: The Qup implementation for a AMQP topic exchange
  #
  class Topic
    include Qup::TopicAPI

    attr_reader :name, :connection

    def initialize(name, connection)
      @name, @connection = name, connection

    end

  end
end

