use Method::Modifiers;
# modules.perl6.org
class C {
method m() is before { say "before"; } method m() { say "in the method"; } method m() is after { say "after"; }
} C.m;
