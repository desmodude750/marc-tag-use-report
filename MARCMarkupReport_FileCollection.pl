#! perl -w
use strict;

system("time /t"); # time begin
system("java -Xmx1200M -Xms1200M -cp C:\\Saxonica9.6\\saxon9pe.jar net.sf.saxon.Transform -t -s:MarcInputTestFile.xml -xsl:MARCMarkupReport.xsl");
system("time /t"); # time end
