#!/usr/bin/perl -w

########################################################################################################################
# File Name:    fxScale.pl
# File Purpose: Fixes scale on bklind via panels
# Written by:   Chelsea Dorich  
# Version 1A.:  Date:  09-09-2020   - Initial design and development.
# Contents:  

########################################################################################################################

use Env qw(	
		HOME
		JOB
		GENESIS_DIR
		GENESIS_EDIR
		STEP
		GENESIS_TMP
		GENESIS_VER
		);

use lib ("$GENESIS_EDIR/all/perl");

use strict;
use Genesis;
use Data::Dumper;
use warnings;

use Tie::File;

my $f    = new Genesis();
my $JOB  = $ENV{JOB};
my $STEP = $ENV{STEP};
my $EDIR_PATH = $ENV{GENESIS_EDIR};
my $LIB_PATH = `$EDIR_PATH/misc/dbutil path jobs genesislib`;
my $JOB_PATH = `$EDIR_PATH/misc/dbutil path jobs $JOB`;
my $group = 0;
chomp($LIB_PATH);
chomp($JOB_PATH);



#######################################################################################################

require("/usr/genesis/cdorich/G1_camReview.pl");
my @cu=&getDrillAndCu;
my @polarity=&getpolarity;
#$f->PAUSE($klik[2]);
@cu=@{$cu[1]};

my $line ='';
my $flg_end=0;
my @row=[];
my @index=[];
my @index1=[];
my @topIndx=[];
pop(@topIndx);
my @botIndx=[];
pop(@botIndx);
my $pnl='';
my @tmp=[];
my @cnt=(1..9);
my @cnt1=(1..3);

my $DataFile = "/usr/genesis/fw/jobs/$JOB/misc/stackup_prog.pl";
open(R1, "$DataFile") or die("Cannot open R4 Data file");
        do {
			$line=<R1>;
			# chomp($line=<R1>);
		    # $line =~ s/\r//g;
			@row = split /\=/ , $line;
			if ($line=~ 'pnl_size')
			{	
				$row[1]=substr($row[1],2);
				$row[1]=substr($row[1],0,-3);
				$pnl=$row[1];
				
			}
			if ($row[1] =~ "\"T\"")
			{
				@index = split /\[/ , $row[0];
				@index1 = split /\]/ , $index[1];
				for (@cnt1)
				{
					$line=<R1>;
				}
				
				if($line=~ 'row')
				{
					@index=split(/=/, $line);
					$index[1]=substr($index[1],2);
					$index[1]=substr($index[1],0,-3);
					#$f->PAUSE($index[1]);
				}
				for(@cnt)
				{
					$line=<R1>;
				}
				$line=substr($line,2);
				$line=substr($line,0,-3);
				if($line=~".bv")
				{push(@topIndx , $index[1]-1);}
				
				
	
			}
			elsif ($row[1] =~ "\"B\"")
			 { #$f->PAUSE(@row);
				# $f->PAUSE($row[0]);
				# $f->PAUSE($row[1]);
				@index = split /\[/ , $row[0];
				@index = split /\]/ , $index[1];
				#$f->PAUSE(@index);
				for (@cnt1)
				{
					$line=<R1>;
				}
				
				if($line=~ 'row')
				{
					@index=split(/=/, $line);
					$index[1]=substr($index[1],2);
					$index[1]=substr($index[1],0,-3);
					#$f->PAUSE($index[1]);
				}
				for(@cnt)
				{
					$line=<R1>;
				}
				$line=substr($line,2);
				$line=substr($line,0,-3);
				if($line=~".bv")
				{push(@botIndx , $index[1]-1);}
			
			}
		} until (eof );
#$f->PAUSE(@topIndx);
#$f->PAUSE($pnl);
#$f->PAUSE(@botIndx);

foreach my $x (@topIndx)
 {
	#$f->PAUSE($cu[$x]);
	$f->COM( "open_entity", job => $JOB, type => "step", name => "pnl", iconic => "yes" );
	$f->COM("display_layer,name=$cu[$x],display=yes,number=1");
	$f->COM("work_layer,name=$cu[$x]");
	if($pnl=="12x18")
	{
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=5.92,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=5.92,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.4824967,y=5.92,tol=44.62,cyclic=no"); 
	$f->COM ("sel_delete");
	$f->COM("add_pad, attributes=yes,x=.3875,y=7.0,symbol=rect400x2400,polarity=negative,angle=0,mirror=no,nx=1,ny=1,dx=0,dy=0,xscale=1,yscale=1");
	
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.4824967,y=5.92,text=SC_Y:DISCALEY,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.3224967,y=5.92,text=SC_X:DISCALEX,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	
	}
	if($pnl=="18x24")
	{
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=8.77,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=8.77,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.4824967,y=8.77,tol=44.62,cyclic=no"); 
	$f->COM ("sel_delete");
	$f->COM("add_pad, attributes=yes,x=.3875,y=9.85,symbol=rect400x2450,polarity=negative,angle=0,mirror=no,nx=1,ny=1,dx=0,dy=0,xscale=1,yscale=1");
	
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.4824967,y=8.77,text=SC_Y:DISCALEY,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.3224967,y=8.77,text=SC_X:DISCALEX,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	}
}
foreach my $x (@botIndx)
 {
	#$f->PAUSE($cu[$x]);
	$f->COM( "open_entity", job => $JOB, type => "step", name => "pnl", iconic => "yes" );
	$f->COM("display_layer,name=$cu[$x],display=yes,number=1");
	$f->COM("work_layer,name=$cu[$x]");
	if($pnl=="12x18")
	{
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=8.1,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=8.1,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.4824967,y=8.1,tol=44.62,cyclic=no"); 
	$f->COM ("sel_delete");
	$f->COM("add_pad, attributes=yes,x=.3875,y=7.0,symbol=rect400x2400,polarity=negative,angle=0,mirror=no,nx=1,ny=1,dx=0,dy=0,xscale=1,yscale=1");
	
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.4824967,y=6.95,text=SC_Y:DISCALEY,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.3224967,y=6.95,text=SC_X:DISCALEX,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	}
	if($pnl=="18x24")
	{
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=10.95,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.3224967,y=10.95,tol=44.62,cyclic=no"); 
	$f->COM ("sel_single_feat,operation=select,x=0.4824967,y=10.95,tol=44.62,cyclic=no"); 
	$f->COM ("sel_delete");
	$f->COM("add_pad, attributes=yes,x=.3875,y=9.85,symbol=rect400x2450,polarity=negative,angle=0,mirror=no,nx=1,ny=1,dx=0,dy=0,xscale=1,yscale=1");
	
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.4824967,y=9.8,text=SC_Y:DISCALEY,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	$f->COM ("add_text,attributes=yes,type=orb_plot_stamp_str,x=0.3224967,y=9.8,text=SC_X:DISCALEX,x_size=.08,y_size=.090,w_factor=1,polarity=positive,angle=270,mirror=no,fontname=standard,bar_type=UPC39,bar_char_set=full_ascii,bar_checksum=no,bar_background=yes,bar_add_string=yes,bar_add_string_pos=top,bar_width=0.008,bar_height=0.2,ver=1");
	}
}