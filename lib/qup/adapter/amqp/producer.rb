require 'multi_json'
require "uuid"

class Qup::Adapter::Amqp
  class Producer
    attr_reader :name, :type, :routing_key, :options

    def initialize(connection, routing_key, options = {})
      @connection = connection
      @routing_key = routing_key
      @options = options.dup
      @name = @options.delete(:name) || ""
      @type = @options.delete(:type) || "direct"
    end

    def publish(data, options = {})
      message = Qup::Message.new(UUID.generate, data)
      data = MultiJson.encode(data)
      defaults = { :routing_key => routing_key, :properties => { :message_id => message.key } }
      exchange.publish(data, deep_merge(defaults, options))
      message
    end

    protected

    def exchange
      @exchange ||= AMQP::Exchange.new(channel, type.to_sym, name, :durable => true, :auto_delete => false)
    end

    def channel
      @channel ||= AMQP::Channel.new(@connection)
    end

    def deep_merge(hash, other)
      hash.merge(other, &(merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }))
    end

  end
end

