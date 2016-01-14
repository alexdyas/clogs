#!/usr/bin/perl -w
# ------------------------------------------------------------------------------
#
# Script      - clogs.pl
#
# Description - Coloured Logs, small filter to colour space separated log file
#               fields to make them easier to read
#
# Notes       - Example usage :
#
#               $ cat access.log | clogs.pl
#
#             - Supports double quoted strings
#             - Colours cycle through ANSI 31 to 37
#             - Written to be as portable as possible, only requirement is Perl
#
# Author      - Alexander Dyas
#
# ------------------------------------------------------------------------------
use strict;

my $filename='-';
my $oneline;
my $count;
my $inquote=0;
my $char;
my $colour;

open INPUTFILE,$filename || die("Failed to open $filename, quiting\n");
while(<INPUTFILE>) {
  $oneline = $_;
  $colour=31;
  print "\e[";
  print $colour;
  print 'm';

  # Parse line, colouring where we find spaces outside quotes
  for ($count=0 ; $count < length($oneline) ; $count++) {
    $char = substr($oneline,$count,1);
    if($inquote) {
      if($char eq '"') {
        $inquote=0;
      }
    } elsif($char eq '"') {
      $inquote=1;
    } elsif($char eq ' ') {
      if($colour==37) {
        $colour=31;
      } else {
        $colour++;
      }
      print "\e[";
      print $colour;
      print 'm';
    }
    print $char;
  }
}
