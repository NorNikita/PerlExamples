package DeepClone;
# vim: noet:

use 5.016;
use warnings;

my @pos;
my $k = 0;
sub clone {
  my $what = shift;
  my $depth = shift || 0;
  my $copy1 = shift;
  if (my $ref  = ref $what) {
    if ($ref eq 'ARRAY') {
      for my $i (0..$#{$what}) {
        my $ref1 =ref $what->[$i];
        if (($ref1 eq 'ARRAY') || ($ref eq 'HASH')) {
          $pos[$depth][$k] = $i;
          $k++;
          $copy1->[$i] = undef;
          $i++;
        }
        else {
          $copy1->[$i] = $what->[$i];
        }
      }

      for my $i (0..$#{$pos[$depth]}) {
        my $j = $pos[$depth][$i];
        $k = 0;
        $copy1->[$j] = clone($what->[$j],$depth+1,$copy1->[$j]);
      }
    }
    if ($ref eq 'HASH') {
      for my $key (keys %$what) {
        my $ref2 = ref $what->{$key};
        if (($ref2 eq 'HASH')) {
          $pos[$depth][$k] = $key;
          $k++;
          $copy1->{$key} = undef;
        }
        else {
          $copy1->{$key} = $what->{$key};
        }
      }
      for my $i (0..$#{$pos[$depth]}) {
        my $j = $pos[$depth][$i];
        $k = 0;
        $copy1->{$j} = clone($what->{$j},$depth+1,$copy1->{$j});
      }
    }
  }
  else { return $what;}
  return $copy1;
}

1;
