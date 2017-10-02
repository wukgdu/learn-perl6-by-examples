#!/usr/bin/env perl6

constant @months = <January February March April May June July
August September October November December>;
constant @days = <Su Mo Tu We Th Fr Sa>;


sub center(Str $text, Int $width) {
    my $prefix = ' ' x ($width - $text.chars) div 2;
    my $suffix = ' ' x $width - $text.chars - $prefix.chars;
    return $prefix ~ $text ~ $suffix;
}

sub MAIN(:$year = Date.today.year, :$month = Date.today.month) {
    my $dt = Date.new(:year($year), :month($month), :day(1) );
    my $ss = $dt.day-of-week % 7;
    my @slots = ''.fmt("%2s") xx $ss;

    my $days-in-month = $dt.days-in-month;
    for $ss ..^ $ss + $days-in-month {
        @slots[$_] = $dt.day.fmt("%2d");
        $dt++
    }

    my $weekdays = @days.fmt("%2s").join: " ";
    say center(@months[$month-1] ~ " " ~ $year, $weekdays.chars);
    say $weekdays;
    for @slots.kv -> $k, $v {
        print "$v ";
        print "\n" if ($k+1) %% 7 or $v == $days-in-month;
    }
}

# April 2014
# Su Mo Tu We Th Fr Sa
#        1  2  3  4  5
#  6  7  8  9 10 11 12
# 13 14 15 16 17 18 19
# 20 21 22 23 24 25 26
# 27 28 29 30
