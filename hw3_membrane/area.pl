#!/usr/bin/perl -w

# Extract second and third columns of an .xvg file, multiply them to get the membrane area
# This assumes, of course, that the second and third columns correspond to Box-X and Box-Y from
# a Gromacs energy file analyzed by g_energy
#

use strict;

unless (scalar(@ARGV)==2) {
	die "Usage: $0 input.xvg number_of_lipids_per_leaflet\n";
}

open(IN, $ARGV[0]);
my @input = <IN>;
close(IN);

my $nlipids = $ARGV[1];

open(OUT, ">>area.xvg");

# print some header stuff - legends, etc.
print OUT "# Area per lipid\n";
print OUT "\@\ttitle \"Area per lipid\"\n";
print OUT "\@\txaxis label \"Time (ps)\"\n";
print OUT "\@\tyaxis label \"Area per lipid (nm\\S2\\N)\"\n";
print OUT "\@TYPE xy\n";

foreach $_ (@input) {
	unless ($_ =~ /^[#@]/) {
		my @line = split(" ", $_);
		my $time = $line[0];
		my $x = $line[1];
		my $y = $line[2];

		my $area = ($x * $y) / $nlipids;

		printf OUT "%8.3f\t%8.3f\n", $time, $area;
	}
}

close(OUT);

exit;
