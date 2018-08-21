package Local::Row;

use 5.016;
use warnings;
use strict;

sub new {
  my ($class, $data) = @_;
  bless \$data, $class;
}
1;
