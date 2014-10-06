#!/usr/bin/perl
# Starting point for COMP2041/9041 assignment 
# http://www.cse.unsw.edu.au/~cs2041/assignments/python2perl
# written by andrewt@cse.unsw.edu.au September 2014

use Scalar::Util qw(looks_like_number);
my $math = "[\+\-\/\=\*]";

while ($line = <>) {
    if ($line =~ /^#!/ && $. == 1) { # translate #! line 
        print "#!/usr/bin/perl -w\n";

    } elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) { # Blank & comment lines can be passed unchanged
        print $line;

    } 

    elsif ($line =~ /^\s*\w+\s*\=\s*\w*$/) { # eg var = 43;
        
        @arrayLine = split (" ", $line); # puts each thing in an array
        $i = 0;
        while ($i <= $#arrayLine) {
            $temp = $arrayLine[$i];
            if ($temp =~ /$math/){
                print " $temp ";
            }
            else {
                print looks_like_number($temp)? '' : '$' , "$temp"; #if the elt is a string print a $ infront of it coz its a variable
            }

            #$varName  = $arrayLine[$i - 1];
            #$VarValue = $arrayLine[$i + 2];
            #print "\$$varName = $VarValue;\n";
            $i++;
        }
        print "\;\n";
    }

    elsif ($line =~ /^\s*print/) {
        @arrayLine = split (" ", $line); # puts each thing in an array
        $i = 0;
        while ($i <= $#arrayLine) {
            $temp = $arrayLine[$i];      # goes through the array and sets temp to each elt in the array
            
            if ($temp =~ /print/) {      # if the elt is a print line then..
                print "print ";
            }

            else {
                print looks_like_number($temp)? '' : '$' , "$temp"; #if the elt is a string print a $ infront of it coz its a variable
            }
            $i++;
        }
        print ";\nprint \"\\n\";\n"; #force it to print/output the new line


        # Python's print print a new-line character by default
        # so we need to add it explicitly to the Perl print statement
    
    } else {
    
        # Lines we can't translate are turned into comments
        
        print "#$line\n";
    }
}