#!/usr/bin/env perl
# Copyright (c) 2009 Savvas Radevic <vicedar@gmail.com>
# License: Perl license http://dev.perl.org/licenses/

# Needs HTML::Parser
# apt-get install libhtml-parser-perl

use strict;
use warnings;
use LWP::Simple;

my $uri = 'https://launchpad.net/ubuntu/+cdmirrors';
my $htmlcontent = get($uri);

package GetTitles;
use base qw(HTML::Parser);
my (@title_names, @title_links, @title_countries);
my ($title_tag, $link, $domain, $country);
my $title_count = 0;
sub start {
    my ($self, $tag, $attr, $attrlist, $origtext) = @_;
    # If HTML tag is "a" (or "A")
    if ($tag =~ /^a$/i and $attr->{href} =~ m#^(?:http|ftp|rsync)://([^/]+)#i) {
        $domain = $1;
        if ($domain =~ m/\.([^\.]{2})$/i) { $country = uc("$1"); }
        else { $country = ""; }
        push(@title_countries, $country);
        
        $title_tag = 1;
        $link = $attr->{href};
        push(@title_links, $link);
        $title_count++;
    }
}
sub text {
    my ($self, $plaintext) = @_;
    # If we're in the anchor tag, and text is "http" or "ftp"
    if ($title_tag and $plaintext =~ /^(?:http|ftp|rsync)$/i) {
        push(@title_names, $plaintext);
    }
}
sub end {
    my ($self, $tag, $origtext) = @_;
    if ($tag =~ /^a$/i) { $title_tag = 0; }    
    if ($tag =~ /^html$/i) {
        # Process the list of data
        &ProcessTitles(@title_names, @title_links);
    }
}
sub ProcessTitles {
    my $x = 0;
    foreach my $item (@title_names) {
        print "protocol=\"$item\" type=\"$item\" location=\"$title_countries[$x]\" link: $title_links[$x]\n";
        $x++;
    }
}

package main;
my $gettitles = GetTitles->new;
$gettitles->parse($htmlcontent);
