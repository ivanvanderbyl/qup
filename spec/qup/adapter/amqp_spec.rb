require 'spec_helper'
require 'qup/shared_adapter_examples'
require 'qup/adapter/amqp_context'

describe 'Qup::Adapter::Amqp', :amqp => true do
  include_context "Qup::Adapter::Amqp"
  it_behaves_like Qup::Adapter
end

