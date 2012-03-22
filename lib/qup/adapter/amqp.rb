require 'qup/adapter'
require 'amqp'
require 'amqp/utilities/event_loop_helper'

class Qup::Adapter
  # Internal: The backing adapter for Qup that uses AMQP message broker
  class Amqp < ::Qup::Adapter

    # Register this adapter as :amqp
    register :amqp

    # Internal: Create a new AMQP Adapter
    #
    # uri - the URI instance for this adapter to use
    def initialize( uri, options = {} )
      @uri        = uri
      @options    = options

      connection
    end

    # Internal: Create a new Queue from this Adapter
    #
    # name - the String name of the Queue
    #
    # Returns a Qup::Queue
    def queue( name )
      Qup::Adapter::Amqp::Queue.new( @uri, name )
    end

    # Internal: Create a new Topic from this Adapter
    #
    # name - the name of this Topic
    #
    # Returns a Qup::Topic
    def topic( name )
      Qup::Adapter::Amqp::Topic.new( @uri, name )
    end

    # Internal: Close the Amqp adapter
    #
    # Return nothing
    def close
      disconnect
    end

    # Internal: Is the Amqp Adapter closed
    #
    # Returns true or false
    def closed?
      @connection.nil?
    end

    private

    def amqp_config(url)
      url = url.to_s unless url.is_a?(String)
      AMQP::Client.parse_connection_uri(url)
    end

    # Internal: Establishes the connection to AMQP
    def connection
      @connection ||= begin
        AMQP::Utilities::EventLoopHelper.run
        AMQP.start(amqp_config(@uri)) do |conn, open_ok|
          conn.on_tcp_connection_loss do |conn, settings|
            puts "[network failure] Trying to reconnect..."
            conn.reconnect(false, 2)
          end
        end
      end
    end

    def disconnect
      if connection
        connection.close if connection.open?
        @connection = nil
      end
    end

  end
end
require 'qup/adapter/amqp/queue'
require 'qup/adapter/amqp/topic'
