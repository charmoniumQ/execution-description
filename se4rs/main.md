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

At present, there are a diverse range of solutions for expressing how a code should be run, including bash scripts, environment management specifications (e.g., Spack, Nix, Python Virtualenv), continuous integration scripts, workflows, and container specifications.
In our own research on reproducibility of scientific codes, as we scale up our studies to include many different codes, keeping track of how to execute each one becomes very complicated.
Moreover, when a code fails to run or deliver reproducible results, it is difficult to assess whether there is a fault with the code or whether we failed to run the code in the correct way.
While we do not expect (or recommend) that the scientific software community converge on a single solution for executing codes, we do see value in having a standard way of documenting how each code ought to be run.
Such a standard could be implemented as a linked-data ontology like the semantic web.
This would enable us to build on a rich set of ontologies for describing digital and physical resources (RO-crate \cite{soiland-reyes_packaging_2022}, Dublin Core metadata terms \cite{weibel_dublin_2000}, Description of a Project \cite{wilder-james_description_2017}, nanopublications \cite{groth_anatomy_2010}, Citation Typing Ontology \cite{shotton_cito_2010}, Documnet Componnets Ontology \cite{constantin_document_2016}) and leverage the ecosytem of existing tools for ontology management (Protégé editor, SHACL, SHEX). <!-- TODO: cite -->

At a very basic level, one could specify available commands and the purpose that they serve (e.g., run make to compile underlying libraries and run main.py to generate figures).
But more than just that, a linked data specification standard would enable researchers to link inputs and outputs of codes directly to claims made in publications.
With such a specification, any person (or program) should be able to execute the experiments which generate figures or claims in an accompanying paper.
For example, the CiTO vocabulary \cite{shotton_cito_2010} can be used to how the result of a process is used as evidence in a specific publication.
These references could be connected to other references of the same publication on the semantic web.
The description can be even more granular, such as by using the DoCO vocabulary \cite{constantin_document_2016} to point to specific elements (e.g., figures) within a document, or using Nanopublication \cite{groth_anatomy_2010} to reference specific scientific claims.
RO-crate \cite{soiland-reyes_wf4ever_2013} has terms for describing dependencies between steps, which can be used to encode dependent steps or specify the computational environment.
This would not replace any of the underlying tools, libraries, or frameworks used at present, but it would provide a common vocabulary for explaining how those tools, libraries, and frameworks are employed.
Such a specification language could also be used to set bounds on the parameters of the experiment, such as the range of valid values or a list of toggleable parameters;
this would enable downstream automated experiments like parameter-space search studies, multi-fidelity uncertainty quantification, and outcome-preserving input minimization.

# Incentivizing Adoption of Specifications

<!-- TODO: three onramps:
1. Support from workflow
2. Captured from interactive session
3. Automatically inferred
-->

With a defined specification language in place, tooling could be built to make it as easy as possible to generate a specification document.
For example, an execution description could be "captured" from an interactive shell session with the user.
They would invoke a shell that records every command, its exit status, its read-files, and its write-files (using syscall interposition); When the user exits, the shell will create a directed acyclic graph based on the read-files and write-files, and for each output file that is not consumed by another command, the shell would prompt the user to describe that command's purpose.
Alternatively, in cases where the description cannot be captured by an interactive shell session, it may be possible to encode a system of logic that humans would use to deduce the experimental structure;
this is similar to the approach taken by FlaPy \cite{gruber_empirical_2021}, a large-scale re-execution study for Python unittests, to install the Python environment.

Meanwhile, conferences and publishers could promote the use of such standard specifications as part of reproducibility requirements for publishing.
To get an artifact evaluation badge, normally computational scientists would have to write a natural language description of what the software environment, what the commands are, how to run them, and where does the data end up; meanwhile, an artifact evaluator has to read, interpret, and execute their description by hand.
An execution description could make this nearly automatic; if a execution description exists, the artifact evaluator uses an executor which understands the language and runs all of the commands that reference the manuscript in their `purpose` tag.
The only manual labor is comparing these results to those in the paper.
Even that comparison can be simplified, if the last step in the execution description outputs a boolean representing "is the hypothesis proven?"; the reviewer just needs to see that all of these output "true".

# Conclusion

