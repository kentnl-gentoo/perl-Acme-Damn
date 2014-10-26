# Makefile.PL for Acme::Damn
#
# Author:        I. Brayshaw <ian>onemore.org>
# Revision:      1.4
# Last modified: 2014-10-26 20:46:00 UTC

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
