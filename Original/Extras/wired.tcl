#create a simulator object
set ns [new Simulator]

#creation of trace file, for logging
set tracefile [open wired.tr w]
$ns trace-all $tracefile

#creation of animation info/ NAM file creation
set namfile [open wired.nam w]
$ns namtrace-all $namfile

#creation nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#creation links wit DropTail Queue
$ns duplex-link $n0 $n1 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 10Mb 5ms DropTail
$ns duplex-link $n1 $n4 3Mb 10ms DropTail
$ns duplex-link $n4 $n3 100Mb 2ms DropTail
$ns duplex-link $n4 $n5 4Mb 10ms DropTail

#creation of Agents
#node 0 to 3
set udp [new Agent/UDP] 
set null [new Agent/Null] 
$ns attach-agent $n0 $udp
$ns attach-agent $n3 $null
$ns connect $udp $null

#creation of TCP agent
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $tcp
$ns attach-agent $n5 $sink
$ns connect $tcp $sink

#creation of Application (CBR and FTP)
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

#Start the traffic
$ns at 1.0 "$cbr start"
$ns at 2.0 "$ftp start"

$ns at 10.0 "finish" 

#the following procedure will be called at 10.0 seconds
proc finish {} {
     global ns tracefile namfile
     $ns flush-trace
     close $tracefile
     close $namfile
     exit 0
}
puts "Simulation is starting..."
$ns run 



