#!/usr/bin/perl
# Starting point for COMP2041/9041 assignment 
# http://www.cse.unsw.edu.au/~cs2041/assignments/python2perl
# written by andrewt@cse.unsw.edu.au September 2014

while ($line = <>) {
    if ($line =~ /^#!/ && $. == 1) { # translate #! line 
        print "#!/usr/bin/perl -w\n";

    } elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) { # Blank & comment lines can be passed unchanged
        print $line;

    } 
    if ($line =~ /=/) {
        @arrayLine = split (" ", $line); # puts each thing in an array
        $i = 0;
        $varName  = $arrayLine[$i - 1];
        $VarValue = $arrayLine[$i + 2];
        
    }

    elsif ($line =~ /^\s*print\s*"(.*)"\s*$/) {
        @arrayLine = split (" ", $line); # puts each thing in an array
        $i = 0;
        while ($i <= $#arrayLine) {
            $temp = $arrayLine[$i];      # goes through the array and sets temp to each elt in the array
            
            if ($temp =~ /print/) {      # if the elt is a print line then..
                print "print";
            }

            else { #print what ever is in the double quotes 
                print " $temp";
            }
            $i++;
        }
        print "; print \"\\n\";\n"; #force it to print/output the new line


        # Python's print print a new-line character by default
        # so we need to add it explicitly to the Perl print statement
    
    } else {
    
        # Lines we can't translate are turned into comments
        
        print "#$line\n";
    }
}