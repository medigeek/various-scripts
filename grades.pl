#!/usr/bin/perl

my $score = 60; int($score);

my %in; @in{0..100}=(("an E")x60,("a D")x10,("a C")x10,("a B")x10,("an A")x11);
if(my $grade = $in{$score}) {
	print "You have $grade!\n";
}
else {
	print "Error: \$score should be between 0 and 100 included.\n";
}
