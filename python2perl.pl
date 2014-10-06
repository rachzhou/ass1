#!/usr/bin/perl -w
# Starting point for COMP2041/9041 assignment 
# http://www.cse.unsw.edu.au/~cs2041/assignments/python2perl
# written by andrewt@cse.unsw.edu.au September 2014

use Scalar::Util qw(looks_like_number);
my $operators   = "[\+\-\/\%\=\>\<\!\|\^\&\~\*]";
my $loops       = "(if|while)";


while ($line = <>) {
    if ($line =~ /^#!/ && $. == 1) { # translate #! line 
        print "#!/usr/bin/perl -w\n";

    } elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) { # Blank & comment lines can be passed unchanged
        print $line;

    } 

    elsif ($line =~ /^\s*\w+\s*\=\s*\w*$/) { # eg var = 43;
        @arrayLine = split (" ", $line);
        $i = 0;
        isVar($line);
    }

    elsif ($line =~ /^\s*$loops/) {
        @ifParts = split ("[:|;]", $line);
        $j = 0;
        
        while ($j <= $#ifParts) {
            $temp1 = $ifParts[$j];
            if ($temp1 =~ /$loops/) {
                loopFunc($temp1);
            } elsif ($temp1 =~ /print/) {
                printing($temp1);
            }
            else {
                isVar($temp1);
            }

            $j++;
        }
        print "\}\n";
    }

    elsif ($line =~ /^\s*print/) {
        printing($line);


        # Python's print print a new-line character by default
        # so we need to add it explicitly to the Perl print statement
    
    } else {
    
        # Lines we can't translate are turned into comments
        
        print "#$line\n";
    }
}

sub printing {
    my $line = shift;
    @arrayLine = split(' ', $line);
    $i = 0;

    while ($i <= $#arrayLine) {
        $temp = $arrayLine[$i];      # goes through the array and sets temp to each elt in the array
        
        if ($temp =~ /print/) {      # if the elt is a print line then..
            print "print ";
        }

        else {
            print looks_like_number($temp)? '' : '$' , "$temp"; # sub1 if the elt is a string print a $ infront of it coz its a variable
        }
        $i++;
    }
    print ";\nprint \"\\n\";\n";
}


sub isVar {
    $line = shift;
    #if ($line =~ /^\s*\w+\s*\=\s*\w*$/) { # eg var = 43;
    @arrayLine = split (" ", $line);
    $i = 0;

    while ($i <= $#arrayLine) {
        $temp = $arrayLine[$i];
        if ($temp =~ /$operators/){
            print " $temp ";
        }
        else {
            print looks_like_number($temp)? '' : '$' , "$temp"; #if the elt is a string print a $ infront of it coz its a variable
        }
        $i++;
    }            
    print "\;\n";
}

sub loopFunc {
    $line = shift;
    @arrayLine = split (" ", $line);
    
    $i = 0;
    while ($i <= $#arrayLine) {
        if ($arrayLine[$i] =~ /$loops/) {
            print "$arrayLine[$i] (";
        }
        elsif ($arrayLine[$i] =~ /$operators/) {
            print "$arrayLine[$i] ";
        } 
        else {
            print looks_like_number($arrayLine[$i])? '' : '$' , "$arrayLine[$i] ";
        }
        $i++;
    }
    print "\) \{\n";
}


