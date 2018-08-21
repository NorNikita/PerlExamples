package Anagram;

use 5.016;
use Encode;
use utf8;
no warnings 'layer';

sub anagram {
  my $words_list = shift;
  my $result;
  my $value;

  my @chars;
  my $score = 0;
  my $l = 0;

	for my $i (0..$#{$words_list}) {
		$words_list->[$i] = lc(decode('utf8', $words_list->[$i]));
	}

	for my $i (0..$#{$words_list}-1) {

		@chars = unpack("A1" x length($words_list->[$i]),$words_list->[$i]);

	  for my $j ($i+1..$#{$words_list}) {

			for my $k (0..$#chars) {
	      if ($words_list->[$j] =~ /$chars[$k]/) {
	        $score++;
	      }
	    }

	    if ($score == scalar(@chars) and $score == length($words_list->[$j])) {
	      my $simile = $words_list->[$j] cmp $words_list->[$i];
	      if ($l > 0) {
	        if ($simile == 0) { delete $words_list->[$j];}
	        else {
	          for my $n (0..$#{$value}) {
	            $simile = $words_list->[$j] cmp $value->[$n];
	            if ($simile == 0) { delete $words_list->[$j];}
	          }
						if ($words_list->[$j]) {
							$value->[$l] = $words_list->[$j];
		          delete $words_list->[$j];
		          $l++;
						}
	        }
	      }
	      elsif ($l == 0) {
	        if ($simile == 0) { delete $words_list->[$j];}
	        else {
	          $value->[$l] = $words_list->[$j];
	          delete $words_list->[$j];
	          $l++;
	        }
	      }
	    }
	    $score = 0;
	  }

	  if ($value and $words_list->[$i]) {
	    $result->{$words_list->[$i]} = $value;
	  }
	  $l = 0;
	  $value = ();
	  @chars = ();

	}
	return $result;
}
1;
