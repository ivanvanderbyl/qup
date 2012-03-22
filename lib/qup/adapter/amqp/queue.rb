class Qup::Adapter::Amqp
  #
  # Internal: The Qup implementation for a AMQP queue
  #

  autoload :Producer, 'qup/adapter/amqp/producer'
  autoload :Consumer, 'qup/adapter/amqp/consumer'

  class Queue
    include Qup::QueueAPI


    attr_reader :name, :connection

    def initialize(name, connection)
      @name, @connection = name, connection
      @open_messages = {}

      # Constructs a producer for pushing messages onto the queue
      @producer = Qup::Adapter::Amqp::Producer.new(connection, name)
      @consumer = Qup::Adapter::Amqp::Consumer.new(connection, name)

      # TODO: Delay this until needed, probably in #consume
      # @consumer.subscribe
      # @producer.subscribe

      @number_of_messages = 0
      @consumer.queue.status do |number_of_messages, number_of_active_consumers|
        puts number_of_active_consumers
        puts number_of_messages
        @number_of_messages = number_of_messages
      end
    end

    # Public: return the number of Messages on the Queue
    #
    # Returns an integer of the Queue depth
    def depth
      @number_of_messages
    end

    # Public: empty all the messages from the Queue, this does not consume them,
    # this removes the from the Queue
    #
    # Returns nothing
    def flush
      raise NotImplementedError, "please implement 'flush'"
    end


    # Public: destroy the Queue if possible
    #
    # This will clear the Queue and remove it from the system if possible
    #
    # Returns nothing.
    def destroy
      
    end


    # Internal: Put an item onto the Queue
    #
    # message - the data to put onto the queue
    #
    # A user of the Qup API should use a Producer instance to put items onto the
    # queue.
    #
    # Returns the Message that was put onto the Queue
    def produce( message )
      @producer.publish(message)
    end

    # Internal: Retrieve an item from the Queue
    #
    # options - a Hash of options determining how long to wait for a Message
    #           :block   - should we block until a Message is available
    #                      (default: true )
    #           :timeout - how long to wait for a Message, only valid if
    #                      :block is false
    #
    # A user of the Qup API should use a Consumer instance to retrieve items
    # from the Queue.
    #
    # Returns a Message
    def consume(options = {}, &block)
      @consumer.subscribe do |header, payload|
        key = header.properties.message_id
        messgage = Qup::Message.new(key, MultiJson.decode(payload))
        message.instance_variable_set("@header", header)

        @open_messages[message.key] = message
        if block_given? then
          yield_message( message, &block )
        else
          return message
        end
      end
    end


    # Internal: Acknowledge that message is completed and remove it from the
    # Queue.
    #
    # Returns nothing
    def acknowledge( message )
      header = message.instance_variable_get("@header")
      header.ack!
    end

    private

    def yield_message( message, &block )
      yield message
    ensure
      acknowledge( message )
    end

  end
end
