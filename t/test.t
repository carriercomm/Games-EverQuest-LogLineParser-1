# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More 'no_plan';

BEGIN { use_ok('Games::EverQuest::LogLineParser') }

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

my @tests = (

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You slash a Bloodguard crypt sentry for 88 points of damage.\n|,
      out => {
         line_type => 'MELEE_DAMAGE',
         attacker => 'You',
         attack   => 'slash',
         attackee => 'a Bloodguard crypt sentry',
         amount   => '88',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You try to kick a Bloodguard crypt sentry, but miss!\n|,
      out => {
         line_type => 'YOU_MISS_MOB',
         attack   => 'kick',
         attackee => 'a Bloodguard crypt sentry',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] A Bloodguard crypt sentry hits YOU for 161 points of damage.\n|,
      out => {
         line_type => 'MELEE_DAMAGE',
         attacker => 'A Bloodguard crypt sentry',
         attack   => 'hit',
         attackee => 'YOU',
         amount   => '161',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] A Bloodguard crypt sentry tries to hit YOU, but misses!\n|,
      out => {
         line_type => 'MOB_MISSES_YOU',
         attacker => 'A Bloodguard crypt sentry',
         attack   => 'hit',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Your faction standing with Loyals got worse.\n|,
      out => {
         line_type => 'FACTION_HIT',
         faction_group  => 'Loyals',
         faction_change => 'worse',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] A Bloodguard crypt sentry tries to hit YOU, but YOU parry!\n|,
      out => {
         line_type => 'YOU_REPEL_HIT',
         attacker => 'A Bloodguard crypt sentry',
         attack   => 'hit',
         repel    => 'parry',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You try to slash a Bloodguard crypt sentry, but a Bloodguard crypt sentry ripostes!\n|,
      out => {
         line_type => 'MOB_REPELS_HIT',
         attack   => 'slash',
         attackee => 'a Bloodguard crypt sentry',
         repel    => 'riposte',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have slain a Bloodguard crypt sentry!\n|,
      out => {
         line_type => 'SLAIN_BY_YOU',
         slayee => 'a Bloodguard crypt sentry',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have become better at Abjuration! (222)\n|,
      out => {
         line_type => 'SKILL_UP',
         skill_upped => 'Abjuration',
         skill_value => '222',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] a Bloodguard crypt sentry has been slain by Soandso!\n|,
      out => {
         line_type => 'SLAIN_BY_OTHER',
         slayee => 'a Bloodguard crypt sentry',
         slayer => 'Soandso',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You receive 67 platinum, 16 gold, 20 silver and 36 copper from the corpse.\n|,
      out => {
         line_type => 'CORPSE_MONEY',
         platinum  => '67',
         gold      => '16',
         silver    => '20',
         copper    => '36',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] a Bloodguard crypt sentry was hit by non-melee for 8 points of damage.\n|,
      out => {
         line_type => 'DAMAGE_SHIELD',
         attacker => 'a Bloodguard crypt sentry',
         amount   => '8',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso hit a Bloodguard crypt sentry for 300 points of non-melee damage.\n|,
      out => {
         line_type => 'DIRECT_DAMAGE',
         attacker => 'Soandso',
         attackee => 'a Bloodguard crypt sentry',
         amount   => '300',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] A Bloodguard crypt sentry has taken 3 damage from your Flame Lick.\n|,
      out => {
         line_type => 'DAMAGE_OVER_TIME',
         attackee => 'A Bloodguard crypt sentry',
         amount   => '3',
         spell    => 'Flame Lick',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] --You have looted a Flawed Green Shard of Might.--\n|,
      out => {
         line_type => 'LOOT_ITEM',
         looter => 'You',
         item   => 'Flawed Green Shard of Might',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] --Soandso has looted a Tears of Prexus.--\n|,
      out => {
         line_type => 'LOOT_ITEM',
         looter => 'Soandso',
         item   => 'Tears of Prexus',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You give 1 gold 2 silver 5 copper to Cavalier Aodus.\n|,
      out => {
         line_type => 'BUY_ITEM',
         platinum  => 0,
         gold      => '1',
         silver    => '2',
         copper    => '5',
         merchant  => 'Cavalier Aodus',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have entered The Greater Faydark.\n|,
      out => {
         line_type => 'ENTERED_ZONE',
         zone => 'The Greater Faydark',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You receive 120 platinum from Magus Delin for the Fire Emerald Ring(s).\n|,
      out => {
         line_type => 'SELL_ITEM',
         platinum  => '120',
         gold      => 0,
         silver    => 0,
         copper    => 0,
         merchant  => 'Magus Delin',
         item      => 'Fire Emerald Ring',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You receive 163 platinum, 30 gold, 25 silver and 33 copper as your split.\n|,
      out => {
         line_type => 'SPLIT_MONEY',
         platinum  => '163',
         gold      => '30',
         silver    => '25',
         copper    => '33',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have been slain by a Bloodguard crypt sentry!\n|,
      out => {
         line_type => 'YOU_SLAIN',
         slayer => 'a Bloodguard crypt sentry',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You begin tracking a Bloodguard crypt sentry.\n|,
      out => {
         line_type => 'TRACKING_MOB',
         trackee => 'a Bloodguard crypt sentry',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You begin casting Ensnaring Roots.\n|,
      out => {
         line_type => 'YOU_CAST',
         spell => 'Ensnaring Roots',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Your target resisted the Ensnaring Roots spell.\n|,
      out => {
         line_type => 'YOUR_SPELL_RESISTED',
         spell => 'Ensnaring Roots',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You forget Ensnaring Roots.\n|,
      out => {
         line_type => 'FORGET_SPELL',
         spell => 'Ensnaring Roots',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have finished memorizing Ensnaring Roots.\n|,
      out => {
         line_type => 'MEMORIZE_SPELL',
         spell => 'Ensnaring Roots',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Your spell fizzles!\n|,
      out => {
         line_type => 'YOU_FIZZLE',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Your Location is -63.20, 3846.55, -42.76\n|,
      out => {
         line_type => 'LOCATION',
         coord_1 => '-63.20',
         coord_2 => '3846.55',
         coord_3 => '-42.76',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You tell your party, 'can you say /pet get lost'\n|,
      out => {
         line_type => 'YOU_TELL_GROUP',
         spoken => 'can you say /pet get lost',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso says, 'I aim to please :)'\n|,
      out => {
         line_type => 'OTHER_SAYS',
         speaker => 'Soandso',
         spoken  => 'I aim to please :)',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You told Soandso, 'lol, i was waiting for that =)'\n|,
      out => {
         line_type => 'YOU_TELL_OTHER',
         speakee => 'Soandso',
         spoken  => 'lol, i was waiting for that =)',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso tells you, 'hows the adv?'\n|,
      out => {
         line_type => 'OTHER_TELLS_YOU',
         speaker => 'Soandso',
         spoken  => 'hows the adv?',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You tell your party, 'will keep an eye out'\n|,
      out => {
         line_type => 'YOU_TELL_GROUP',
         spoken => 'will keep an eye out',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso tells the group, 'Didnt know that, thanks info'\n|,
      out => {
         line_type => 'OTHER_TELLS_GROUP',
         speaker => 'Soandso',
         spoken  => 'Didnt know that, thanks info',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso begins to cast a spell.\n|,
      out => {
         line_type => 'OTHER_CASTS',
         caster => 'Soandso',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso scores a critical hit! (126)\n|,
      out => {
         line_type => 'CRITICAL_SCORE',
         attacker => 'Soandso',
         type     => 'hit',
         amount   => '126',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso has healed you for 456 points of damage.\n|,
      out => {
         line_type => 'PLAYER_HEALED',
         healer => 'Soandso',
         healee => 'you',
         amount => '456',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso says out of character, 'Stop following me :oP'\n|,
      out => {
         line_type => 'SAYS_OOC',
         speaker => 'Soandso',
         spoken  => 'Stop following me :oP',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Soandso shouts, 'talk to vual stoutest'\n|,
      out => {
         line_type => 'OTHER_SHOUTS',
         speaker => 'Soandso',
         spoken  => 'talk to vual stoutest',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] [56 Outrider] Soandso (Half Elf) <The Foobles>\n|,
      out => {
         line_type => 'PLAYER_LISTING',
         afk        => '',
         linkdead   => '',
         anon  => '',
         level => '56',
         class => 'Outrider',
         name  => 'Soandso',
         race  => 'Half Elf',
         guild => 'The Foobles',
         zone  => '',
         lfg   => '',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] [65 Deceiver] Soandso (Barbarian) <The Foobles> ZONE: potranquility\n|,
      out => {
         line_type => 'PLAYER_LISTING',
         afk        => '',
         linkdead   => '',
         anon  => '',
         level => '65',
         class => 'Deceiver',
         name  => 'Soandso',
         race  => 'Barbarian',
         guild => 'The Foobles',
         zone  => 'potranquility',
         lfg   => '',
      },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] Your Flame Lick spell has worn off.\n|,
      out => {
         line_type => 'YOUR_SPELL_WEARS_OFF',
         spell => 'Flame Lick',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have successfully completed your adventure.  You received 22 adventure points.  You have 30 minutes to exit this zone.\n|,
      out => {
         line_type => 'WIN_ADVENTURE',
         amount => '22',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You have spent 40 adventure points.\n|,
      out => {
         line_type => 'SPEND_ADVENTURE_POINTS',
         amount => '40',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You gain party experience!!\n|,
      out => {
         line_type => 'GAIN_EXPERIENCE',
         gainer => 'party',
         },
      },

      {
      in => qq|[Sat Sep 27 23:18:53 2003] You gain experience!!\n|,
      out => {
         line_type => 'GAIN_EXPERIENCE',
         gainer => '',
         },
      },

);

for my $test (@tests)
   {

   $test->{'out'}{'time_stamp'} = '[Sat Sep 27 23:18:53 2003] ';

   ## parse any
   my $parsed_line = parse_eq_line($test->{'in'});
   is_deeply( $parsed_line, $test->{'out'}, $test->{'in'});

   ## parse type
   $parsed_line = parse_eq_line_type($test->{'out'}{'line_type'}, $test->{'in'});
   is_deeply( $parsed_line, $test->{'out'}, $test->{'in'});

   }


my $got_time_stamp = parse_eq_time_stamp('[Mon Oct 13 00:42:36 2003] ');
my $exp_time_stamp = {
    day   => 'Mon',
    month => 'Oct',
    date  => '13',
    hour  => '00',
    min   => '42',
    sec   => '36',
    year  => '2003',
   };

is_deeply( $got_time_stamp, $exp_time_stamp, 'parse_eq_time_stamp');
