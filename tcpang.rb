#!/usr/bin/ruby
require 'rubygems'
require 'socket'
require 'timeout'
require 'ipaddress'
require 'optparse'

abort('tcpang.rb 192.168.1.1') unless ARGV[0]

destination_host = ARGV[0]
destination_port = ARGV[1].nil? ? 80 : ARGV[1]
number_of =  ARGV[2].nil? ? 4 : ARGV[2].to_i
delay = 1

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
  return {return: return_type, time: elapsed_time}
end

count = 0
number_of.times do
  response = ping(destination_host, destination_port)
  if response[:return] == "Timeout::TimeoutError"
    puts "Request timeout for host %s count %d" % [destination_host, count]
  else
    puts "%s from %s count=%d time=%f" % [response[:return], destination_host, count, response[:time]]
  end
  count += 1
  sleep delay
end