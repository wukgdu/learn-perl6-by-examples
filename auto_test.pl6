sub traver($pathio, :&dosome=*.say, :$deep=True) {
    my @files = $pathio.dir;
    for @files -> $f {
        dosome($f);
        traver($f, :&dosome, :deep) if ($f.d && $deep);
    }
}

sub test_pl6($file) {
    if ($file eq 'auto_test.pl6') {
        say "skip $file";
    } elsif ($file.f && $file ~~ /['pl6'||'p6']$/) {
        say $file;
        try {
            run 'perl6.bat', $file, :out, :err;
            CATCH {
                default {
                    say .^name;
                }
            }
        }
    }
}

".".IO.&traver: dosome => {test_pl6 $_};
