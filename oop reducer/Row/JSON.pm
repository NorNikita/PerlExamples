package Local::Row::JSON;

use parent Local::Row;

use 5.016;
use strict;
use warnings;
use JSON;

sub new {
  my ($class, $string) = @_;
  my $self = Local::Row::new($class, $string);
}

sub get {
  my ($self, $key) = @_;
  my $decode = decode_json $$self;
  if ($decode->{$key}) {
    return $decode->{$key};
  }
  else {
    return undef;
  }
}

1;
