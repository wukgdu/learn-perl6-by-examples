sub escape ($str) {
    $_ = $str;
    # Puts a slash before non-alphanumeric characters
    s:g[<-alpha -digit>] = "\\$/";
    $_;
}

say escape "foo#bar?"; # foo\#bar\?

{
    sub escape ($str) {
        $_ = $str;
        # Writes each non-alphanumeric character in its hexadecimal escape
        s:g[<-[\w]>] = "\\x[{ $/.ord.base(16) }]";
        $_;
    }

    say escape "foo#bar?"; # foo\x[23]bar\x[3F]
}

# Back to original escape function
say escape "foo#bar?"; # foo\#bar\?
