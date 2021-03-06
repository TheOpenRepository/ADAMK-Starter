#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 9;
use Test::File::Cleaner   ();
use File::Spec::Functions ':ALL';
use ADAMK::Starter        ();

# Check and clean the test directory
my $trunk   = File::Spec->catdir( 't', 'data' );
ok( -d $trunk, 'Output directory exists' );
my $cleaner = Test::File::Cleaner->new( $trunk );





#####################################################################
# Main Tests

SCOPE: {
        my $perl = $^X;
        ok( -f $perl, "Found perl at $perl" );
        my $bin  = catfile( 'script', 'adamk-starter' );
	ok( -f $bin, 'Found binary' );
        my $cmd = "$perl -Mblib $bin --module Foo::Bar --trunk $trunk";
        my $rv  = system( $cmd );
	is( $rv, 0, 'Binary returns 0' );
	ok( -f catfile(qw(t data Foo-Bar Makefile.PL)),    'Created Makefile.PL'  );
	ok( -f catfile(qw(t data Foo-Bar Changes)),        'Created Changes'      );
	ok( -f catfile(qw(t data Foo-Bar t 01_compile.t)), 'Created 01_compile.t' );
	ok( -f catfile(qw(t data Foo-Bar t 02_main.t)),    'Created 02_main.t'    );
	ok( -f catfile(qw(t data Foo-Bar lib Foo Bar.pm)), 'Created main module'  );
}
