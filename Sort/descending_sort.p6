use v6;
my %hash = 'Perl'=>80,
         'Python'=>100,
             'Go'=>95,
            'CMD'=>20,
            "Php"=>80,
           "Java"=>85;

for %hash.sort({-.value}) -> (:$key, :$value) {
    say $key, "\t", $value;
}
