package Variable::OnDestruct::Scoped;

use 5.010;
use strict;
use warnings FATAL => 'all';

use Exporter 5.57 'import';
use XSLoader;

##no critic (ProhibitAutomaticExportation)
our @EXPORT = qw/on_destruct/;

our $VERSION = '0.001';

XSLoader::load('Variable::OnDestruct::Scoped', $VERSION);

1;    # End of Variable::OnDestruct::Scoped

__END__

=head1 NAME

Variable::OnDestruct::Scoped - Call a subroutine on destruction of a variable.

=head1 VERSION

Version 0.001

=cut

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

=head1 AUTHOR

Leon Timmermans, C<< <leont at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-devel-ondestruct at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Variable-OnDestruct>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Variable::OnDestruct::Scoped


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Variable-OnDestruct-Scoped>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Variable-OnDestruct-Scoped>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Variable-OnDestruct-Scoped>

=item * Search CPAN

L<http://search.cpan.org/dist/Variable-OnDestruct-Scoped>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2011 Leon Timmermans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
