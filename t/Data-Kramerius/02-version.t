use strict;
use warnings;

use Data::Kramerius;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Data::Kramerius::VERSION, 0.02, 'Version.');
