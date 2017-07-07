As an example, I'm taking the Y4 seismic network

http://geofon.gfz-potsdam.de/waveform/archive/network.php?ncode=Y4

Datacite metadata is here:
http://data.datacite.org/application/x-datacite+xml/10.14470/L9180569

I'm applying dataciteToISO19139v3.xslt .

And I have a few comments about the output...


1. In output there's a blank space before the 'doi:...' string:

   <gco:CharacterString> doi:10.14470/L9180569</gco:CharacterString>

   at /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/
   gmd:citation/ gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/
   gmd:code/gco:CharacterString


2. The string about "Responsible party" should be changed to GFZ at least:

        <gco:CharacterString>Interdisciplinary Earth Data Alliance | Lamont Dohe
rty Earth Observatory | Columbia Univeristy</gco:CharacterString>

    at /gmd:MD_Metadata/gmd:contact/gmd:CI_ResponsibleParty/
    gmd:organisationName/gco:CharacterString

    to e.g GFZ Data Services" or "Helmholtz-Zentrum Potsdam - ... GFZ"?


3. Output on creators has "missing@unknown.org" as the
   electronicMailAddress. Shouldn't that element just be left out if
   we don't have an e-mail address?

   (We have a few problems with e-mail addresses:
    i.   we don't know them, and can't keep them up to date
    ii.  sometimes PIs are gone, move on, or die. See (i)
    iii. privacy issue: in each case the contact should have *consented*
         to having their e-mail address included in this public metadata.)

    Should we go back and bug all our contacts just to get them to
    agree to putting something valid here?

              <gmd:contactInfo>
                <gmd:CI_Contact>
                  <gmd:address>
                    <gmd:CI_Address>
                      <gmd:electronicMailAddress>
                        <gco:CharacterString>missing@unknown.org</gco:CharacterString>
                      </gmd:electronicMailAddress>
                    </gmd:CI_Address>
                  </gmd:address>
                </gmd:CI_Contact>
              </gmd:contactInfo>


   There's a note in the XSLT that says:

     "In the INSPIRE profile of the European Union the email is
     mandatory for contacts. Still not sure what to put here."

   ...so I guess you're not sure still. But what do the others
   (Kirsten, Javier, Angelo) think we should do here? DataCite XML
   doesn't appear to me to have any idea of e-mail addresses (at least in
   https://schema.datacite.org/meta/kernel-4.0/doc/DataCite-MetadataKernel_v4.0.pdf
   ) so we cannot maintain our record of PI e-mail addresses in the
   DataCite. We would need some other sort of metadata management for those.
   (I would try to include them in nettabs, I think, but this only
   works for GEOFON of course.)


4. ContactPerson looks funny. The output <gmd:CI_ResponsibleParty> element has:

   - individualName = geofon@gfz-potsdam.de
   - positionName = ContactPerson [zusammen geschrieben!]
   - electronicMailAddress = missing@unknown.org
   - and a CI_RoleCode

   I would expect to see in the INSPIRE md:

   - individualName = "GEOFON Data Centre" [or something similar]
   - electronicMailAddress = geofon@gfz-potsdam.de
   - no positionName, or "Contact Person"

   Or is there a way to flag the contact "person" as being an organistion?

   Loking at the Datacite input below we see the problem: there's no
   way to say X is a person, with e-mail address <x@somewhere.org>.
   So again, we will have to maintain this outside Datacite if we want
   to produce nice ISO19139 output.

    <contributor contributorType="DataManager">
      <contributorName>GEOFON Data Centre</contributorName>
    </contributor>
    <contributor contributorType="ContactPerson">
      <contributorName>geofon@gfz-potsdam.de</contributorName>
    </contributor>



5. Abstract

        <gco:CharacterString>Abstract: The temporary Extended Pollino

   Why does the work "Abstract: " appear at the start here?
   It seems unneeded.


6. The <gmd:resourceConstraints section> states "CC By-NC-SA 3.0 United States"

  Where did that come from?
  What does it apply to? Use of this metadata, or the data it points to?
  If it applies to the data, it is completely wrong, as this dataset
  is certainly NOT CC BY-NC-SA.


7. There is an empty <gml:pos> at 

   /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification
   / gmd:extent / gmd:EX_Extent/ gmd:geographicElement /
   gmd:EX_BoundingPolygon / gmd:polygon / gml:Point

  ... should the polygon element just be omitted,
   or a shorttag <gml:pos/> emitted?
  (maybe the space is from dataciteToISO19139v3.xslt:1520 )


8. MD_DigitalTransferOptions <gmd:transferSize> Real: where
   Where does that value come from? What does it mean?

   (at gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:transferSize gmd:transferSize)

9. <gmd:maintenanceNote>: Should we alter this text? Something like
   this would be better than the last sentence:

    "Prepared automatically at from DOI metadata retrieved
     at {time} by the GEOFON team geofon@gfz-potsdam.de"
    "Initial SXLT was prepared by SMR and DU.

   The time here should include time and timezone, or just date.
   But not date + timezone as now: "2017-07-07+02:00".


Questions for GEOFON management of our metadata:
 - should we try to augment datacite
 - should we maintain additional metadata (somewhere)
 - should Damian's XSLT be changed?

If we modify XSLT, must notify in source/README.md what we have derived.
- the xslt is Apache 2.0-licenced.


----------
App B.

INSPIRE Requirement for e-mail address is explicit enough

CharacteAlbers Equal Area set see p112 - we say UTF-8
- what is ISO-10646?

Bounding Box is required, but we should say 0-360, -90 to 90.

Dataset language := metadata language

metadata data stamp - creation or update p.115


