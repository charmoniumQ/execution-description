---
verbosity: WARNING
fail-if-warnings: yes
table-of-contents: no
strip-comments: yes
citeproc: yes
cite-method: biblatex # or natbib or biblatex
bibliography:
  - common/sams-zotero-export
link-citations: yes # in-text citation -> biblio entry
link-bibliography: yes # URLs in biblio
notes-after-punctuation: yes
title: "Towards a dataset of executions of computational experiments"
#shortitle:
#subtitle:
date: 2023-05-22
author:
  - name: Samuel Grayson
    orcid: 0000-0001-5411-356X
    email: grayson5@illinois.edu
    affiliation:
      institution: University of Illinois Urbana Champaign
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
  - name: Darko Marinov
    orcid: 0000-0001-5023-3492
    email: marinov@illinois.edu
    affiliation:
      institution: University of Illinois Urbana Champaign
      department:
        - Department of Computer Science
      streetaddress:  201 North Goodwin Avenue MC 258
      city: Urbana
      state: IL
      country: USA
      postcode: 61801-2302
  - name: Daniel S. Katz
    orcid: 0000-0001-5934-7525
    email: dskatz@illinois.edu
    affiliation:
      institution: University of Illinois Urbana Champaign
      department:
        - Department of Computer Science
        - National Center for Supercomputing Applications
        - Deparment of Electrical and Computer Engineering
        - School of Information Sciences
      streetaddress:  201 North Goodwin Avenue MC 258
      city: Urbana
      state: IL
      country: USA
      postcode: 61801-2302
classoption:
  - acmsmall
papersize: letter
pagestyle: plain
lang: en-US
standalone: yes # setting to yes calls \maketitle
number-sections: yes
indent: no
# keywords:
#   - reproducibility
#   - linked data
#   - semantic web
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
    acronym: US-RSE
    name: United States Research Software Engineer Association Conference 2023
    daterange: Oct 15--17, 2023
    location: Chicago, IL
  copyright: none
  #ccsxml:
#acks:
topmatter: printacmref=false,printccs=false,printfolios=false
shortauthors: Grayson et al.
---

We call on the researcher community to collaborate to create a FAIR<!--\cite --> dataset of executions of computational experiments.

There are registries of workflows, which are often computational experiments, such as WorkflowHub<!--\cite{ferreira_da_silva_workflowhub_2020} -->, but these registries do not store any execution data, not even a command for executing them.

While some execution artifacts are large, some useful execution details are small, including: the command used to execute the experiment, process success, date/time, platform (OS and architecture), compute resources used (CPU time, wall time, memory, disk space, network bandwidth). For each file read or written: path or URL, type (returned by `file`), 'summary' (hash for binary files, summary statistics for numerical data, etc.), truncated contents.

The above can automatically be collected from an execution without domain knowledge; if a domain specialist is available, they could add a machine-readable description of what the input variables are and how the outputs are to be compared.

<!--
- For each numerical field in each input file or command argument,
  - Is this variable an independent variable or controlled variable?
  - If it is a controlled variable, is it a fidelity parameter or not?
- For each output file,
  - What metric should be used to compare this file between different executions?
- What predicate on the output files would indicate a successful experiment?
-->

For an individual project, this eases answering the following questions:

- Is the experiment replicable? How big of a machine is needed to replicate it? What output should one expect? What files need to exist? If the end output is different, which is the earliest intermediate file that differs significantly?
- Can tolerably similar output be produced with fewer computational resources (by changing the fidelity parameters)?

A collection of projects with this data would enable the following research questions:

- What libraries do these computational experiments use or transitively use?
- Are these computational experiments repeatable in the short-term? What about the long-term (months or years)? Or repeatable within some margin of error? For those that crash, what are the common causes of crashes (could compare to  Zhao et al.<!--\cite{zhao_why_2012}-->)?

Large-scale studies are the best candidates to collect this dataset.
Most large-scale studies, like Zhao et al.<!--\cite{zhao_why_2012}-->, do not share execution details of individual computational experiments, but only aggregate results.
Collberg and Proebsting<!--\cite{collberg_repeatability_2016}--> report the success or failure and how to run individual computational experiments but no other data.
Trisovic et al.<!--\cite{trisovic_large-scale_2022}--> report the success or failure of individual R scripts in Harvard Dataverse but no other data.

We have taken steps towards collecting this dataset for nf-core, Snakemake Workflow Catalog, and R scripts in Harvard Dataverse.
Our data is publicly available.

<!--
TODO: discuss FAIRness, discuss interporable datasets
-->

<!-- \bibliographystyle{ACM-Reference-Format} -->
<!-- \bibliography{common/sams-zotero-export} -->
