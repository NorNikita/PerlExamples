package Local1::Help;

use 5.016;
use strict;
use DBI;
use Data::Dumper;
use Exporter 'import';
our @EXPORT = qw(friend_list have_friends);

sub friend_list {
  my ($id, $dbh) = @_;
  my $sth;
  my $list1;
  my $list2;
  my @list;
  $id = $dbh->quote($id);
  my $command1 = "SELECT second_id FROM users LEFT JOIN relation ON id = first_id WHERE first_id IS NOT NULL AND id = $id";
  my $command2 = "SELECT first_id FROM users LEFT JOIN relation ON id = second_id WHERE second_id IS NOT NULL AND id = $id";

  $sth = $dbh->prepare("$command1");
  $sth->execute;
  $list1 = $sth->fetchall_arrayref([0]);

  $sth = $dbh->prepare("$command2");
  $sth->execute;
  $list2 = $sth->fetchall_arrayref([0]);

  if ($list1 and $list2) {
    for my $value (@{$list2}) {
      $list1->[++$#{$list1}] = $value;
    }
    return map {$_->[0]} @list, @{$list1};
  }
  else {
    if (!$list1) {
      return map {$_->[0]} @list, @{$list2};
    }
    if (!$list2) {
      return map {$_->[0]} @list, @{$list1};
    }
  }
}

1;


