package Local1::MutualFriends;

use 5.016;
use strict;
use warnings;
use JSON;
use Data::Dumper;
use Local1::Help;

use Exporter 'import';
our @EXPORT = qw(mutual_friends);

sub mutual_friends {
  my $k = 0;
  my ($id1, $id2, $dbh) = @_;
  my @json;

  my @for_id1_friend = friend_list($id1, $dbh);
  my @for_id2_friend = friend_list($id2, $dbh);

  my @common_list_friend = ();
  for my $i (0..$#for_id1_friend) {
    for my $j (0..$#for_id2_friend) {
      if ($for_id1_friend[$i] == $for_id2_friend[$j]) {
        $common_list_friend[$k] = $for_id1_friend[$i];
        $k++;
      }
    }
  }

  if (!@common_list_friend) {
    say "нет общих друзей";
  }
  else {
    my $k =0; my $sth; my $ref; my $user; my $hash;
    while(1) {
      $common_list_friend[$k] = $dbh->quote($common_list_friend[$k]);
      $sth = $dbh->prepare("SELECT id, first_name, second_name FROM users WHERE id = $common_list_friend[$k]");
      $sth->execute;
      $ref = $sth->fetchrow_arrayref;

      $hash->{id} = $ref->[0];
      $hash->{first_name} = $ref->[1];
      $hash->{last_name} = $ref->[2];

      $user->[$k] = to_json $hash;

      if ($k == $#common_list_friend) {
        for(@{$user}) { say $_;}
        return;
      }
      $k++;
    }
  }
  @common_list_friend = ();
}

1;

