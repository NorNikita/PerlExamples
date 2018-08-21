package Local::Reducer::MaxDiff;
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

  my $flag = 0;
  my $MaxDiff_pred; my $MaxDiff;
  if ($self->{initial_value} != 0) { $MaxDiff_pred = $self->{initial_value}; $flag = 1;}

  if ($self->{row_class} eq 'Local::Row::Simple') {
    my $min; my $max;
    my $object = Local::Row::Simple->new($hash);
    my @value_top = $object->get($self->{top});
    my @value_bottom = $object->get($self->{bottom});

    if (@value_top and @value_bottom) {
      $max = $value_top[0];
      for my $i (1..$#value_top) { if ($max < $value_top[$i]) { $max = $value_top[$i];} }

      $min = $value_bottom[0];
      for my $i (1..$#value_bottom) { if ($min > $value_bottom[$i]) { $min = $value_bottom[$i];} }

      $MaxDiff = $max - $min;

      if ($flag == 0) { $self->{initial_value} = $MaxDiff;}
      else {
        if($MaxDiff > $MaxDiff_pred){
          $self->{initial_value} = $MaxDiff;
        }
      }
    }
    @value_top = ();
    @value_bottom = ();
  }
  if($self->{row_class} eq 'Local::Row::JSON') {
    my $object = Local::Row::JSON->new($hash);
    my $value_top = $object->get($self->{top});
    my $value_bottom = $object->get($self->{bottom});

    if ($value_top and $value_bottom) {
      $MaxDiff = $value_top - $value_bottom;
      if ($flag == 0) { $self->{initial_value} = $MaxDiff; }
      else {
        if($MaxDiff > $MaxDiff_pred){
          $self->{initial_value} = $MaxDiff;
        }
      }
    }
  }
}

1;


