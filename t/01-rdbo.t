use Test::More tests => 1;

SKIP: {

    eval "use Rose::DB::Object";
    if ($@) {
        skip "RDBO required to test RDBO driver", 1;
    }

    use_ok('Rose::HTMLx::Form::Related::RDBO');

}
