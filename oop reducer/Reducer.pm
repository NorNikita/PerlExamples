package Local::Reducer;

use 5.016;
use strict;
use Exporter 'import';
use Data::Dumper;

use Local::Reducer::Sum;
use Local::Reducer::MaxDiff;

our @EXPORT = qw(reduce_all reduce_n reduced);

sub new {
  my ($class, %data) = @_;
  return bless \%data, $class;
}

sub reduce_all {
  my ($self) = @_;
  my $hash;
  while(1) {
    $hash = $self->{source}->next();
    if($hash) {
      $self->reduce_one($hash);
    }
    else {
      say $self->{initial_value};
      return;
    }
  }
}

sub reduce_n {
  my ($self,$n) = @_;
  my $hash;
  while($n > 0) {
    $hash = $self->{source}->next();
    if($hash) {
      $self->reduce_one($hash);
      $n--;
    }
    else {
      say $self->{initial_value};
      return;
    }
  }
  say $self->{initial_value};
}

sub reduced {
  my ($self) = @_;
  say $self->{initial_value};
}

1;


