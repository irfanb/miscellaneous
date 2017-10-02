JAVARUNTIME=/usr/local/jdk1.2.2/bin/java
SAXONJAR=~/java/saxon/saxon.jar

%.html : %.xml
	$(JAVARUNTIME) -jar $(SAXONJAR) $< discmark.xsl > $@

ALL: website

contactus.html: contactus.xml discmark.xsl
who.html: who.xml discmark.xsl
why.html: why.xml discmark.xsl
how.html: how.xml discmark.xsl
index.html: index.xml discmark.xsl
privacy.html: privacy.xml discmark.xsl
technotes.html: technotes.xml discmark.xsl
bespoke_development.html: bespoke_development.xml discmark.xsl
it_infrastructure.html: it_infrastructure.xml discmark.xsl
web_design.html: web_design.xml discmark.xsl
security.html: security.xml discmark.xsl

#website := $(wildcard *.html)


website: contactus.html \
	who.html \
	why.html \
	how.html \
	index.html \
	bespoke_development.html \
	it_infrastructure.html \
	security.html \
	web_design.html \
	technotes.html \
	privacy.html

publish: website
	

