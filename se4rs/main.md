---
verbosity: ERROR
fail-if-warnings: yes
table-of-contents: no
strip-comments: yes
citeproc: yes
cite-method: biblatex # or natbib or biblatex
bibliography: main.bib
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
  - name: Daniel S. Katz
    orcid: 0000-0001-5934-7525
    email: dskatz@illinois.edu
    affiliation:
      institution: University of Illinois Urbana-Champaign Department of Computer Science
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
  - authordraft
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
    name: Software Engineering for Research Software
    daterange: July 23--27, 2023
    location: Portland, OR, USA
  copyright: none
  #ccsxml: |
  #  idk
#acks:
topmatter: printacmref=false
shortauthors: Grayson et al.
---

<!--
Terms:
- computational experiment
- computational scientist
- software-engineering researcher
-->

# Introduction

A computational experiment is reproducible if another team using the same experimental infrastructure can make a measurement that concurs with the original.
Investing in reproducibility can improve trustworthiness of scientific results, unlock productivity, and enable reusability and community support\cite{ivie2018reproducibility}.
In practice, reproducers often need to manually work with the code to see how to build necessary libraries, configure parameters, find data, and invoke the experiment; it is not _automatic_.

In this work, we consider the use of specification languages that would provide machine-readable metadata on how to interact with a piece of software.
It is not enough for the language to merely contain a run command in a heap of other commands;
e.g., a Makefile which defines a rule for executing the experiment alongside rules for compiling intermediate pieces is not sufficient, because there is no machine-readable way to know which of the Make rules executes the experiment.
Being able to automatically identifying the "main" command which executes the experiment, for instance, would be very useful for those seeking to reproduce results from past experiments or reusing experiments to address new use cases.
Moreover, from a research perspective, having a standardized way to run many different codes at scale would open new avenues for data mining research on reproducibility (c.f., \cite{collberg_repeatability_2016}).

# Towards Specification Standards for Automated Reproducibility Assessment

At present, there are a diverse range of solutions for expressing how a code should be run, including bash scripts, environment management specifications (e.g., Spack, Nix, Python Virtualenv), continuous integration scripts, workflows, and container specifications. In our own research on reproducibility of scientific codes, as we scale up our studies to include many different codes, keeping track of how to execute each one becomes very complicated. Moreover, when a code fails to run or deliver reproducible results, it is difficult to assess whether there is a fault with the code or whether we failed to run the code in the correct way. While we do not expect (or recommend) that the scientific software community converge on a single solution for executing codes, we do see value in having a standard way of documenting how each code ought to be run. The point of this article is to argue that the community should spend effort developing the right vocabulary and constructs for such a standard. Such a language could be implemented as a linked-data ontology like the semantic web. This would enable us to build on a rich set of ontologies for describing digital and physical resources (RO-crate, wf4prov, software project description, scientific hypotheses, CiTO), and we could leverage the ecosytem of existing tools for ontology management. 

At a very basic level, one could specify available commands and the purpose that they serve (e.g., run make to compile underlying libraries and run main.py to generate figures). But more than just that, a linked data specification standard would enable researchers to link inputs and outputs of codes directly to claims made in publications. For example, the CiTO vocabulary \cite{shotton_cito_2010} can be used to how the result of a process is used as evidence in a specific publication. The description can be even more granular, such as by using the DoCO vocabulary \cite{constantin_document_2016} to point to specific elements (e.g., figures) within a document, or to reference a Nanopublication, which is a semantic web description of the scientific claim. Meanwhile, in addition to specifying the computational environment and command to run, such a specification language could also be used to set bounds on the parameters of the experiment, such as the range of valid values or a list of toggleable parameters; this would enable downstream automated experiments like parameter-space search studies, multi-fidelity uncertainty quantification, and outcome-preserving input minimization.

With such a specification, any person (or program) should be able to execute the experiments which generate figures or claims in an accompanying paper. This would not replace any of the underlying tools, libraries, or frameworks used at present, but it would provide a common vocabulary for explaining how those tools, libraries, and frameworks are employed. 

# Incentivizing Adoption of Specifications

With a defined specification language in place, tooling could be built to make it as easy as possible to generate a specification document. For example, an execution description could be "captured" from an interactive shell session with the user. They would invoke a shell that records every command, its exit status, its read-files, and its write-files (using syscall interposition); When the user exits, the shell will create a directed acyclic graph based on the read-files and write-files, and for each output file that is not consumed by another command, the shell would prompt the user to describe that command's purpose. Alternatively, in cases where the description cannot be captured by an interactive shell session, it may be possible to encode a system of logic that humans would use to deduce the experimental structure; this is similar to the approach taken by FlaPy \cite{gruber_empirical_2021}, a large-scale re-execution study for Python unittests, to install the Python environment.

Meanwhile, conferences and publishers could promote the use of such standard specifications as part of reproducibility requirements for publishing. To get an artifact evaluation badge, normally computational scientists would have to write a natural language description of what the software environment, what the commands are, how to run them, and where does the data end up; meanwhile, an artifact evaluator has to read, interpret, and execute their description by hand. An execution description could make this nearly automatic; if a execution description exists, the artifact evaluator uses an executor which understands the language and runs all of the commands that reference the manuscript in their `purpose` tag. The only manual labor is comparing these results to those in the paper. Even that comparison can be simplified, if the last step in the execution description outputs a boolean representing "is the hypothesis proven?"; the reviewer just needs to see that all of these output "true".

# Conclusion

In this position paper, we argue that developing common standards for specifying how computational experiments should be run to get reproducible results would benefit the scientific community. It presents a compromise where different teams can implement their codes in whatever way they see fit while enabling others to easily run them. This would lead to greater productivity in the (re)use of scientific experiments, empower developers to build tools that leverage those common specifications, and enable software engineering researchers to study reproducibility at scale
