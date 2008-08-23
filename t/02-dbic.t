use Test::More tests => 9;
use strict;
use lib qw( t ../lib lib );
use Data::Dump qw( dump );
use Carp;

END { unlink('t/dbic_example.db') unless $ENV{PERL_DEBUG}; }

SKIP: {

    eval "use DBIx::Class";
    if ($@) {
        skip "DBIC required to test DBIC driver", 1;
    }
    elsif ( $DBIx::Class::VERSION < 0.08010 ) {
        croak "DBIx::Class VERSION 0.08010 or newer required";
    }

    eval "use DBIx::Class::RDBOHelpers";
    if ($@) {
        skip "DBIx::Class::RDBOHelpers required for DBIC support";
    }

    use_ok('MyDBIC::Form::Cd');
    use_ok('MyDBIC::Form::Artist');
    use_ok('MyDBIC::Form::Track');

    system("cd t/ && $^X dbic_create.pl") and die "can't create db: $!";

    ok( my $cdform     = MyDBIC::Form::Cd->new(),     "new Cd form" );
    ok( my $artistform = MyDBIC::Form::Artist->new(), "new Artist form" );
    ok( my $trackform  = MyDBIC::Form::Track->new(),  "new Track form" );

    #dump $cdform->metadata;

    ok( my $cd_rels = $cdform->metadata->relationships, "cd relationships" );
    is( scalar(@$cd_rels), 2, "2 cd rels" );

    ok( $cdform->metadata->is_related_field('artist'),
        "artist is related field" );

    # TODO more relationship checks

}
