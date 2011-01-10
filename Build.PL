use 5.010;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name         => 'Variable::OnDestruct::Scoped',
	license             => 'perl',
	dist_author         => q{Leon Timmermans <leont@cpan.org>},
	dist_version_from   => 'lib/Variable/OnDestruct/Scoped.pm',
	configure_requires  => {
		'Module::Build' => 0.28,
	},
	build_requires => {
		'ExtUtils::CBuilder' => 0,
		'Module::Build' => 0.28,
		'Test::More'    => 0,
	},
	requires            => {
		perl            => 5.010,
	},
	add_to_cleanup      => [ 'Variable-OnDestruct-Scoped-*' ],
	create_makefile_pl  => 'small',
);

$builder->create_build_script();
