
#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     10                         ;# number of mobilenodes
set val(rp)     IDSAODV                       ;# routing protocol
set val(x)      899                        ;# X dimension of topography
set val(y)      620                        ;# Y dimension of topography
set val(stop)   20.0                       ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open iAODV10.tr w]
$ns trace-all $tracefile
$ns use-newtrace

#Open the NAM trace file
set namfile [open iAODV10.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
		-energyModel "EnergyModel" \
		-initialEnergy 100.0 \
		-txPower 0.9 \
		-rxPower 0.7 \
		-idlePower 0.6 \
		-sleepPower 0.1 \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 10 nodes
set n0 [$ns node]
$n0 set X_ 260
$n0 set Y_ 415
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 429
$n1 set Y_ 518
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 582
$n2 set Y_ 411
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 678
$n3 set Y_ 517
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 791
$n4 set Y_ 413
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 698
$n5 set Y_ 230
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 516
$n6 set Y_ 222
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 416
$n7 set Y_ 341
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 315
$n8 set Y_ 230
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 514
$n9 set Y_ 80
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20

#===================================
#        Generate movement          
#===================================
#$ns at 1.0 " $n2 setdest 750 350 20 " 
#$ns at 1.0 " $n7 setdest 650 280 10 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink3 [new Agent/TCPSink]
$ns attach-agent $n5 $sink3
$ns connect $tcp0 $sink3
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n8 $tcp2
set sink5 [new Agent/TCPSink]
$ns attach-agent $n3 $sink5
$ns connect $tcp2 $sink5
$tcp2 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 8.0 "$ftp0 stop"

#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp2
$ns at 0.5 "$ftp1 start"
$ns at 18.0 "$ftp1 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam iAODV10.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
