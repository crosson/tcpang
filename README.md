# tcpang
Why? Because icmp isn't always appropriate.  
Because other tcp ping applications try to do too much.  
Because often times TCP flows are what we are troubleshooting in the datacenter.  
  
self created tcping. Lazy naming because tcping already exists. Proper option parser to come.  

	./tcpang.rb www.google.com
	3-way OK from www.google.com count=0 time=0.031423
	3-way OK from www.google.com count=1 time=0.015524
	3-way OK from www.google.com count=2 time=0.016099
	3-way OK from www.google.com count=3 time=0.016117
	./tcpang.rb www.google.com 443 6
	3-way OK from www.google.com count=0 time=0.015653
	3-way OK from www.google.com count=1 time=0.023177
	3-way OK from www.google.com count=2 time=0.013706
	3-way OK from www.google.com count=3 time=0.011981
	3-way OK from www.google.com count=4 time=0.013113
	3-way OK from www.google.com count=5 time=0.016602
	./tcpang.rb 1.1.1.1
	Request timeout for host 1.1.1.1 count 0
	Request timeout for host 1.1.1.1 count 1
	Request timeout for host 1.1.1.1 count 2
	Request timeout for host 1.1.1.1 count 3
	 ./tcpang.rb www.google.com 8080
	Request timeout for host www.google.com count 0
	Request timeout for host www.google.com count 1
	Request timeout for host www.google.com count 2
	Request timeout for host www.google.com count 3

* todo: add proper option parser
* todo: figure out why Timeout::timeouterror doesn't raise properly.
