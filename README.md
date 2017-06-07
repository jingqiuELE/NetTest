##### Goal
  The Project aims to provide a simulated network with programmable networking topology 
  and link properties. It uses docker and mininet to achieve the goal.

##### Dependency
  The project relies on:
  * Docker
  * Wireshark
  * Only supports Linux operating system.

##### Example topo:
  The topology of the network is:

     10.0.1.100                                                    10.0.3.100
     ==========                 ===============                   ===========
     |        |                 |             |10.0.3.1           |         |
     | client |-------s1--------|eth1 r0  eth3|----------s2-------|  server |
     |        |        10.0.1.1 |             |                   |         |
     |        |                 |    eth2     |                   |         |
     ==========                 ===============                   ===========
                                      |10.0.5.1                
                                      |                            10.0.5.100
                                      |                           =============
                                      |                           |           |
                                      -------------s3-------------|   target  | 
                                                                  |           |
                                                                  =============
##### How to run
  * Change mininet _topo.py_ to suit your needs.
  * Build the docker container of mininet with either of below commands:
      * _$make build_
  * $make run
  * You should be able to see both wireshark and a mininet console.

##### How to observe
  * Start wireshark to observe traffic of the mininet network (You need to have wireshark installed):
    * ./start\_capture.sh
    Please note that there will be two wireshark window opened. One for the traffic to/from target, the other for the traffic to/from the server. This approach tries to avoid duplication of packets reported on mininet switches.
  * Open another console of the mininet container:
    * $docker exec -it mininet bash
  * Observe the network status of each host:
    * mininet>client ip route
    * mininet>client ifconfig -a
    * mininet>client ping 10.0.5.100
  * You can filter the packets in Wireshark by adding filers:
    For example:
    ip.src == 10.0.1.100
  * Copy the programs to be tested to the mininet container.
  * Start the program as needed in mininet console.
  * You can try _nc_ command and _iperf_ command to do bench mark test.
  * To simulate different networking topology, networking jitters
    or limited bandwidth, change _topo.py_ accordingly.

