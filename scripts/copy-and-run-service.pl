#!/usr/bin/env perl
my $username = $ARGV[0];
my $option = $ARGV[1];

### _____________________________________________________________________________________________
### subroutines
sub executeAndDieOnFail {
    my $result = system($_[0]);
    if($result) { die $result;}
}

sub copyService {
    print "-> copyService\n";
    ### repository/username
    print " username: ".$_[0]."\n";
    ###
    my $command = "cp service-files/".$_[0].".service /etc/systemd/system/";
    executeAndDieOnFail($command);
}
sub copySocket {
    print "-> copySocket\n";
    ### repository/username
    print " username: ".$_[0]."\n";
    ###
    my $command = "cp service-files/".$_[0].".socket /etc/systemd/system/";
    executeAndDieOnFail($command);
}

sub runService {
    print "-> runService\n";
    ### repository/username
    print "  username: ".$_[0]."\n";
    ###

    $command = "systemctl enable ".$_[0].".service";
    # executeAndDieOnFail($command);
    system($command);

    $command = "systemctl start ".$_[0].".service";
    # executeAndDieOnFail($command);
    system($command);
}
sub runSocket {
    print "-> runSocket\n";
    ### repository/username
    print "  username: ".$_[0]."\n";
    ###
    $command = "systemctl enable ".$_[0].".socket";
    # executeAndDieOnFail($command);
    system($command);
    
    $command = "systemctl start ".$_[0].".socket";
    # executeAndDieOnFail($command);
    system($command);
}
### _____________________________________________________________________________________________

if(!defined($username)) { die "username is not defined!";}
print $username."\n";
copyService($username);

if(!defined($option)) {
    runService($username);
} else if($option eq "socket") { 
    copySocket($username);
    runSocket($username);
} else if($option ne "norun") {
    runService($username);
}