# Typed Parameters Can restrict a parameter to only accept arguments of a certain type.
sub show_dist(Str $from, Str $to, Int $kms) {
    say "From $from to $to is $kms km.";
}
show_dist('Copenhagen', 'Beijing', 7305);
show_dist(7305, 'Copenhagen', 'Beijing');
# Calling show_dist(Int, Str, Str) will never work with declared signature (Str $from, Str $to, Int $kms)
