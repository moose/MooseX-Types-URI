# NAME

MooseX::Types::URI - URI related types and coercions for Moose

# SYNOPSIS

	use MooseX::Types::URI qw(Uri FileUri DataUri);

# DESCRIPTION

This package provides Moose types for fun with [URI](http://search.cpan.org/perldoc?URI)s.

# TYPES

## `Uri`

Either [URI](http://search.cpan.org/perldoc?URI) or [URI::WithBase](http://search.cpan.org/perldoc?URI::WithBase)

Coerces from `Str` via ["new" in URI](http://search.cpan.org/perldoc?URI#new).

Coerces from [Path::Class::File](http://search.cpan.org/perldoc?Path::Class::File) and [Path::Class::Dir](http://search.cpan.org/perldoc?Path::Class::Dir) via ["new" in URI::file](http://search.cpan.org/perldoc?URI::file#new).

Coerces from `ScalarRef` via ["new" in URI::data](http://search.cpan.org/perldoc?URI::data#new).

Coerces from `HashRef` using [URI::FromHash](http://search.cpan.org/perldoc?URI::FromHash).

## `DataUri`

A URI whose scheme is `data`.

Coerces from `Str` and `ScalarRef` via ["new" in URI::data](http://search.cpan.org/perldoc?URI::data#new).

## `FileUri`

A [URI::file](http://search.cpan.org/perldoc?URI::file) class type.

Has coercions from `Str`, [Path::Class::File](http://search.cpan.org/perldoc?Path::Class::File) and [Path::Class::Dir](http://search.cpan.org/perldoc?Path::Class::Dir) via ["new" in URI::file](http://search.cpan.org/perldoc?URI::file#new)

It has slightly DWIMier types than the [URI](http://search.cpan.org/perldoc?URI) classes have due to
implementation details, so the types should be more forgiving when ducktyping
will work anyway (e.g. [URI::WithBase](http://search.cpan.org/perldoc?URI::WithBase) does not inherit [URI](http://search.cpan.org/perldoc?URI)).

# TYPES

The types are with `ucfirst` naming convention so that they don't mask the
[URI](http://search.cpan.org/perldoc?URI) class.

# TODO

Think about [Path::Resource](http://search.cpan.org/perldoc?Path::Resource) integration of some sort

# AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

# CONTRIBUTORS

- Daniel Pittman <daniel@rimspace.net>
- Florian Ragwitz <rafl@debian.org>
- Karen Etheridge <ether@cpan.org>
- MORIYA Masaki (gardejo) <moriya@ermitejo.com>
- Shawn M Moore <sartak@gmail.com>
- Yuval Kogman <nothingmuch@woobling.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman).

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
