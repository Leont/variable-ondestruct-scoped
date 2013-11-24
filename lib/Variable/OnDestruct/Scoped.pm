package Variable::OnDestruct::Scoped;

use 5.010;
use strict;
use warnings FATAL => 'all';

use Exporter 5.57 'import';
use XSLoader;

##no critic (ProhibitAutomaticExportation)
our @EXPORT = qw/on_destruct/;

XSLoader::load('Variable::OnDestruct::Scoped', __PACKAGE__->VERSION);

1;    # End of Variable::OnDestruct::Scoped

# ABSTRACT: Call a subroutine on destruction of a variable.

=head1 SYNOPSIS

 use Variable::OnDestruct::Scoped;

 my $handle on_destruct $var, sub { do_something() };
 on_destruct @array, sub { do_something_else() };
 on_destruct %array, sub { hashes_work_too() };
 on_destruct &$sub, sub { so_do_closures($but_not_normal_subs) };
 on_destruct *$glob, sub { and_even_globs($similar_caveats_as_subs_though) };
 
 undef $handle if $want_to_cancel_destructor;

=head1 DESCRIPTION

This module allows you to let a function be called when a variable gets destroyed. The destructor will work not only on scalars but also on arrays, hashes, subs and globs. For the latter two you should realize that most of them aren't scoped like normal variables. Subs for example will only work like you expect them to when they are closures.

=head1 FUNCTIONS

This module contains one function, which is exported by default.

=head2 on_destruct $variable, \&sub;

This function adds a destructor to a variable.