In this position paper, we argue that developing common standards for specifying how computational experiments should be run to get reproducible results would benefit the scientific community.
It presents a compromise where different teams can implement their codes in whatever way they see fit while enabling others to easily run them.
This would lead to greater productivity in the (re)use of scientific experiments, empower developers to build tools that leverage those common specifications, and enable software engineering researchers to study reproducibility at scale.

# Appendix I: Example document

This is not the final proposal for the complete vocabulary; the peer-review process is not well-suited to iterate on technical details.
The point of this article is to argue that the community should spend effort developing this vocabulary.

\small
```xml
<?xml version="1.0" encoding="utf-8"?>
<!--
RDF can be serialized as XML, JSON, or triples; backend RDF parsers don't care.
We chose XML because it might be more familiar to readers.
-->

<!--
The following tag imports several other vocabularies behind a namespace.
E.g., `rdf:type` refers to `type` in the `rdf` namespace, which resolves to `http://www.w3.org/1999/02/22-rdf-syntax-ns#rdftype`.
Elements with no namespace are resolved within the default namespace,
which is our proposed execution-description vocabulary, http://example.org/execution-description/1.0.
-->

<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
         xmlns:dc="http://purl.org/dc/elements/1.1/"
         xmlns:wikibase="http://wikiba.se/ontology#"
         xmlns:cito="http://purl.org/spar/cito"
         xmlns:doco="http://purl.org/spar/doco/2015-07-03"
         xmlns:prov="http://www.w3.org/TR/2013/PR-prov-o-20130312/"
         xmlns:wfdesc="http://purl.org/wf4ever/wfdesc#"
         xml:lang="en"
         >

  <!--
  Here, we list some relevant commands, and how they relate to the artifact.
  -->
  <process rdf:about="#make">
    <!-- The following would get run by the UNIX shell. -->
    <command>make libs</command>
    <!-- Here is a string representing the purpose. -->
    <purpose>compiles libraries</purpose>
  </process>

  <!--
  Here, we make a process that depends on a previous process using wfdesc.
  -->
  <process rdf:about="#make-data">
    <command>python3 make_data.py</command>
    <purpose>makes data</purpose>
  </process>
  <process rdf:about="#plot-figures">
    <command>python3 figures.py</command>
    <purpose>plot figures</purpose>
    <dependsOn rdf:resource="#make-data" />
    <!--
    The # is not a typo; the rdf:about becomes a URL fragment in the current document.
    This means one can access a computational step in another document here,
    like "https://example.com/software-experiment-23#make-data".
    -->
  </process>
  <!-- Users may choose the more complex wfdesc vocabulary if they wish. -->

  <!--
  A process can have as many purpose tags as it needs.
  We will use this opportunity to try some more advanced purpose tags.
  -->
  <process rdf:about="examples-of-purpose">
    <command>make all</command>

    <!--
    Links to a publication.
    The publisher may or may not host a linked-data description of the documenta at this URL.
    The purpose of the URL is to unambiguously name the document.
	We need the rdf:Description to reference an external resource.
    -->
    <purpose>
      <rdf:Description>
		<cito:isCitedAsEvidenceBy rdf:resource="https://doi.org/10.1234/123456789" />
	  </rdf:Description>
    </purpose>

    <!-- Links to a specific figure or sentence within a publication. -->
    <purpose>
      <!-- Links to a specific figure within a publication -->
      <prov:generated>
        <doco:figure>
		  <rdf:Description>
			<dc:title>Figure 2b</dc:title>
			<dc:isPartOf rdf:resource="https://doi.org/10.1234/123456789" />
		  </rdf:Description>
        </doco:figure>
      </prov:generated>
    </purpose>

    <!-- Describes an abstract nanopublication claim that this experiment supports. -->
    <purpose>
      <cito:supports>
        <!--
        We will use Wikidata here.
        They have catalogued many real-world objects and concepts as linked-data objects.
        -->
        <wikibase:Statement>
		  <rdf:Description>
			<!-- Q12156 refers to malaria -->
			<subject rdf:resource="https://www.wikidata.org/entity/Q12156" />
			<!-- P1060 refers to disease transmission process (read: "is transmitted by") -->
			<predicate rdf:resource="http://www.wikidata.org/prop/P1060" />
			<!-- Q15304532 refers to mosquitoes -->
			<object rdf:resource="https://www.wikidata.org/entity/Q15304532" />
		  </rdf:Description>
        </wikibase:Statement>
      </cito:supports>
    </purpose>

    <!--
    More realistically, the nanopublication claim will live somewhere else.
    Linked data lets us seamlessly reference other documents.
    -->
    <purpose>
	  <rdf:Description>
		<cito:supports rdf:resource="https://example.com/article24#claim31" />
	  </rdf:Description>
    </purpose>
  </process>

  <!-- Here, we add parameters to the command -->
  <process rdf:label="example-of-parameters">
    <!-- These might be template filled like so: -->
    <command>./generate ${max_resolution} ${rounds}</command>
    <wfdesc:Parameter rdfs:label="max_resolution" />
  </process>

