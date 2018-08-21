package Local::Source::Array;
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
}

1;
