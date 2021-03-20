#Wireless Networks

#Step 1: Initialize variables
set val(chan)   Channel/WirelessChannel    ;#Channel Type  
set val(prop)   Propagation/TwoRayGround   ;#radio-propargation model 
set val(netif)  Phy/WirelessPhy            ;#network interface type WAVELAN DSSS 2.4GHz
set val(mac)    Mac/802_11		   ;#MAC Type
set val(ifq)    Queue/DropTail/PriQueue    ;#interface queue type
set val(ll)     LL                         ;#link layer type
set val(ant)    Antenna/OmniAntenna        ;#Antenna model
set val(ifqlen) 50                         ;#max packet in ifq
set val(nn)     6			   ;# no. of mobile nodes
set val(rp)     AODV			   ;#Routing Protocol
set val(x)      500			   ;#in meters
set val(y)      500
#Adhoc OnDemand Distance Vector


#Step 2: Creation of Simulator
set ns [new Simulator]

#Step 3: Creation of Trace and Namfile
set tracefile [open wireless.tr w]
$ns trace-all $tracefile

#Step 4: Creation of Network Animation File
set namfile [open wireless.nam w]
$ns namtrace-all-wireless $namfile $val(x) $val(y)
#to create newtrace format
$ns use-newtrace
#Step 5:Creation of Topography (wireless n/w so needs topography)
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)     ;#Flatgrid-nodes are moving on the floor, 2D axis, no user axis.

#Step 6: Creation of General Operation Director (GPD)
create-god $val(nn)	;#god object handles routing, packet exchanges
set channel1 [new $val(chan)]
set channel2 [new $val(chan)]

#Step 7: Configuration of nodes

$ns node-config -adhocRouting $val(rp) \
		-llType $val(ll) \
		-macType $val(mac) \
		-ifqType $val(ifq) \
		-ifqLen $val(ifqlen) \
		-antType $val(ant) \
		-propType $val(prop) \
		-phyType $val(netif) \
		-topoInstance $topo \
		-agentTrace ON \
		-macTrace ON \
		-routerTrace ON \
		-movementTrace ON \
		-energyModel "EnergyModel" \
		-initialEnergy 10.0 \
		-txPower 0.9 \
		-rxPower 0.5 \
		-idlePower 0.45 \
		-sleepPower 0.05 \
		-channel $channel1

set n0 [$ns node]
set n1 [$ns node]		
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 random-motion 0
$n1 random-motion 0
$n2 random-motion 0
$n3 random-motion 0
$n4 random-motion 0
$n5 random-motion 0

$ns initial_node_pos $n0 20
$ns initial_node_pos $n1 20
$ns initial_node_pos $n2 20
$ns initial_node_pos $n3 20
$ns initial_node_pos $n4 20
$ns initial_node_pos $n5 50

#Step 8: Initial coordinates of nodes/Position
$n0 set X_ 10.0
$n0 set Y_ 20.0
$n0 set Z_ 0.0

$n1 set X_ 210.0
$n1 set Y_ 230.0
$n1 set Z_ 0.0

$n2 set X_ 100.0
$n2 set Y_ 200.0
$n2 set Z_ 0.0

$n3 set X_ 150.0
$n3 set Y_ 230.0
$n3 set Z_ 0.0

$n4 set X_ 430.0
$n4 set Y_ 320.0
$n4 set Z_ 0.0

$n5 set X_ 270.0
$n5 set Y_ 120.0
$n5 set Z_ 0.0
#limit x,y=500

#Step 9: Mobility of the nodes (what time, which node,where to, what speed)
$ns at 3.0 "$n1 setdest 490.0 340.0 25.0"
$ns at 3.0 "$n4 setdest 300.0 130.0 5.0"
$ns at 3.0 "$n5 setdest 192.0 440.0 15.0"

$ns at 20.0 "$n5 setdest 100.0 200.0 30.0"


#Step 10: Creation of Agents
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n5 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"

set udp [new Agent/UDP]
set null [new Agent/Null]
$ns attach-agent $n2 $udp
$ns attach-agent $n3 $null
$ns connect $udp $null
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$ns at 1.0 "$cbr start"

$ns at 30.0 "finish"

#Step 11: Finish procedure
proc finish {} {
	global ns tracefile namfile
	$ns flush-trace
	close $tracefile
	close $namfile
	exit 0
}

puts "Starting Simulation..."
$ns run  
