require "hashr"

class Qup::Adapter::Amqp
  class Consumer
    DEFAULTS = {
      :subscribe => { :ack => true, :blocking => false },
      :queue     => { :durable => true, :exclusive => false },
      :channel   => { :prefetch => 1 },
      :exchange  => { :name => nil, :routing_key => nil }
    }

    attr_reader :name, :options, :subscription

    def initialize(connection, name, options = {})
      @name       = name
      @connection = connection
      @options    = Hashr.new(DEFAULTS.deep_merge(options))
    end

    def subscribe(options = {}, &block)
      options = deep_merge(self.options.subscribe, options)
      puts "subscribing to #{name.inspect} with #{options.inspect}"
      @subscription = queue.subscribe(options, &block)
    end

    def subscribed?
      !!subscription.try(:active?)
    end

    def unsubscribe
      puts "unsubscribing from #{name.inspect}"
      subscription.cancel if subscription.try(:active?)
    end

    def queue
      @queue ||= channel.queue(name, options.queue)

      @queue ||= begin
        queue = channel.queue(name, options.queue)
        if options.exchange.name
          routing_key = options.exchange.routing_key || name
          queue.bind(options.exchange.name, :key => routing_key)
        end
      end
    end

    protected

    def channel
      @channel ||= AMQP::Channel.new(@connection).prefetch(options.channel.prefetch)
    end

    def deep_merge(hash, other)
      hash.merge(other, &(merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }))
    end
  end
end
