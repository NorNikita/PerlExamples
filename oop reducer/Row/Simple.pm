package Local::Row::Simple;
use parent Local::Row;

use 5.016;
use strict;
use warnings;

sub new {
  my ($class, $string) = @_;
  my $self = Local::Row::new($class, $string);
}

sub get {
  my ($self, $key) = @_;
  my @numbers = $$self =~/$key:(\d+)/g;
  if (@numbers) {
    return @numbers;
  }
  else {
    return undef;
  }
}

1;
