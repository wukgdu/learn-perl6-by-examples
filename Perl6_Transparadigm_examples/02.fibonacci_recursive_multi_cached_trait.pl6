#! /usr/bin/env perl6
use v6;
use experimental :cached;

multi fibonacci (0) { 1 }

multi fibonacci (1) { 1 }

multi fibonacci (Int $n --> Int) is cached {
    fibonacci($n-1) + fibonacci($n-2);
}

for 0..1000 -> $i {
    say $i.fmt('%3d'), ': ', fibonacci($i);
}
# Cannot invoke object with invocation handler in this context
