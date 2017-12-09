role Observable {
    has @!observers;

    method subscribe($observer) {
        push @!observers, $observer;
        $observer
    }

    method unsubscribe($observer) {
        @!observers .= grep({ $^o !=== $observer });
    }

    method publish($obj) {
        @!observers>>.handle($obj)
    }
}

class ReadLineSource does Observable {
    has $.fh;
    method enterloop() {
        loop {
            self.publish($.fh.get());
        }
    }
}

multi grep($matcher, Observable $ob) {
    my class GrepSubscriber does Observable {
        has $.matcher;
        method handle($obj) {
            if $obj ~~ $.matcher {
                self.publish($obj);
            }
        }
    }
    say 1;
    $ob.subscribe(GrepSubscriber.new(:$matcher))
}
# don't know how to run
my Observable $src = ReadLineSource.new(fh => $*IN);
my $nums = grep(/^\d+$/, $src);
say $nums;

$nums
    ==> grep(*.Int.is-prime)
    ==> say "That's prime!";

$nums
    ==> map(-> $n {
            state $total += $n;
            $total >= 100 ?? 'More than 100' !! ()
        })
    ==> first()
    ==> say(); 
