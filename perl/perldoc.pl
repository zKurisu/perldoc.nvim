#!/usr/bin/perl -w
#  perldoc.pl
#
###
###  function
###
#
#  Copyright (Perl) Jie
#  2023-11-16
# 
use 5.38.0;
use utf8;
use File::Temp qw(tempfile);

open my $fh, "<", $ARGV[0]
    or die "can not open: $ARGV[0]. Error: $!";
my @use_modules = grep { m/^use [^0-9]/ } <$fh>;
close $fh;

my ($tmp_fh, $tmp_name) = tempfile();

my $code = <<'CODE';
use Devel::Peek qw(CvGV);

my $module_name = CvGV(\&$ARGV[1]);
$module_name =~ s/\*(.*?)::\w+$/$1/;
print $module_name;
CODE
$code =~ s/\$ARGV\[1\]/$ARGV[1]/g;

print {$tmp_fh} $_ for @use_modules;
print {$tmp_fh} $code;

my $module_name = `perl $tmp_name`;
unlink $tmp_name or die "can not delete $tmp_name: $!";

print $module_name;
