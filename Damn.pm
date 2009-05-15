package Acme::Damn;

use 5.000;
use strict;

require Exporter;
require DynaLoader;

use vars qw( $VERSION @ISA @EXPORT @EXPORT_OK );

  $VERSION    = '0.04';
  @ISA        = qw( Exporter DynaLoader );
  @EXPORT     = qw( damn                );


sub import
{
  my  $class    = shift;

  # check the unknown symbols to ensure they are 'safe'
  my  @bad      = grep { /\W/o } @_;
  if ( @bad ) {
    # throw an error message informing the user where the problem is
    my  ( undef, $file , $line )    = caller 0;

    die sprintf( "Bad choice of symbol name%s %s for import at %s line %s\n"
                 , ( @bad == 1 ) ? '' : 's'
                 , join( ', ' , map { qq|'$_'| } @bad ) , $file , $line );
  }

  # remove duplicates from the list of aliases, as well as those symbol
  # names listed in @EXPORT
  my  @aliases  = do {  local %_;
                              @_{ @_      } = undef;
                       delete @_{ @EXPORT };
                         keys %_                     };

  # 'import' the symbols into the host package
  my  ( $pkg )  = caller 1;
  foreach my $alias ( @aliases ) {
    no strict 'refs';

    *{ $pkg . '::' . $alias } = sub {
        my    $ref                      = shift;
        my  ( undef , $file , $line )   = caller 1;

        # call damn() with the location of where this method was
        # originally called
        &{ __PACKAGE__ . '::damn' }( $ref , $alias , $file , $line );

        # NB: wanted to do something like
        #         goto \&{ __PACKAGE__ . '::damn' };
        #     having set the @_ array appropriately, but this caused a
        #     "Attempt to free unrefernced SV" error that I couldn't solve
        #     - I think it was to do with the @_ array
      };
  }

  # add the known symbols to @_
  splice @_ , 0;  push @_ , $class;

  # run the "proper" import() routine
  goto \&Exporter::import;
} # import()


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
namespace. Aliases for B<damn()> (see below) may be imported upon request.

=head2 Methods

=over 4

=item B<damn> I<object>

B<damn()> accepts a single blessed reference as its argument, and returns
that reference unblessed. If I<object> is not a blessed reference, then
B<damn()> will C<die> with an error.

=back


=head2 Method Aliases

Not everyone likes to damn the same way or in the same language, so
B<Acme::Damn> offers the ability to specify any alias on import, provided
that alias is a valid Perl subroutine name (i.e. all characters match C<\w>).

  use Acme::Damn qw( unbless );
  use Acme::Damn qw( foo );
  use Acme::Damn qw( unblessthyself );
  use Acme::Damn qw( recant );

Version 0.02 supported a defined list of aliases, and this has been replaced
in v0.03 by the ability to import any alias for C<damn()>.


=head1 WARNING

Just as C<bless> doesn't call an object's initialisation code, C<damn> doesn't
invoke an object's C<DESTROY> method. For objects that need to be C<DESTROY>ed,
either don't C<damn> them, or call C<DESTROY> before judgement is passed.


=head1 ACKNOWLEDGEMENTS

Thanks to Claes Jacobsson E<lt>claes@surfar.nuE<gt> for suggesting the use of
aliases.


=head1 SEE ALSO

L<bless|perlfunc/bless>, L<perlboot>, L<perltoot>, L<perltooc>, L<perlbot>,
L<perlobj>.


=head1 AUTHOR

Ian Brayshaw, E<lt>ian@onemore.orgE<gt>


=head1 COPYRIGHT AND LICENSE

Copyright 2003-2006 Ian Brayshaw

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
