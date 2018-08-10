<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    extension-element-prefixes="saxon" xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:marc="http://www.loc.gov/MARC21/slim">

    <!-- tell me about the mark tags, codes, and subfields used :) -->

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="slurp" select="collection('marcfiles')"/>

    <xsl:variable name="all-tags">
        <tags>
            <xsl:for-each select="distinct-values($slurp/marc:collection/marc:record/marc:datafield/@tag)">
                <tag><xsl:value-of select="."/></tag>
            </xsl:for-each>
        </tags>
    </xsl:variable>

    <xsl:variable name="tags-with-subfields">
        <tags-fields>
            <xsl:for-each select="$all-tags/tags/tag">
                <xsl:sort/>
                <xsl:variable name="tag-name" select="string(.)"/>
                <tag-field>
                    <tag>
                        <xsl:value-of select="."/>
                    </tag>
                    <xsl:for-each
                        select="distinct-values($slurp/marc:collection/marc:record/marc:datafield[@tag = $tag-name]/marc:subfield/@code)">
                        <subfield>
                            <xsl:value-of select="."/>
                        </subfield>
                    </xsl:for-each>
                </tag-field>
            </xsl:for-each>
        </tags-fields>
    </xsl:variable>

    <xsl:template match="/" exclude-result-prefixes="#all">
        <xsl:result-document href="Marcreport.csv" method="text" encoding="utf-8" exclude-result-prefixes="#all">
            <xsl:for-each select="$tags-with-subfields/tags-fields/tag-field/subfield">
                <xsl:variable name="tag" select="preceding-sibling::tag[1]"/>
                <xsl:value-of select="concat($tag, ',', ., '&#x000D;&#x000A;')"/>
            </xsl:for-each>
        </xsl:result-document>
        <xsl:result-document href="MarcInputTestFile_AllFieldsInData.xml" method="xml" indent="true" encoding="utf-8" exclude-result-prefixes="#all">
            <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                <marc:record>
                    <xsl:comment>bogus leader so validates, alter values as needed for testing</xsl:comment>
                    <marc:leader>01770cam a2200385 a 4500</marc:leader>
                    <xsl:for-each select="$tags-with-subfields/tags-fields/tag-field/tag">
                        <xsl:variable name="tag" select="."/>
                        <marc:datafield tag="{$tag}" ind1=" " ind2=" ">
                            <xsl:for-each select="following-sibling::subfield">
                                <marc:subfield code="{.}">
                                    <xsl:value-of select="concat($tag,.)"/>
                                </marc:subfield>
                            </xsl:for-each>
                        </marc:datafield>
                    </xsl:for-each>
                </marc:record>            
            </marc:collection>
        </xsl:result-document>
    </xsl:template>


</xsl:stylesheet>
