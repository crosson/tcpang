#!/usr/bin/ruby
require 'rubygems'
require 'socket'
require 'timeout'
require 'optparse'

abort('tcpang.rb 192.168.1.1') unless ARGV[0]
destination_host = ARGV[0]
options = {}
options[:port] = 80
number_of = 4
delay = 1

OptionParser.new do |opts|
  opts.banner = "Usage: tcpang.rb 192.168.1.1 [options]"
  opts.on("-r", "--repeat=val", "delay between pangs", Integer ) { |val| options[:repeat] = val.to_i }
  opts.on("-p", "--port=val", "port. Default is 80", Integer ) { |val| options[:port] = val.to_i }
  opts.on("-d", "--delay=val", "Delay. Default is 1", Integer ) { |val| options[:delay] = val.to_i }
end.parse!

destination_port = options[:port] unless options[:port].nil?
number_of         = options[:repeat] unless options[:repeat].nil?
delay             = options[:delay] unless options[:delay].nil?

def ping(host, port, timeout = 1)
  b_time = Time.now
  return_type = nil
  Timeout::timeout(timeout) do
    begin
			socket = TCPSocket.open(host, port)
      return_type = '3-way OK'
      socket.close
    rescue Exception => exception
      case exception
      when Errno::ECONNREFUSED
        return_type = 'Refused [R.]'
      else
        if exception.inspect.include?("execution expired")
          return_type = "Timeout::TimeoutError"
        else
          return_type = exception.inspect
        end
      end
    end
  end
  e_time = Time.now
  elapsed_time = e_time - b_time
  return {return: return_type, time: elapsed_time * 1000}
end

count = 0
number_of.times do
  response = ping(destination_host, destination_port)
  if response[:return] == "Timeout::TimeoutError"
    puts "Request timeout for host %s count=%d" % [destination_host, count]
  else
    puts "%s from %s count=%d time=%0.3f ms" % [response[:return], destination_host, count, response[:time]]
  end
  count += 1
  sleep delay
end