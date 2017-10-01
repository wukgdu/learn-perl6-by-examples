grammar JSON::Tiny::Grammar {
    rule TOP      { ^[ <object> | <array> ]$ }
    rule object   { '{' ~ '}' <pairlist>     }
    rule pairlist { <pair>* % [ \, ]         }
    rule pair     { <string> ':' <value>     }
    rule array    { '[' ~ ']' [ <value>* % [ \, ] ] }

    proto token value { <...> };

    token value:sym<number> {
        '-'?
        [ 0 | <[1..9]> <[0..9]>* ]
        [ \. <[0..9]>+ ]?
        [ <[eE]> [\+|\-]? <[0..9]>+ ]?
    }

    token value:sym<true>   { <sym>    };
    token value:sym<false>  { <sym>    };
    token value:sym<null>   { <sym>    };
    token value:sym<object> { <object> };
    token value:sym<array>  { <array>  };
    token value:sym<string> { <string> }

    token string {
        \" ~ \" [ <str> | \\ <str_escape> ]*
    }

    token str {
        [
            <!before \t>
            <!before \n>
            <!before \\>
            <!before \">
            .
        ]+
        # <-["\\\t\n]>+
    }

    token str_escape {
        <["\\/bfnrt]> | u <xdigit>**4
    }

}


# test it:
my $tester = '{
    "country": "Austria",
    "cities": [ "Wien", "Salzburg", "Innsbruck" ],
    "population": 8353243
}';

if JSON::Tiny::Grammar.parse($tester) {
    say "It's valid JSON";
} else {
    # TODO: error reporting
    say "Not quite...";
}




class JSON::Tiny::Actions {
    method TOP($/)      { make $/.values.[0].made              }
    method object($/)   { make $<pairlist>.made.hash           }
    method pairlist($/) { make $<pair>>>.made                   }
    method pair($/)     { make $<string>.made => $<value>.made  }
    method array($/)    { make [$<value>>>.made]                }
    method string($/)   { make join '', $/.caps>>.value>>.made }

    # TODO: make that
    # make +$/
    # once prefix:<+> is sufficiently polymorphic
    method value:sym<number>($/) { make try $/       }
    method value:sym<string>($/) { make $<string>.made }
    method value:sym<true>  ($/) { make Bool::True    }
    method value:sym<false> ($/) { make Bool::False   }
    method value:sym<null>  ($/) { make Any           }
    method value:sym<object>($/) { make $<object>.made }
    method value:sym<array> ($/) { make $<array>.made  }

    method str($/)               { make ~$/           }

    method str_escape($/) {
        if $<xdigit> {
            make chr(:16($<xdigit>.join));
        } else {
            my %h = '\\' => "\\",
            'n' => "\n",
            't' => "\t",
            'f' => "\f",
            'r' => "\r";
            make %h{$/};
        }
    }
}

my $actions = JSON::Tiny::Actions.new();
my $data_structure = JSON::Tiny::Grammar.parse($tester, :rule('TOP'), :$actions);
say $data_structure;
