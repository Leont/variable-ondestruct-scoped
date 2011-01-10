#!perl

use Test::More tests => 5;

use Variable::OnDestruct::Scoped;
use Symbol qw/gensym/;

sub foo {
}


my @handles;
	
{
	my $var = 'foo';
	my $sub = sub { $var };

	my $glob = gensym();
	push @handles, on_destruct $var, sub { pass("Scalar got destroyed!") };
	push @handles, on_destruct my @array, sub { pass("Array got destroyed!") };
	push @handles, on_destruct my %hash, sub { pass("Hash got destroyed!") };
	push @handles, on_destruct &{ $sub }, sub { pass("Sub got destroyed!" ) };
	push @handles, on_destruct *{ $glob }, sub { pass("Glob got destroyed") };
	undef $glob;
}
