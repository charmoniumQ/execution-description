---
verbosity: ERROR
fail-if-warnings: yes
table-of-contents: no
strip-comments: yes
citeproc: yes
cite-method: biblatex # or natbib or biblatex
bibliography:
  - common/sams-zotero-export
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
      # department:
      #   - Software Engineering and Research Department
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
      institution: University of Illinois Urbana-Champaign
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
papersize: letter
pagestyle: plain
lang: en-US
standalone: yes # setting to yes calls \maketitle
number-sections: yes
indent: no
keywords:
  - reproducibility
  - linked data
  - semantic web
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

# Introduction

In practice, those seeking to reproduce a computational experiment often need to manually look at the code to see how to build necessary libraries, configure parameters, find data, and invoke the experiment; it is not _automatic_.
Automatic reproducibility is a more stringent goal, but working towards it would benefit the community.
This work discusses a machine-readable language for specifying how to execute a computational experiment.

There is no existing standard place to put the "main" command which executes an experiment.
e.g., a Makefile which defines a rule for executing the experiment alongside rules for compiling intermediate pieces is not sufficient because there is no machine-readable way to know which of the Make rules executes the experiment.
Automatically identifying the "main" command would be very useful for those seeking to reproduce results from past experiments or reusing experiments to address new use cases.
For software engineering researchers, having a standardized way to run many different codes at scale would open new avenues for data mining research on reproducibility (c.f., \cite{collberg_repeatability_2016,trisovic_large-scale_2022,grayson_automatic_2023}).
We invite interested stakeholders to discuss this language at <https://github.com/charmoniumQ/execution-description>.

