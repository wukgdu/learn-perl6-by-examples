use v6;

my $original = 5;say $original;
my $mirror;
$original := $mirror;       # normal binding, done on runtime

say $mirror;

$original ::= $mirror;      # same thing, but done during compile time
# ::= Read-only binding operator.
# "::=" not yet implemented. Sorry. # Rakudo Star 2017.07

say $mirror;
$original = 3;
say $mirror;                # prints 3
say $original =:= $mirror;       # true, because their bound together
say $original === $mirror;       # alsotrue, because content and type are equal
