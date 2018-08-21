package Local1::NoFriends;

use 5.016;
use strict;
use warnings;
use Data::Dumper;
use JSON;

use Local1::Help;

use Exporter 'import';
our @EXPORT = qw(nofriends);

sub nofriends {
  my $dbh = shift;
  my $sth1 = $dbh->prepare("SELECT id FROM users LEFT JOIN relation ON id = first_id WHERE first_id IS NULL");
  my $sth2 = $dbh->prepare("SELECT id FROM users LEFT JOIN relation ON id = second_id WHERE second_id IS NULL");
  my $nofriends1;
  my $nofriends2;
  my @nofriends = ();
  $sth1 -> execute;
  $nofriends1 = $sth1->fetchall_arrayref([0]);

  $sth2 -> execute;
  $nofriends2 = $sth2->fetchall_arrayref([0]);

  my $flag = 0;
  for my $i (0..$#{$nofriends1}) {
    for my $j (0..$#{$nofriends2}) {
      if ($nofriends1->[$i]->[0]== $nofriends2->[$j]->[0] and $flag == 0) {
        push @nofriends, $nofriends1->[$i]->[0];
        $flag = 1;
      }
    }
    $flag = 0;
  }

  if (!@nofriends) {
    say "у всех есть друзья";
  }
  else {
    my $sth;
    my $id;
    my $user;
    my $ref;
    my $hash;
    while(1) {
      $id = shift @nofriends;

      if (!$id) {
        for(@{$user}) { say $_;};
        return;
      }

      $id = $dbh->quote($id);
      $sth = $dbh->prepare("SELECT id, first_name, second_name FROM users WHERE id = $id");
      $sth->execute;
      $ref = $sth->fetchrow_arrayref;

      $hash->{id} = $ref->[0];
      $hash->{first_name} = $ref->[1];
      $hash->{last_name} = $ref->[2];
      push @{$user}, to_json $hash;
    }
  }
}
1;


