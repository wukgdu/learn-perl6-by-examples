use v6;

# Sometimes, you want to accept any type, but then transform it into another type before binding to the parameter
# 强制类型转换

sub show_dist($from, $to, $kms Int) { # error; see http://www.jnthn.net/papers/2010-yapc-eu-signatures.pdf P32
   say "From $from to $to is $kms km.";
}
show_dist('Kiev', 'Lviv', '469');
show_dist('Kiev', 'Lviv', 469.35);
