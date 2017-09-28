use v6;

my @primes = (2,3,5,7,11,13,17,19,23);   # an array gets filled like in Perl 5
# my @primes =  2,3,5,7,11,13,17,19,23 ; # same thing, since unlike P5 round braces just do group
# my @primes = <2 3 5 7 11 13 17 19 23>; # dito, <> is the new qw()

say @primes[];                           # 2 3 5 7 11 13 17 19 23
my $arrayref = [2,3,5,7,11,13,17,19,23]; # in scalar context you get automatically a reference
say @$arrayref;                          # 2 3 5 7 11 13 17 19 23

$arrayref = item @primes;             # same thing, more explicit
say $arrayref;

$arrayref = [13,];                    # comma is the new array generator
say $arrayref;

@primes = 2;                          # array with one element
@primes = [2,3,5,7,11,13,17,19,23];   # array with one element (arrayref)
say @primes;                             # 2 3 5 7 11 13 17 19 23

my @dev    = {'dan' => 'parrot'};        # array with one element (hashref)
say @dev;                                # ("dan" => "parrot").hash


my @data   = [1..5],[6..10],[11..15];    # Array of Arrays (AoA)
say @data.perl;                          # Array.new([1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15])

# my @list   = lol @data;                # no change
# say @list.perl;
my @list   = flat @data>>.list;                 # returns 1..15
say @list;                               # 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
#`(
see https://docs.perl6.org/routine/flat
Note that Arrays containerize their elements by default, and so flat will not flatten them. You can use hyper method call to call .List method on all the inner Iterables and so de-containerize them, so that flat can flatten them
)
