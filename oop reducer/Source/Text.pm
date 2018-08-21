package Local::Source::Text;
use parent Local::Source;

use 5.016;
use strict;
use warnings;

my $i = 0;

sub new {
  my ($class, %params) = @_;
  my $self = Local::Source::new($class,%params);
}

sub next {
  my ($self) = @_;
  if ($self->{text}) {
    my $delimiter = '\n';
    my @arr = $self->{text} =~ /(.+)$delimiter/g;
    my @brr = $self->{text} =~ /$delimiter(.+)$/;
    $arr[$#arr+1] = $brr[0];
    @brr = ();
    my $length = $#arr;
    if ($i <= $length) {
      $i++;
      return $arr[$i-1];
    }
    else {
      return undef;
    }
  }
}

1;