</rdf:RDF>
```
\normalsize

This can be validated with Python and rdflib:

```
>>> import rdflib
>>> g = rdflib.Graph().parse("test.xml")
>>> # Now we can iterate over the triples contained in this RDF graph
>>> # Note that "anonymous nodes" will appear as rdflib.term.BNode('...')
>>> list(g)[:5]
[(rdflib.term.BNode('N979c272652c948f48598caa65eaf02da'), rdflib.term.URIRef('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), rdflib.term.URIRef('http://www.w3.org/TR/2013/PR-prov-o-20130312/generated')),
(rdflib.term.URIRef('file:///home/sam/box/execution-description/se4rs/test.xml#plot-figures'), rdflib.term.URIRef('file:///.../purpose'), rdflib.term.Literal('plot figures', lang='en')),
(rdflib.term.BNode('N979c272652c948f48598caa65eaf02da'), rdflib.term.URIRef('http://purl.org/spar/doco/2015-07-03figure'), rdflib.term.BNode('Ned5bd1d9a83b48bfa0798f2f1e296db7')),
(rdflib.term.BNode('Nc4f1068252194a4d90b91a02f3860cf7'), rdflib.term.URIRef('http://wikiba.se/ontology#Statement'), rdflib.term.BNode('Nce17a7a5920846788169b713dd655c97')),
(rdflib.term.BNode('N889f577571ab4c67bc063a0d032eb5cf'), rdflib.term.URIRef('file:///.../purpose'), rdflib.term.BNode('Nc4f1068252194a4d90b91a02f3860cf7'))]
```

# How to get automatic reproducibility


## Language description

One can view specifying the software environment as just prerequisite steps in the computational DAG[^define-dag].
The purpose of an execution language is not to usurp the build-system or workflow engine, which both already handle task DAGs; there must be some minimal support for DAGs just for the cases where the DAG of tasks is not already encoded in a build-system or workflow engine.

[define-dag]:
A computaitonal directed acyclic graph (DAG) is a set of programs and pairs of programs (called links), where each link indicates the output of one program is the input to the other program.
This is the basic concept of GNU Make, workflows, and build systems.

This is the dream of linked data: machine-readable data by different authors hosted in different locations linking together seamlessly.
Even if the publisher does not have an RDF+XML description, third parties can make claims about "https://doi.org/10.1234/123456789", although those claims would not be as easily discoverable.
The purpose description can be even more granular, using the DoCO vocabulary \cite{constantin_document_2016}, which describes documents, as shown in the block labeled `fig-pub`.

One could even reference a Nanopublication, which is a semantic web description of the scientific claim \cite{groth_anatomy_2010}, as in the block labeled `claim`.
The claim is itself a subject-predicate-object triple, in this case relating identifiers from Wikidata \cite{erxleben_introducing_2014} to express "malaria is transmitted by mosquitoes".

With this complete, anyone should be able to execute the experiments which supported publications, figures, or claims in the paper if they are labeled by the computational scientist in this language.

In addition to specifying the computational environment and command to run, this language is an ideal candidate to also describe the parameters of the experiment, perhaps using wfdesc \cite{soiland-reyes_wf4ever_2013}.
One could specify range of valid values or list options.
With this complete, one can even do automated parameter-space search studies, multi-fidelity uncertainty quantification, automated outcome-preserving input minimization, and other automatic experiments.

Retrospective provenance seeks to encode how we got to a specific result.
Developers can put summary statistics of intermediate results into the provenance description; if re-executions diverge, users can locate which stage amplifies error the most.
A tool might use system-call interposition to learn about a processes reads, writes, and forks.
This would be better at identifying and recording intermediate results.
When reproducing some computational experiment, users can check the intermediate results to see where they begin to differ.
Wfprov is one vocabulary for specifying retrospective provenance, and there is already an experimental plugin for Nextflow which targets wfprov \cite{grande_nf-prov_2023}.
<!--
Q: Developers may not know the answers to those questions...
A: This would not be known a priori by developers; it would be after they do a real execution.
-->
Users may also want to know how much computational resources (CPU time, disk space, and RAM) the computational experiment requires.
Provenance is the ideal place for computational experiments who already ran the experiment to put this information.
This way, users seeking to reproduce the computational experiment know how many resources to request (ahead-of-time allocations are usuually required for batch-scheduled machines).

# Making easy on-ramps for adoption

The execution language should seek to describe existing software frameworks, not replace them.
In particular, execution should not replace workflow engines.
They should instead be wrapped as process-nodes within the execution language.
Computational experiments can continue using their existing build-system and workflow.

A execution description could even be "captured" from an interactive shell session with the user.
They would invoke a shell that records every command, its exit status, its read-files, and its write-files (using syscall interposition).
The user would execute their build-system like normal within this shell.
When the user exits, the shell will create a DAG based on the read-files and write-files.
For each output file that is not consumed by another command, the shell would prompt the user to describe that command's purpose.
Finally, the shell would output a execution description.

In cases where the description cannot be captured by an interactive shell session, one can encode the system of logic that humans would use to deduce the experimental structure.
This is similar to the approach taken by FlaPy \cite{gruber_empirical_2021}, a large-scale re-execution study for Python unittests, to install the Python environment.
For example,

1. If `shell.nix`, `flake.nix`, or `environment.yml` exists, then use Nix, Nix flakes, or Conda as the environment for future commands.
2. If the environment is not already set, and `requirements.txt` exists, use Pip and Virtualenv as the environment for future commands.
2. If `CMakeLists.txt` exists, set `cmake` and `make` as commands.
3. If `configure.sh` exists, set `./configure` and `make` as command.
4. If `Makefile` exists, set `make` as command.
...

In the best case, the execution description would be uploaded to the same repository or location that contains the source for the computational experiment.
This way it can be maintained and used by the original developers, and it is easily discoverable by users.
Alternatively, execution descriptions could be placed in a central execution-description repository owned by software-engineering researchers.
<!-- TODO: What entity would do this?-->
The execution description is linked data, so it can live anywhere, and existing strategies for finding, filtering, and trusting linked data sets would work for execution descriptions.

This is similar to the approach taken by Python for type annotations.
Type annotations are easiest to maintain in the original repository, but if the original repository rejects type annotations, there is still a home for them in typeshed.
<!-- TODO: Cite Python PEP -->

Is this another competing standard?
It is something extra users have to do, but it does not attempt to displace their existing practice.

<!-- TODO elaborate
Workflow engines also usually cannot manage themsleves; what if a code needs a newer version of the workflow engine currently reading the specification?
It is simpler to make a agnostic standard that can invoke any workflow engine or other tool of the users' choosing.
Automatic reproducibility specification should not be perceived competing with workflows; in the best case, the specification would just invoke a workflow engine, which can be supported by the preceding automatic on-ramp.
 -->

# Incentives for computational scientists to maintain execution descriptions

Computational scientists are incentivized to describe their project this way to benefit from the work of software-engineering researchers.
When software-engineering researchers do a large-scale execution study, it is a "free" reproduction of their work.
<!-- TODO: I challenge the assumption that this reproduction of a work is actually something of perceived value to the original experimentalists.-->

<!-- TODO: connect to RO-crate -->
To get an artifact evaluation badge, normally computational scientists would have to write a natural language description of what the software environment, what the commands are, how to run them, and where does the data end up.
The artifact evaluator has to read, interpret, and execute their description by hand.
An execution description could make this nearly automatic; if a execution description exists, the artifact evaluator uses an executor which understands the language and runs all of the commands that reference the manuscript in their `purpose` tag.
The only manual labor is comparing these results to those in the paper.
Even that comparison can be simplified, if the last step in the execution description outputs a boolean representing "is the hypothesis proven?"; the reviewer just needs to see that all of these output "true".

<!-- Cite Collberg and Proebsting's first and second project -->


<!-- 
TODO
# How to exploit for software-engineering research
-->

<!--
Potential collaborators
Bertram Ludascher
Sandia 1424, ECMF
-->
