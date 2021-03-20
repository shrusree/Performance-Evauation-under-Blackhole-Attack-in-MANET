# Define options
set val(chan)        		   Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             10                          ;# number of mobilenodes
set val(rp)             DSDV                       ;# routing protocol
set val(x)              900   			   ;# X dimension of topography
set val(y)              800   			   ;# Y dimension of topography  
set val(stop)		20.0			   ;# time of simulation end

set ns		  [new Simulator]
set tracefd       [open DSDVdown.tr w]
set windowVsTime2 [open win.tr w] 
set namtrace      [open DSDVdown.nam w]    

$ns trace-all $tracefd
$ns use-newtrace 
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

#
#  Create nn mobilenodes [$val(nn)] and attach them to the channel. 
#

# configure the nodes
        $ns node-config -adhocRouting $val(rp) \
			 -llType $val(ll) \
			 -macType $val(mac) \
			 -ifqType $val(ifq) \
			 -ifqLen $val(ifqlen) \
			 -antType $val(ant) \
			 -propType $val(prop) \
			 -phyType $val(netif) \
			 -channelType $val(chan) \
			 -topoInstance $topo \
			 -energyModel "EnergyModel" \
			 -initialEnergy 100.0 \
	    		 -txPower 0.9 \
			 -rxPower 0.7 \
			 -idlePower 0.6 \
			 -sleepPower 0.1 \
			 -agentTrace ON \
			 -routerTrace ON \
			 -macTrace OFF \
			 -movementTrace ON
			 
	for {set i 0} {$i < $val(nn) } { incr i } {
		set node_($i) [$ns node]	
	}

# Provide initial location of mobilenodes
$node_(0) set X_ 260.0
$node_(0) set Y_ 415.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 429.0
$node_(1) set Y_ 518.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 582.0
$node_(2) set Y_ 411.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 678
$node_(3) set Y_ 517
$node_(3) set Z_ 0.0

$node_(4) set X_ 791
$node_(4) set Y_ 413
$node_(4) set Z_ 0.0

$node_(5) set X_ 698
$node_(5) set Y_ 230
$node_(5) set Z_ 0.0

$node_(6) set X_ 516
$node_(6) set Y_ 222
$node_(6) set Z_ 0.0

$node_(7) set X_ 416
$node_(7) set Y_ 341
$node_(7) set Z_ 0.0

$node_(8) set X_ 315
$node_(8) set Y_ 230
$node_(8) set Z_ 0.0

$node_(9) set X_ 514
$node_(9) set Y_ 80
$node_(9) set Z_ 0.0

# Generation of movements
$ns at 10.0 "$node_(0) setdest 250.0 250.0 3.0"
$ns at 15.0 "$node_(1) setdest 45.0 285.0 5.0"
$ns at 110.0 "$node_(0) setdest 480.0 300.0 5.0" 

# Set a TCP connection between node_(0) and node_(1)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(7) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start" 

 

# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
# 30 defines the node size for nam
$ns initial_node_pos $node_($i) 20
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
}

# ending nam and the simulation 
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at 20.0 "puts \"end simulation\" ; $ns halt"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
    exec nam DSDVdown.nam &
}

$ns run
