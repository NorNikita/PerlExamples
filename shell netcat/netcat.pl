#!/usr/bin/env perl

use 5.016;
use warnings;
use strict;
use IO::Socket;
use Getopt::Long;

my $udp;
my $tcp;
my $proto;

GetOptions('u' => \$udp, 't' => \$tcp) or die "not correct command\n";

if ($udp) { $proto = 'udp';}
elsif ($tcp) { $proto = 'tcp';}

my $host = shift;
my $port = shift;

if (!$port or !$host or (!$host and !$port)) { die "few parametrs for connect\n";}

my $socket = IO::Socket::INET->new(
             PeerHost => "$host",
             PeerPort => "$port",
             Proto    => "$proto",
             Type     => SOCK_STREAM) or die "Can't connect$/";

if (my $pid = fork()) {
    while (my $line = <STDIN>) {
        $socket->send($line);
    }
}
else {
    die "can`t fork $!" unless defined $pid;
    while(<$socket>) {
        print $_;
    }
}

