#!/usr/bin/perl -w
# $Id: 3aliases.t,v 1.2 2003/06/10 18:08:34 ian Exp $

# aliase.t
#
# Ensure the damn aliases damn-well work ;)

use strict;
use Test::More	tests => 22;
use Test::Exception;

# load Acme::Damn and the aliases
my	@aliases;
BEGIN { @aliases = qw( abjure anathematize condemn curse damn excommunicate
                       expel proscribe recant renounce unbless ); }

# load Acme::Damn
use Acme::Damn @aliases;

foreach my $alias ( @aliases ) {
	no strict 'refs';

	# create a reference, and strify it
	my	$ref	= [];
	my	$string	= "$ref";

	# bless the reference and the "unbless" it
		bless $ref;
		lives_ok { $alias->( $ref ) } "$alias executes successfully";
	
	# make sure the stringification is correct
		ok( $ref eq $string , "$alias executes correctly" );
}
