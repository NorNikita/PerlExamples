#!/usr/bin/perl

use 5.016;
use warnings;
use strict;
use DBI;
use JSON;

my $host = "localhost";
my $port = "3306";
my $userr = "root";
my $pass = '271828';
my $db = "new_schema2";

my $dbh = DBI->connect("DBI:mysql:$db::$host::$port", $userr, $pass, {AutoCommit => 1});
my $sth;

my $file1 = 'user.txt';
open(my $user, '<:encoding(UTF-8)', $file1) or die "не возможно открыть файл user.txt\n";

my $file2 = 'user_relation.txt';
open(my $relation, '<', $file2) or die "не возможно открыть файл user_relation.txt\n";

$dbh -> begin_work;

my $reg = qr/^(\d+) (\w+) (\w+)$/;
while ( <$user> ) {
  $_ =~ $reg;
  $sth = $dbh->prepare("INSERT INTO users VALUE ('$1', '$2','$3')");
  $sth->execute;
}

my $count = 0;
my $reg1 = qr/^(\d+) (\d+)$/;
while ( <$relation> ) {
  $_ =~ $reg1;
  $count++;
  $sth = $dbh->prepare("INSERT INTO relation VALUE ('$count','$1', '$2')");
  $sth->execute;
}

$dbh->commit;
$dbh->disconnect;
