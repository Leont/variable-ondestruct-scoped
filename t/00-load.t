#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Variable::OnDestruct::Scoped' );
}

diag( "Testing Variable::OnDestruct::Scoped $Variable::OnDestruct::Scoped::VERSION, Perl $], $^X" );
