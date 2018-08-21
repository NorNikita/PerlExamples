package Local::Source;

use 5.016;
use strict;
use warnings;
use Exporter 'import';

our @EXPORT = qw(next);

my $i = 0;

sub new {
  my ($class, %params) = @_;
  return bless \%params, $class;
}

sub next {
  my($self) = @_;
  if ($self->{array}) {
    my $length = $#{$self->{array}};
    if ($i <= $length) {
      $i++;
      return $self->{array}->[$i-1];
    }
    else {
      return undef;
    }
  }
  if ($self->{text}) {
    my $delimiter;
    if ($self->{delimiter}) {
      $delimiter = $self->{delimiter};
    }
    else {
      $delimiter = '\n';
    }

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
