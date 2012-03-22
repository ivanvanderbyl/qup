require 'spec_helper'
require 'qup/shared_queue_examples'
require 'qup/adapter/amqp_context'

describe 'Qup::Adapter::Amqp::Queue', :amqp => true do
  include_context "Qup::Adapter::Amqp"
  include_context "Qup::Queue"
  it_behaves_like Qup::QueueAPI
end

