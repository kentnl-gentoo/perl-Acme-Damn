# $Id: Damn.pm,v 1.4 2003/06/09 19:35:23 ian Exp $
package Acme::Damn;

use 5.000;
use strict;

require Exporter;
require DynaLoader;

use vars qw( $VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
	$VERSION	= '0.01';
	@ISA		= qw( Exporter DynaLoader );
	@EXPORT		= qw( damn                );

bootstrap Acme::Damn $VERSION;

1;
__END__
=pod

=head1 NAME

Acme::Damn - 'Unbless' Perl objects.


=head1 SYNOPSIS

  use Acme::Damn;

  my $ref = ... some reference ...
  my $obj = bless $ref , 'Some::Class';
  
  ... do something with your object ...

     $ref = damn $obj;   # recover the original reference (unblessed)

  ... neither $ref nor $obj are Some::Class objects ...


=head1 DESCRIPTION

B<Acme::Damn> provides a single routine, B<damn()>, which takes a blessed
reference (a Perl object), and I<unblesses> it, to return the original
reference. I can't think of any reason why you might want to do this, but
just because it's of no use doesn't mean that you shouldn't be able to do
it.


=head2 EXPORT

By default, B<Acme::Damn> exports the method B<damn()> into the current
namespace.

=head2 Methods

=over 4

=item B<damn> I<object>

B<damn()> accepts a single blessed reference as its argument, and returns
that reference unblessed. If I<object> is not a blessed reference, then
B<damn()> will C<die> with an error.

=back


=head1 WARNING

Just as C<bless> doesn't call an object's initialisation code, C<damn> doesn't
invoke an object's C<DESTROY> method. For objects that need to be C<DESTROY>ed,
either don't C<damn> them, or call C<DESTROY> before judgement is passed.


=head1 SEE ALSO

L<bless|perlfunc/bless>, L<perlboot>, L<perltoot>, L<perltooc>, L<perlbot>,
L<perlobj>.


=head1 AUTHOR

Ian Brayshaw, E<lt>ian@onemore.orgE<gt>


=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Ian Brayshaw

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
