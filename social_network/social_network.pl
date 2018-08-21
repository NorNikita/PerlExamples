#!/usr/bin/env perl

use 5.016;
use warnings;
use strict;

use Getopt::Long;
use DBI;

use Local::MutualFriends;
use Local::NoFriends;
use Local::Handshake;
use Local::Help;

my $host = "localhost";
my $port = 3306;
my $db = 'social_network';
my $user = 'root';
my $pass = '271828';

my $dbh = DBI->connect("DBI:mysql:$db::$host::$port", $user, $pass, {AutoCommit => 1});

my $id1;
my $id2;

my $string = shift;

GetOptions ('user1=i' => \$id1,
            'user2=i' => \$id2 ) or die "not correct commnd\n";

if ($string =~ /friends/) {
  if ($id1 and $id2) {
    mutual_friends($id1, $id2, $dbh);
  }
}

if ($string =~ /nofriends/) {
  nofriends($dbh);
}

if ($string =~ /num_handshakes/) {
  if ($id1 and $id2) {
    handshake($id1, $id2, $dbh);
  }
}

$dbh->disconnect;
