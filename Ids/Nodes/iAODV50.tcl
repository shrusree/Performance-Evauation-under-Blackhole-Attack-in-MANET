
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
set val(nn)     50                         ;# number of mobilenodes
set val(rp)     IDSAODV                       ;# routing protocol
set val(x)      990                        ;# X dimension of topography
set val(y)      619                        ;# Y dimension of topography
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
set tracefile [open iAODV50.tr w]
$ns trace-all $tracefile
$ns use-newtrace

#Open the NAM trace file
set namfile [open iAODV50.nam w]
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
#Create 50 nodes
set n0 [$ns node]
$n0 set X_ 93
$n0 set Y_ 489
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 179
$n1 set Y_ 500
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 247
$n2 set Y_ 492
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 331
$n3 set Y_ 495
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 392
$n4 set Y_ 503
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 453
$n5 set Y_ 485
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 495
$n6 set Y_ 464
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 539
$n7 set Y_ 494
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 616
$n8 set Y_ 489
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 674
$n9 set Y_ 469
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 723
$n10 set Y_ 519
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 750
$n11 set Y_ 463
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 811
$n12 set Y_ 424
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 868
$n13 set Y_ 488
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 883
$n14 set Y_ 395
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 806
$n15 set Y_ 358
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n16 [$ns node]
$n16 set X_ 698
$n16 set Y_ 398
$n16 set Z_ 0.0
$ns initial_node_pos $n16 20
set n17 [$ns node]
$n17 set X_ 604
$n17 set Y_ 413
$n17 set Z_ 0.0
$ns initial_node_pos $n17 20
set n18 [$ns node]
$n18 set X_ 662
$n18 set Y_ 341
$n18 set Z_ 0.0
$ns initial_node_pos $n18 20
set n19 [$ns node]
$n19 set X_ 731
$n19 set Y_ 311
$n19 set Z_ 0.0
$ns initial_node_pos $n19 20
set n20 [$ns node]
$n20 set X_ 860
$n20 set Y_ 312
$n20 set Z_ 0.0
$ns initial_node_pos $n20 20
set n21 [$ns node]
$n21 set X_ 689
$n21 set Y_ 271
$n21 set Z_ 0.0
$ns initial_node_pos $n21 20
set n22 [$ns node]
$n22 set X_ 578
$n22 set Y_ 309
$n22 set Z_ 0.0
$ns initial_node_pos $n22 20
set n23 [$ns node]
$n23 set X_ 498
$n23 set Y_ 369
$n23 set Z_ 0.0
$ns initial_node_pos $n23 20
set n24 [$ns node]
$n24 set X_ 397
$n24 set Y_ 417
$n24 set Z_ 0.0
$ns initial_node_pos $n24 20
set n25 [$ns node]
$n25 set X_ 426
$n25 set Y_ 367
$n25 set Z_ 0.0
$ns initial_node_pos $n25 20
set n26 [$ns node]
$n26 set X_ 315
$n26 set Y_ 427
$n26 set Z_ 0.0
$ns initial_node_pos $n26 20
set n27 [$ns node]
$n27 set X_ 231
$n27 set Y_ 427
$n27 set Z_ 0.0
$ns initial_node_pos $n27 20
set n28 [$ns node]
$n28 set X_ 154
$n28 set Y_ 421
$n28 set Z_ 0.0
$ns initial_node_pos $n28 20
set n29 [$ns node]
$n29 set X_ 215
$n29 set Y_ 363
$n29 set Z_ 0.0
$ns initial_node_pos $n29 20
set n30 [$ns node]
$n30 set X_ 318
$n30 set Y_ 360
$n30 set Z_ 0.0
$ns initial_node_pos $n30 20
set n31 [$ns node]
$n31 set X_ 269
$n31 set Y_ 309
$n31 set Z_ 0.0
$ns initial_node_pos $n31 20
set n32 [$ns node]
$n32 set X_ 377
$n32 set Y_ 307
$n32 set Z_ 0.0
$ns initial_node_pos $n32 20
set n33 [$ns node]
$n33 set X_ 340
$n33 set Y_ 242
$n33 set Z_ 0.0
$ns initial_node_pos $n33 20
set n34 [$ns node]
$n34 set X_ 186
$n34 set Y_ 300
$n34 set Z_ 0.0
$ns initial_node_pos $n34 20
set n35 [$ns node]
$n35 set X_ 83
$n35 set Y_ 359
$n35 set Z_ 0.0
$ns initial_node_pos $n35 20
set n36 [$ns node]
$n36 set X_ 157
$n36 set Y_ 233
$n36 set Z_ 0.0
$ns initial_node_pos $n36 20
set n37 [$ns node]
$n37 set X_ 232
$n37 set Y_ 191
$n37 set Z_ 0.0
$ns initial_node_pos $n37 20
set n38 [$ns node]
$n38 set X_ 297
$n38 set Y_ 178
$n38 set Z_ 0.0
$ns initial_node_pos $n38 20
set n39 [$ns node]
$n39 set X_ 376
$n39 set Y_ 179
$n39 set Z_ 0.0
$ns initial_node_pos $n39 20
set n40 [$ns node]
$n40 set X_ 496
$n40 set Y_ 226
$n40 set Z_ 0.0
$ns initial_node_pos $n40 20
set n41 [$ns node]
$n41 set X_ 79
$n41 set Y_ 256
$n41 set Z_ 0.0
$ns initial_node_pos $n41 20
set n42 [$ns node]
$n42 set X_ 571
$n42 set Y_ 174
$n42 set Z_ 0.0
$ns initial_node_pos $n42 20
set n43 [$ns node]
$n43 set X_ 482
$n43 set Y_ 132
$n43 set Z_ 0.0
$ns initial_node_pos $n43 20
set n44 [$ns node]
$n44 set X_ 696
$n44 set Y_ 183
$n44 set Z_ 0.0
$ns initial_node_pos $n44 20
set n45 [$ns node]
$n45 set X_ 795
$n45 set Y_ 228
$n45 set Z_ 0.0
$ns initial_node_pos $n45 20
set n46 [$ns node]
$n46 set X_ 632
$n46 set Y_ 116
$n46 set Z_ 0.0
$ns initial_node_pos $n46 20
set n47 [$ns node]
$n47 set X_ 352
$n47 set Y_ 99
$n47 set Z_ 0.0
$ns initial_node_pos $n47 20
set n48 [$ns node]
$n48 set X_ 184
$n48 set Y_ 133
$n48 set Z_ 0.0
$ns initial_node_pos $n48 20
set n49 [$ns node]
$n49 set X_ 479
$n49 set Y_ 77
$n49 set Z_ 0.0
$ns initial_node_pos $n49 20

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink3 [new Agent/TCPSink]
$ns attach-agent $n13 $sink3
$ns connect $tcp0 $sink3
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n35 $tcp1
set sink4 [new Agent/TCPSink]
$ns attach-agent $n14 $sink4
$ns connect $tcp1 $sink4
$tcp1 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n36 $tcp2
set sink5 [new Agent/TCPSink]
$ns attach-agent $n44 $sink5
$ns connect $tcp2 $sink5
$tcp2 set packetSize_ 1500

#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 0.5 "$ftp0 start"
$ns at 12.0 "$ftp0 stop"

#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 1.0 "$ftp1 start"
$ns at 15.0 "$ftp1 stop"

#Setup a FTP Application over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 1.5 "$ftp2 start"
$ns at 18.0 "$ftp2 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam AODV50.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
