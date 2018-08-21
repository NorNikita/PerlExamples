package Local1::Handshake;

use 5.016;
use strict;
use warnings;
use Local1::Help;

use Exporter 'import';
our @EXPORT = qw(handshake);

sub handshake {
  my ($id1, $id2, $dbh) = @_;
  my $k = 0;
  my $step = 0;
  my @round;
  my @round1=();
  my @round2=();
  @round = friend_list($id1, $dbh);
  if (!@round) {die "у пользователя $id1 нет друзей\n";}
  while(1) {
    $step++;
    for my $i (0..$#round) {
      if ($round[$i] == $id2) {
        say "число рукопожатий между пользователями $step";
        return;
      }
      if ($step > 2 and ($round[$i] == $id1)) {
        say "нет друзей у $id2";
        return;
      }
    }
    for my $i (0..$#round) {
      @round1 = friend_list($round[$i], $dbh);
      for my $j (0..$#round1) {
        push @round2, $round1[$j];
      }
      @round1 = ();
    }
    @round = ();
    @round = @round2;
    @round2 = ();
  }
}
1;

