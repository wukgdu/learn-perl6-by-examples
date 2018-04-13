class Dog {
    has $.name is rw;
    has $.color;

    method kugo {
       say "hello ",$.name;
    }
}
my $pet = Dog.new(
    name => 'Spot', color => 'Black'
);
$pet.kugo();
$pet.name = 'Fido'; # OK
$pet.kugo();
try {
    CATCH {
        default {
            say .^name;
        }
    }
    $pet.color = 'White'; # Fails
}
