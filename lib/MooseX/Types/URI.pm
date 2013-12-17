package MooseX::Types::URI;
# ABSTRACT: URI related types and coercions for Moose

use strict;
use warnings;

use Scalar::Util qw(blessed);

use URI;
use URI::file;
use URI::data;
use URI::WithBase;
use URI::FromHash qw(uri_object);

use Moose::Util::TypeConstraints;

use MooseX::Types::Moose qw{Str ScalarRef HashRef};
use MooseX::Types::Path::Class qw{File Dir};

use MooseX::Types -declare => [qw(Uri _UriWithBase _Uri FileUri DataUri)];

my $uri = Moose::Meta::TypeConstraint->new(
    name   => Uri,
    parent => Moose::Meta::TypeConstraint::Union->new(
        name => join("|", _Uri, _UriWithBase),
        type_constraints => [
            class_type( _Uri,         { class => "URI" } ),
            class_type( _UriWithBase, { class => "URI::WithBase" } ),
        ],
    ),
    ($Moose::VERSION >= 2.0100
        ? (inline_as => sub { 'local $@; blessed('.$_[1].') && ( '.$_[1].'->isa("URI") || '.$_[1].'->isa("URI::WithBase") )' })
        : (optimized => sub { local $@; blessed($_[0]) && ( $_[0]->isa("URI") || $_[0]->isa("URI::WithBase") ) })
    ),
);

register_type_constraint($uri);

coerce( Uri,
    from Str                 , via { URI->new($_) },
    from "Path::Class::File" , via { URI::file->new($_) },
    from "Path::Class::Dir"  , via { URI::file->new($_) },
    from File                , via { URI::file->new($_) },
    from Dir                 , via { URI::file->new($_) },
    from ScalarRef           , via { my $u = URI->new("data:"); $u->data($$_); $u },
    from HashRef             , via { uri_object(%$_) },
);

class_type FileUri, { class => "URI::file", parent => $uri };

coerce( FileUri,
    from Str                 , via { URI::file->new($_) },
    from File                , via { URI::file->new($_) },
    from Dir                 , via { URI::file->new($_) },
    from "Path::Class::File" , via { URI::file->new($_) },
    from "Path::Class::Dir"  , via { URI::file->new($_) },
);

class_type DataUri, { class => "URI::data" };

coerce( DataUri,
    from Str       , via { my $u = URI->new("data:"); $u->data($_);  $u },
    from ScalarRef , via { my $u = URI->new("data:"); $u->data($$_); $u },
);

1;
__END__

=pod

=head1 SYNOPSIS

	use MooseX::Types::URI qw(Uri FileUri DataUri);

=head1 DESCRIPTION

This package provides Moose types for fun with L<URI>s.

=for stopwords DWIMier ducktyping

It has slightly DWIMier types than the L<URI> classes have due to
implementation details, so the types should be more forgiving when ducktyping
will work anyway (e.g. L<URI::WithBase> does not inherit L<URI>).

=head1 TYPES

The types are with C<ucfirst> naming convention so that they don't mask the
L<URI> class.

=type C<Uri>

Either L<URI> or L<URI::WithBase>

Coerces from C<Str> via L<URI/new>.

Coerces from L<Path::Class::File> and L<Path::Class::Dir> via L<URI::file/new>.

Coerces from C<ScalarRef> via L<URI::data/new>.

Coerces from C<HashRef> using L<URI::FromHash>.

=type C<DataUri>

A URI whose scheme is C<data>.

Coerces from C<Str> and C<ScalarRef> via L<URI::data/new>.

=type C<FileUri>

A L<URI::file> class type.

Has coercions from C<Str>, L<Path::Class::File> and L<Path::Class::Dir> via L<URI::file/new>

=for stopwords TODO

=head1 TODO

Think about L<Path::Resource> integration of some sort

=cut
