# Qup (Queue Up)

[copiousfreetime/qup](http://github.com/copiousfreetime/qup)

Qup is a generalized API for Message Queue and Publish/Subscribe messaging
patterns with the ability to plug in an appropriate messaging infrastructure
based upon your needs.

Qup ships with support for [AMQP](http://www.amqp.org/), [Kestrel](https://github.com/robey/kestrel),
[Redis](http://redis.io), and a filesystem infrastructure based on
[Maildir](https://rubygems.org/gems/maildir). Additional Adapters will be
developed as needs arise. [Please submit an
Issue](https://github.com/copiousfreetime/qup/issues) to have a new Adapter
created. Pull requests gladly accepted.

## Features

Qup provides an abstract implementation of two common messaging patterns.

**Basic Message Queue**

> Examples of a basic message queue are [Work/Task
> Queues](http://www.rabbitmq.com/tutorials/tutorial-two-python.html), [JMS
> Queue](http://docs.oracle.com/javaee/6/api/javax/jms/Queue.html), or [Amazon
> SQS](http://aws.amazon.com/sqs/). This is a pattern where one or more
> Producers puts Messages on a Queue and one or more Consumers received those
> Messages. Each Message is delivered only 1 time to a Consumer.



## Installation

Add this line to your application's Gemfile:

    gem 'qup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qup

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
