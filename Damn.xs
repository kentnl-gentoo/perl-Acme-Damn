/* $Id: Damn.xs,v 1.6 2003/06/08 14:38:15 ian Exp $ */

/*
** Damn.xs
**
** Define the damn() method of Acme::Damn.
**
** Author:        I. Brayshaw <ian@onemore.org>
** Revision:      $Revision: 1.6 $
** Last modified: $Date: 2003/06/08 14:38:15 $
*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* for Perl > 5.6, additional magic must be handled */
#if ( PERL_REVISION == 5 ) && ( PERL_VERSION > 6 )
/* if there's magic set - Perl extension magic - then unset it */
# define SvUNMAGIC( sv )	if ( SvSMAGICAL( sv ) )							\
								if (    mg_find( sv , PERL_MAGIC_ext  )		\
								     || mg_find( sv , PERL_MAGIC_uvar ) )	\
									mg_clear( sv )

#else

/* for Perl <= 5.6 this becomes a no-op */
# define SvUNMAGIC( sv )

#endif


MODULE = Acme::Damn		PACKAGE = Acme::Damn		

SV *
damn( rv )
		SV * rv;

	PROTOTYPE: $

	PREINIT:
		SV * sv;

	CODE:
		/* if we don't have a blessed reference, then raise an error */
		if ( ! sv_isobject( rv ) )
			croak( "Expected blessed reference; can only damn programmer now" );

		/* need to dereference the RV to get the SV */
		sv = SvRV( rv );

		/*
		** if this is read-only, then we should do the right thing and slap
		** the programmer's wrist; who know's what might happen otherwise
		*/
		if ( SvREADONLY( sv ) )
			croak( PL_no_modify );

		SvREFCNT_dec( SvSTASH( sv ) );	/* remove the reference to the stash */
		SvSTASH( sv ) = NULL;
		SvOBJECT_off( sv );				/* unset the object flag */
		if ( SvTYPE( sv ) != SVt_PVIO )	/* if we don't have an IO stream, we */
			PL_sv_objcount--;			/* should decrement the object count */

		/* we need to clear the magic flag on the given RV */
		SvAMAGIC_off( rv );
		/* as of Perl 5.8.0 we need to clear more magic */
		SvUNMAGIC( sv );

	OUTPUT:
		rv
