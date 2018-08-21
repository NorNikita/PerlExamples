#!/usr/bin/perl

use 5.016;
use strict;
use warnings;

use Local::Reducer;
use Local::Reducer::Sum;
use Local::Reducer::MaxDiff;

use Local::Source;
use Local::Source::Array;
use Local::Source::Text;

my $reducer = Local::Reducer::Sum->new(
    field => 'price',
    source => Local::Source::Array->new(array => [
        '{"price": 7}',
        '{"value":11}',
        '{"price": 2}',
        '{"value": 4}',
        '{"price": 3}',
        '{"price": 9}',
        '{"value": 1}',
        '{"price": 9}',
    ]),
    row_class => 'Local::Row::JSON',
    initial_value => 0,
);
$reducer->reduce_n(3);
$reducer->reduce_all();

my $reducer2 = Local::Reducer::MaxDiff->new(
    top => 'received',
    bottom => 'sended',
    source => Local::Source::Text->new(text =>"sended:1024,received:2048\nsended:2048,received:10240"),
    row_class => 'Local::Row::Simple',
    initial_value => 0,
);
$reducer2->reduce_n(1);
$reducer2->reduce_all();

