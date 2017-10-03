use v6;

# Can extract values by attribute (only those that are declared with accessors)

sub nd($r as Rat (:$numerator, :$denominator)) { # error; see http://www.jnthn.net/papers/2010-yapc-eu-signatures.pdf P52
    say "$r = $numerator/$denominator";
}
nd(4.2);
nd(3/9);
