# $Id: Makefile.PL,v 1.3 2003-06-08 13:20:59 ian Exp $

# Makefile.PL for Acme::Damn
#
# Author:        I. Brayshaw <ian>onemore.org>
# Revision:      $Revision: 1.3 $
# Last modified: $Date: 2003-06-08 13:20:59 $

use 5.000;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Acme::Damn'                            ,
    'VERSION_FROM' => 'Damn.pm'                               ,
    'PREREQ_PM'    => { 'Test::More'      => 0 ,
                        'Test::Exception' => 0 }              ,
    ($] >= 5.005 ?
      ( AUTHOR     => 'Ian Brayshaw <ian@onemore.org>') : ()) ,
    'LIBS'         => ['']                                    ,
    'DEFINE'       => ''                                      ,
    'INC'          => '-I.'
);
