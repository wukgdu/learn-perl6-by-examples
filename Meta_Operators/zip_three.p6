use v6;

my @a=<aa bb cc dd ee ff >;
for @a -> $x,$y,$z {
    say $x,$y,$z;
}
say $*PROGRAM-NAME;
say $*CWD;
# aabbcc
# ddeeff
# three.p6
