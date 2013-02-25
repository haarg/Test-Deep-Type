use strict;
use warnings FATAL => 'all';

use Test::More tests => 2;
use Test::Deep;
use Test::Deep::Type;

{
    package TypeHi;
    sub validate
    {
        my ($self, $val) = @_;
        return "undef is not a 'hi'" if not defined $val;
        return undef if $val eq 'hi';   # validated: no error
        "'$val' is not a 'hi'";
    }
}
sub TypeHi { bless {}, 'TypeHi' }

cmp_deeply(
    { greeting => 'hi' },
    { greeting => is_type(TypeHi) },
    'hi validates as a TypeHi',
);

cmp_deeply(
    { greeting => 'hello' },
    { greeting => is_type(TypeHi) },
    'hello validates as a TypeHi?',
);

