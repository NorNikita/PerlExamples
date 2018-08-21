package Local::Reducer::Sum;
use parent Local::Reducer;

use Local::Source;

use Local::Row::JSON;
use Local::Row::Simple;

use 5.016;
use Data::Dumper;
use Exporter 'import';

our @EXPORT = qw(reduce_one);

sub new {
  my ($class, %hash) = @_;
  my $self = Local::Reducer::new($class, %hash);
}

sub reduce_one {
  my ($self,$hash) = @_;
  if ($self->{row_class} eq 'Local::Row::Simple') {
    my $object = Local::Row::Simple->new($hash);
    my @value = $object->get($self->{field});
    if (@value) {
      for my $i (0..$#value) {
        $self->{initial_value} += $value[$i];
      }
      @value = ();
    }
  }
  if ($self->{row_class} eq 'Local::Row::JSON') {
    my $object = Local::Row::JSON->new($hash);
    $self->{initial_value} += $object->get($self->{field});
  }
}

1;