Even with workflows, correctly invoking the experiment is still not automatic.
In a recent study, more than 70% of workflows do not work out-of-the-box \cite{grayson_automatic_2023}; for instance, they might require the user to specify data or configure parameters for their use-case.
While flexibility is desirable, it should not preclude default invocation in a standard location for testing purposes.
For example, the Snakemake workflow engine has a standard^[See Snakemake Catalog rules for inclusion here: <https://snakemake.github.io/snakemake-workflow-catalog/?rules=true>] for documenting the required arguments of its workflows, this standard does not have a place to put an example invocation^[See this discussion  on GitHub: <https://github.com/snakemake-workflows/dna-seq-varlociraptor/pull/204#issuecomment-1432876029>].

# Towards a Standard for Automatic Reproducibility

There are many solutions for expressing how to run code, including bash scripts, continuous integration scripts, workflows, and container specifications.
One can manually sleuth around how to run a handful of experiments, but large-scale reproduction studies need to analyze hundreds or thousands of codes \cite{collberg_repeatability_2016,zhao_why_2012,grayson_automatic_2023}.
They each use different tools to invoke their experiment.
Moreover, when a code crashes in such a study, it is difficult to assess whether there is a fault with the code or whether the study did not invoke the code as intended.
While we do not expect (or recommend) that the scientific software community converge on a single solution for executing codes, we see value in having a standard way of documenting how to run each code that could hand off to the user's tool of choice.

One could implement such a specification using linked-data on the semantic web.
Defining the language in linked data lets one link to existing data and reuse existing ontologies such as RO-crate \cite{soiland-reyes_packaging_2022}, Dublin Core metadata terms \cite{weibel_dublin_2000}, Description of a Project \cite{wilder-james_description_2017}, nanopublications \cite{groth_anatomy_2010}, Citation Typing Ontology \cite{shotton_cito_2010}, and Document Components Ontology \cite{constantin_document_2016}.

At the most basic level, the automatic reproducibility specification should allow one to specify relevant commands and a string describing their purpose (see `#make` in Appendix \ref{code}).
The strings could be something like "compile", "run", or "make-figures", which would be used the same way by multiple projects.
However, the language should go beyond fixed-strings.

The language should allow users to link commands directly to claims made in publications (see `#links-to-pub` in Appendix \ref{code}).
With such a specification, any person (or program) should be able to execute the experiments which generate figures or claims in an accompanying paper.
For example, the CiTO vocabulary \cite{shotton_cito_2010} can encode to how the result is used as evidence in a specific publication.

The description can be even more granular than a publication.
One could use the DoCO vocabulary \cite{constantin_document_2016} to point to specific figures, tables, or sentences within a document.
Alternatively, one could reference specific scientific claims using the Nanopublication vocabulary \cite{groth_anatomy_2010} (see `#links-to-fig`, `#defines-nanopub`, and `#links-to-nanopub` in Appendix \ref{code}).

RO-crate \cite{soiland-reyes_wf4ever_2013} has terms for describing dependencies between steps, which can be used to encode dependent steps (see `#make-data` and `#plot-figures` in Appendix \ref{code}).
If the code requires a specific computational environment, building that environment can be a prerequisite step.
The purpose of encoding dependencies is not to usurp the build-system or workflow engine, which both already handle task dependencies;
if the experiment already uses a workflow, then the specification should invoke that.
The purpose of task dependencies in the specification is for projects which do not use a workflow engine, or a task that installs the desired workflow engine.

Such a specification could also set bounds on the experiment's parameters, such as the range of valid values or a list of toggleable parameters (see `#example-of-parameters` in Appendix \ref{code}).
This parameter metadata would enable downstream automated experiments like parameter-space search studies, multi-fidelity uncertainty quantification, and outcome-preserving input minimization.

# Getting Adoption

The most useful part of the specification would need _some_ human input to create, which is specifying what the tasks do.
However, we can reduce the manual effort needed to write the specification.

Workflow engines could assist in generating this, since they know all the computational steps, inputs, outputs, and parameters.
Then it could prompt the user with high-level questions (e.g., "What publication is this part of"?) and generate the appropriate specification to invoke themselves.

If the experiment does not use a workflow engine, but someone who can run the experiment is available, an interactive shell session can capture and write the specification.
The user would invoke a shell that records every command, its exit status, its read-files, and its write-files using syscall interposition.
The user would run their code as usual, and after finishing, the shell would assemble the necessary computational steps and prompt the user for high-level questions.

As a last resort, if one finds a publication linking to a specific repository, one can try to guess the main command.
This approach is the current state-of-the-art for large-scale reproduction studies, except a standardized language would allow some large-scale reproduction studies to inform future large-scale reproduction studies on what they did to execute this repository.
Computational scientists at least had an opportunity to influence how to invoke their code in large-scale reproduction studies.
The lack of opportunity for input was a frequent response of scientists to Collberg and Proebsting[^collberg-comments].

[^collberg-comments]:
The authors of publications whose labels are BarowyCBM12, BarthePB12, HolewinskiRRFPRS12, and others responded to Collberg and Proebsting (paraphrasing), "it would have worked; you just didn't invoke the right commands." according to <http://reproducibility.cs.arizona.edu/v2/index.html>.

Computational scientists could benefit from creating these automated reproducibility specifications because large-scale reproduction studies like Collberg and Proebsting \cite{collberg_repeatability_2016}, Zhao et al. \cite{zhao_why_2012}, and others serve as free testing and reproduction of their results.

Ideally, the reproduction specification would be placed in the same location as the computational experiment, often a GitHub repository, so developers can maintain it alongside the code.
In cases where the authors of the GitHub repository are not cooperative, one can instead put reproduction specifications in a repository that holds reproduction specifications written by the community, a "reproducibility library".
Users seeking to reproduce a repository would invoke a tool that looks for an automatic reproducibility specification in the source code repository, in a list of reproducibility libraries, and if none is found, falls back on heuristic to guess how to reproduce the experiment.
The heuristic might have cases such as, "if a Make file exists, run `make all`".
If the fallback succeeds, the tool can upload all its steps to a reproducibility library.

Meanwhile, conferences and publishers could promote such standard specifications as part of reproducibility requirements for publishing.
Currently, to get an artifact evaluation badge, computational scientists would have to write a natural language description of the software environment, what the commands are, how to run them, and where the data end up; meanwhile, an artifact evaluator has to read, interpret, and execute their description by hand.
An execution description could make this automatic; if an execution description exists, the artifact evaluator uses an executor which understands the language and runs all of the commands that reference the manuscript in their `purpose` tag.

# Conclusion

Developing common standards for specifying how to run computational experiments would benefit the scientific community.
It presents a compromise where different teams can implement their codes however they see fit while enabling others to run them easily.
This specification would lead to greater productivity in the (re)use of scientific experiments, empower developers to build tools that leverage those common specifications, and enable software engineering researchers to study reproducibility at scale.

\eject

\bibliographystyle{ACM-Reference-Format}
\bibliography{manual,common/sams-zotero-export}

\appendix

# Listing of an Example Reproducibility Specification
\label{code}

The following language sample is not the final proposal for the complete vocabulary; the peer-review process is not ideal to iterate on technical details.
Instead, we invite technical contributions at the repository, <https://github.com/charmoniumQ/execution-description>.
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
E.g., `rdf:type` refers to `type` in the `rdf` namespace, which resolves to:
http://www.w3.org/1999/02/22-rdf-syntax-ns#rdftype
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
  Links to a publication.
  The publisher may or may not host a linked-data description of the documenta at this URL.
  The purpose of the URL is to unambiguously name the document.
  We need the rdf:Description to reference an external resource.
  -->
  <process rdf:about="links-to-pub">
    <command>make all</command>
    <purpose>
      <rdf:Description>
        <cito:isCitedAsEvidenceBy rdf:resource="https://doi.org/10.1234/123456789" />
      </rdf:Description>
    </purpose>

  <!-- Links to a specific figure within a publication -->
  <process rdf:about="links-to-fig">
    <command>make all</command>
    <purpose>
      <prov:generated>
        <doco:figure>
          <rdf:Description>
            <dc:title>Figure 2b</dc:title>
            <dc:isPartOf rdf:resource="https://doi.org/10.1234/123456789" />
          </rdf:Description>
        </doco:figure>
      </prov:generated>
    </purpose>

  <!--
  Describes an abstract nanopublication claim that this experiment supports.
  This one will say: "this experiment supports the claim that malaria is spread by mosquitoes"
  -->
  <process rdf:about="defines-nanopub">
    <command>make all</command>
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
    Alternatively, the nanopublication claim will live somewhere else.
    Linked data lets us seamlessly reference other documents.
    -->
    <purpose rdf:about="links-to-nanopub">
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

The above RDF/XML can be validated with Python and rdflib:

```py
>>> import rdflib
>>> g = rdflib.Graph().parse("test.xml")
>>> # Now we can iterate over the triples contained in this RDF graph
>>> # Note that "anonymous nodes" will appear as rdflib.term.BNode('...')
>>> list(g)[:5]
[(rdflib.term.BNode('N979c272652c948f48598caa65eaf02da'),
  rdflib.term.URIRef('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'),
  rdflib.term.URIRef('http://www.w3.org/TR/2013/PR-prov-o-20130312/generated')),
 (rdflib.term.URIRef('file:///home/sam/box/execution-description/se4rs/test.xml#plot-figures'),
  rdflib.term.URIRef('file:///.../purpose'),
  rdflib.term.Literal('plot figures', lang='en')),
 (rdflib.term.BNode('N979c272652c948f48598caa65eaf02da'),
  rdflib.term.URIRef('http://purl.org/spar/doco/2015-07-03figure'),
  rdflib.term.BNode('Ned5bd1d9a83b48bfa0798f2f1e296db7')),
 (rdflib.term.BNode('Nc4f1068252194a4d90b91a02f3860cf7'),
  rdflib.term.URIRef('http://wikiba.se/ontology#Statement'),
  rdflib.term.BNode('Nce17a7a5920846788169b713dd655c97')),
 (rdflib.term.BNode('N889f577571ab4c67bc063a0d032eb5cf'),
  rdflib.term.URIRef('file:///.../purpose'),
  rdflib.term.BNode('Nc4f1068252194a4d90b91a02f3860cf7'))]
```
