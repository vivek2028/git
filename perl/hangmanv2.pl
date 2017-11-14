#!/usr/bin/perl
use strict;
use warnings;
use feature ":5.10";

# global variables
#my @words = ("banana", "dog", "cat", "chair");
my $filename = 'data.txt';
my @words = do {
    open my $fh, "<", $filename
        or die "could not open $filename: $!";
    <$fh>;
};
my $filename1 = 'data1.txt';
my @hints  = do {
    open my $fh, "<", $filename1
        or die "could not open $filename: $!";
    <$fh>;
};
my @guesses = ();
my @done = ();
for (my $i=0; $i < 10; $i++) {
                $done [$i] = 0;
        }
my $solved = 0;
my $conti = 0;
my $num_of_tries = 0;
my $maxscore=0;
my $score=0;
&main(); # call the main method

sub main {
	
	while(!$conti){
        # choose a random word
		$score=0;
		my $randomint = int(rand(9)) - 1;
		
		while($done[$randomint]){
		$randomint = int(rand(9)) - 1;
		}
		$done[$randomint]=1;
        my $word = @words [$randomint];
		my $hint= @hints [$randomint];
		chomp($word);
        my $size = length($word);
        print"The hint is: " . $hint . "\n";
		@guesses=();
		$num_of_tries=0;
        for (my $i=0; $i < $size; $i++) {
                $guesses [$i] = '_';
        }
		$solved=0;
       line:  while (!$solved) {
                &hangmanDisplay();
				if($num_of_tries<6){
                print join(" ", @guesses);
                print "\n\nEnter a letter: ";
                my $guess = <>;
                chomp($guess); # remove newline
                
                &checkLetter($word, $guess);

                $solved = &checkWin($word);

                system $^O eq 'MSWin32' ? 'cls' : 'clear';}
				#clear the screen
				else{
				last line; }
        }

    if ($num_of_tries<6){
	print join(" ", @guesses);
    print "\n\nYay you win!\n";
	}
	if($maxscore<$score){
	$maxscore=$score;
	}
	$score=0;
	print "\n\n The maximum score is :" . $maxscore . "\n";
	print "\n\nEnter 0 to continue and 1 to stop\n";
	$conti=<>;
	chomp($conti);
	
	}
}
sub hangmanDisplay() {
    given($num_of_tries) {
        when(0) {&hangman1Display();}
        when(1) {&hangman2Display();}
        when(2) {&hangman3Display();}
        when(3) {&hangman4Display();}
        when(4) {&hangman5Display();}
        when(5) {&hangman6Display();}
        when(6) {&hangman7Display();}
    }
}
sub checkLetter {
    my ($word, $guess) = @_;
    my $letterIndex = index($word, $guess);

    if ($letterIndex == -1) {
        print "Wrong!\n";
		$score=$score-3;
        $num_of_tries++;
    } else {
        for (my $i=0; $i < length($word); $i++) {
            my $c_letter = substr($word, $i, 1);
            if ($guess eq $guesses[$i]) {
                print "You already guessed $guess!\n";
            }
            if ($guess eq $c_letter) {
                $guesses [$i] = $c_letter;
				$score=$score+10;
            }
        }
    }
}
sub checkWin {
    my ($word) = @_;
    my $letter;
    for (my $i=0; $i< length($word); $i++) {
        $letter = substr($word, $i, 1);
        if ($letter ne $guesses [$i]) {
            return 0;
        }
    }
    return 1;
}
sub hangman1Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman2Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman3Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman4Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman5Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|/\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman6Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|/\n";
        print "  |     /\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman7Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     x\n";
        print "  |    \\|/\n";
        print "  |     /\\\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
    print "You lost!\n";
 
}