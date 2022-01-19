#!/usr/bin/perl                                                                                                                      

# test.pl: small script to test mod_dosevasive's effectiveness                                                                       

use IO::Socket;
use strict;

for(0..100) {
  my($response);
  my($SOCKET) = new IO::Socket::INET( Proto   => "tcp",
                                      PeerAddr=> "192.168.1.66:80");
  if (! defined $SOCKET) { die $!; }
  print $SOCKET "GET /?$_ HTTP/1.0\r\nHost: 192.168.1.66\r\n\r\n";
  $response = <$SOCKET>;
  print $response;
  close($SOCKET);
}




