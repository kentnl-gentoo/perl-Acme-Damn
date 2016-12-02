# Makefile.PL for Acme::Damn

use 5.000;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Acme::Damn'                            ,
    'VERSION_FROM' => 'Damn.pm'                               ,
    'PREREQ_PM'    => { 'Test::More'      => 0 ,
                        'Test::Exception' => 0 }              ,
    ($] >= 5.005 ?
      ( AUTHOR     => 'Ian Brayshaw <ibb@cpan.org>') : ()) ,
    'LIBS'         => ['']                                    ,
    'DEFINE'       => ''                                      ,
    'INC'          => '-I.'
);
