
BEGIN {
      seqno = -1; 
      droppedPackets = 0;
      receivedPackets = 0;
      count = 0;
      }
   {
#packet delivery ratio
   if($1 == "s" && $19 == "AGT" ) {#&& seqno < $6
   seqno = $47;
   } else if(($19 == "AGT") && ($1 == "r")) {
   receivedPackets++;
   } else if ($1 == "d" && $45 == "tcp" && $8 > 512){
   droppedPackets++; 
   }

#end-to-end delay
   if($19 == "AGT" && $1 == "s") {
   start_time[$47] = $3;
   } else if(($45 == "tcp") && ($1 == "r")) {
   end_time[$47] = $3;
   } else if($1 == "d" && $45 == "tcp") {
   end_time[$47] = -1;
   }
   }

 END { 

   for(i=0; i<=seqno; i++) {
   if(end_time[i] > 0) {
   delay[i] = end_time[i] - start_time[i];
   count++;
   }
   else
   {
   delay[i] = -1;
   }
   }
   for(i=0; i<count; i++) {
   if(delay[i] > 0) {
   e2edelay = e2edelay + delay[i];
   } 
   }
   e2edelay = e2edelay/count;
   print "\n";
   print "GeneratedPackets = " seqno+1;
   print "ReceivedPackets = " receivedPackets;
   print "Average End-to-End Delay = " e2edelay * 1000 " ms";
   print "\n";
   }



