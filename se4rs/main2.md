---
verbosity: ERROR
fail-if-warnings: yes
table-of-contents: no
strip-comments: yes
citeproc: yes
cite-method: biblatex # or natbib or biblatex
bibliography:
  - sams-zotero-export
  - manual
link-citations: yes # in-text citation -> biblio entry
link-bibliography: yes # URLs in biblio
notes-after-punctuation: yes
title: "Wanted: standards for automatic reproducibility of computational experiments"
#shortitle:
#subtitle:
date: 2023-05-22
author:
  - name: Samuel Grayson
    orcid: 0000-0001-5411-356X
    email: grayson5@illinois.edu
    affiliation:
      institution: University of Illinois Urbana-Champaign
      department:
        - Department of Computer Science
      streetaddress:  201 North Goodwin Avenue MC 258
      city: Urbana
      state: IL
      country: USA
      postcode: 61801-2302
  - name: Reed Milewicz
    orcid: 0000-0002-1701-0008
    email: rmilewi@sandia.gov
    affiliation:
      department:
        - Software Engineering and Research Department
      institution: Sandia National Laboratories
      city: Albuquerque
      state: NM
      country: USA
      postcode: 87123
      streetaddress: 1515 Eubank Blvd SE1515 Eubank Blvd SE
  - name: Joshua Teves
    orcid: 0000-0002-7767-0067
    email: jbteves@sandia.gov
    affiliation:
      department:
        - Software Engineering and Research Department
      institution: Sandia National Laboratories
      city: Albuquerque
      state: NM
      country: USA
      postcode: 87123
      streetaddress: 1515 Eubank Blvd SE1515 Eubank Blvd SE
  - name: Daniel S. Katz
    orcid: 0000-0001-5934-7525
    email: dskatz@illinois.edu
    affiliation:
      institution: University of Illinois Urbana-Champaign Department of Computer Science
      department:
        - Department of Computer Science
        # Only one department shows in this ACM document type.
        # - National Center for Supercomputing Applications
        # - Deparment of Electrical and Computer Engineering
        # - School of Information Sciences
      streetaddress:  201 North Goodwin Avenue MC 258
      city: Urbana
      state: IL
      country: USA
      postcode: 61801-2302
  - name: Darko Marinov
    orcid: 0000-0001-5023-3492
    email: marinov@illinois.edu
    affiliation:
      institution: University of Illinois Urbana-Champaign
      department:
        - Department of Computer Science
      streetaddress:  201 North Goodwin Avenue MC 258
      city: Urbana
      state: IL
      country: USA
      postcode: 61801-2302
classoption:
  - manuscript
papersize: letter
pagestyle: plain
lang: en-US
standalone: yes # setting to yes calls \maketitle
number-sections: yes
indent: no
#keywords:
#  - pass
publisher:
  # received_date: 20 February 2007
  # revised_date: 12 March 2009
  # accepted_date: 5 June 2009
  # doi: XXXXXXX.XXXXXXX
  # isbn:978-1-4503-XXXX-X/18/06
  # submission_id: 123-A56-BU3
  # volume: 10
  # issueNumber: 10
  # articleNumber: 10
  year: 2023
  # articleSequenceNumber: 10
  # acmBadge:
  #   - link: http://ctuning.org/ae/ppopp2016.html
  #     pdfImage: ae-logo
  # startPage: 10
  conference:
    acronym: SE4RS'23
    name: Soft. Eng. 4 Res. Sci.
    daterange: July 23--27, 2023
    location: Portland, OR
  copyright: none
  ccsxml: |
    \begin{CCSXML}
    <ccs2012>
    <concept>
    <concept_id>10002951.10003260.10003309.10003315.10003314</concept_id>
    <concept_desc>Information systems~Resource Description Framework (RDF)</concept_desc>
    <concept_significance>300</concept_significance>
    </concept>
    <concept>
    <concept_id>10010405.10010476.10003392</concept_id>
    <concept_desc>Applied computing~Digital libraries and archives</concept_desc>
    <concept_significance>500</concept_significance>
    </concept>
    <concept>
    <concept_id>10011007.10011074.10011111.10010913</concept_id>
    <concept_desc>Software and its engineering~Documentation</concept_desc>
    <concept_significance>500</concept_significance>
    </concept>
    </ccs2012>
    \end{CCSXML}
    \ccsdesc[300]{Information systems~Resource Description Framework (RDF)}
    \ccsdesc[500]{Applied computing~Digital libraries and archives}
    \ccsdesc[500]{Software and its engineering~Documentation}
#acks:
topmatter: printacmref=false
shortauthors: Grayson et al.
---

A computational experiment is reproducible if another team using the same experimental infrastructure can make a measurement that concurs with the original.
In practice, reproducers often need to manually work with the code to see how to build necessary libraries, configure parameters, find data, and invoke the experiment; it is not _automatic_.
Automatic reproducibility is a more stringent goal, but working towards it would benefit the community.
This work discusses a machine-readable language for specifying how to execute a computational experiment.

Document pending Sandia's information release policy.
