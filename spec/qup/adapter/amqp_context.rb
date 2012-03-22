# The shared context that all the AMQP tests need to run.
# It is assumed that there is an AMQP server running on localhost:5672
shared_context "Qup::Adapter::Amqp" do
  let( :uri     ) { URI.parse( "amqp://localhost:5672/test" ) }
  let( :adapter ) { ::Qup::Adapter::Amqp.new( uri )       }
end
