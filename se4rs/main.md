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

A computational experiment is reproducible if another team using the same experimental infrastructure can make a measurement that concurs with the original. Investing in reproducibility can improve trustworthiness of scientific results, unlock productivity, and enable reusability and community support\cite{ivie2018reproducibility}. At the same time, reproducibility is a dynamic quality of the software, one that has to be exercised to prove that the current behavior of the software matches expectations. In practice, reproducers often need to manually work with the code to see how to build necessary libraries, configure parameters, find data, and invoke the experiment; it is not _automatic_. As noted by Lin and Zhang, reproducibility is not a one-off achievement but a ongoing commitment to practices and processes that enable it. We argue that a "defense in depth" approach is needed to safeguard reproducibility, including containers, interactive media such as notebooks and workflows, and policies and standards to promote best practices. 

In this work, we consider the use of specification languages that would provide machine-readable metadata on how to interact with a piece of software. It is not enough for the language to merely contain this command in a heap of other commands; e.g., a Makefile which defines a rule for executing the experiment alongside rules for compiling intermediate pieces is not sufficient, because there is no machine-readable way to know which of the Make rules executes the experiment. Being able to automatically identifying the "main" command which executes the experiment, for instance, would be very useful for those seeking to reproduce results from past experiments or reusing experiments to address new use cases. Moreover, from a research perspective, having a standardized way to run many different codes at scale would open new avenues for data mining research on reproducibility (c.f., \cite{collberg_repeatability_2016}).

<!--
# Existing standards for execution descriptions of computational experiments

Of course, there are some existing standards and conventions that are used to describe how to run a computational experiment.

- **Build systems**:
  While "building" may refer strictly to compiling and linking, many build systems are general enough to be repurposed for describing how to execute a computational experiment.
  E.g., computational experiments might use GNU Make.
  However, build systems do not fully describe the computational environment (e.g., one might have to install system libraries before running `make`).
  There is only a loose convention over how to name the targets (e.g., should one run `make all`, `make`, or `make figure_1.png` to run the computational experiment from scratch?).
  <!-- TODO: There are a lot of e.g.s--><!--

These two cases are less important to my argument
- **Main script**:
  Often there is a main script in the project root (`run.sh` or `main.py`).
  However, In practice main scripts rarely define the software environment; rather they expect to be run from within the proper computational environment.
  This is especially true if the script depends on a specific interpreter which is not found on all systems seeking to execute the experiment (e.g., Bash, Python 3).
  There is no automated way to know what exactly this script does and how "deeply" it re-executes the experiment; E.g., if some intermediate data is already written the main script might skip the experiment and only regenerate the figures.

- **Software environment definitions**:
  Language-neutral (e.g., Spack, Conda, Nix, Guix), and language-specific (e.g., Cargo, Python Virtualenv) environment managers specify the software environment in which the experiment is run.
  They do not, however, specify the command to run the experiment itself.
  For Nix and Guix, one might make the experimental output a "package" within the system, but this is quite rare and poorly supported; for example, there is no way to launch a multi-node MPI job from within the Nix or Guix sandbox, and there is no way of describing which package is the experiment.

- **Continuous integration (CI) script**:
  CI scripts often check an experiment in a defined computational environment as deeply as is feasible given limited CI computational resources.
  However, there are usually not enough computational resources to execute the experiment, and there is no language for describing which, if any, of the CI script executes the computational experiment.

- **Workflow scripts**:
  <!-- TODO: define a DAG --><!--
  A workflow script describes a DAG of tasks for a computational experiment.
  The tasks can be native or containerized.
  In practice, workflow scripts may not contain the inputs needed to run the experiment.
    - Case in point, a recent sample of containerized Snakemake workflows showed that these workflows often do not specify example inputs (cite: unpublished work, in submission to ACM REP '23).
     Even though Snakemake has a standard (<https://snakemake.github.io/snakemake-workflow-catalog/?rules=true>) for specifying the usage of its workflows, this standard does not have a place to put example data or an example invocation (<https://github.com/snakemake-workflows/dna-seq-varlociraptor/pull/204#issuecomment-1432876029>).

A Dockerfile is a combination of the above: a software environment definition composed with an optional main script (in the `CMD`).
Sometimes additional context is needed to build the container (e.g., the files referenceed in `ADD` or `COPY` commands may themselves need to be built).
While multi-stage containers mitigate this problem, in practice <!-- Cite Henkel --> <!--most Dockerfiles cannot be automatically built.
Even if they can be built, the `CMD` might require input data or additional arguments, and there is no convention or standard of listing an "example invocation" in a machine-readable way.
-->

# How to get automatic reproducibility

This is not the final proposal for the complete vocabulary; the peer-review process is not well-suited to iterate on technical details.
The point of this article is to argue that the community should spend effort developing this vocabulary.

## Semantic web

This language could be implemented as a vocabulary for linked data in the semantic web.
Linked data is preferrable for these reasons:

1. Linked data is open to extensions.
2. It is possible to link to other resources in linked data.
3. There is already a rich set of ontologies for describing digital and physical resources (RO-crate, wf4prov, software project description, scientific hypotheses, CiTO) in linked data.
4. There is already a rich ecosystem for authoring ontologies and validating documents within those ontologies.

Linked data is already used for other long-term preservation standards, such as RO-crate.
The template of RDF/XML looks like this:

\small
```xml
<?xml version="1.0"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:cito="http://purl.org/spar/cito"
         xmlns:doco="http://purl.org/spar/doco/2015-07-03"
         xmlns:prov="https://www.w3.org/TR/2013/PR-prov-o-20130312/"
         xmlns:wfdesc="http://purl.org/wf4ever/wfdesc#"
         xmlns="http://example.org/execution-description/1.0" >
...
</rdf:RDF>
```
\normalsize

According to the RDF/XML specification, This imports several other vocabularies behind a namespace.
E.g., `rdf:type` refers to `type` in the `rdf` namespace, which points to `http://www.w3.org/1999/02/22-rdf-syntax-ns#`.
XML tags with no namespace are resolved within the default namespace, which is our proposed execution-description vocabulary.

## Language description

At a very basic level, one could have commands and the purpose that they serve:

\small
```xml

<process>
  <command>./execute --input data.csv</command>
  <purpose>generates data</purpose>
</process>
<process>
  <command>python3 main.py</command>
  <purpose>plots figures</purpose>
</process>
```
\normalsize

While we could define conventions around what to name the content of the "purpose" tag, it would be more powerful if the language could link directly to the claims in the publication.
The CiTO vocabulary \cite{shotton_cito_2010} already defines a vocabulary for describing citations.

\small
```xml
<process>
  <command>./execute --input data.csv</command>
  <purpose>
    <!-- links to an entire publication -->
    <cito:isCitedAsEvidenceBy rdf:resource="https://doi.org/10.1234/123456789" />
  </purpose>
</process>
```
\normalsize

If the publisher hosts an RDF description at the URL "https://doi.org/10.1234/123456789" when the HTTP request content-type header is `application/rdf+xml`, then this creates a web of linked data.
The publisher may have the title, authors, date published, and other metadata using Dublin Core metadata terms, for example.
<!-- cite Dublin core metadata terms -->
This is the dream of linked data: machine-readable data by different authors hosted in different locations linking together seamlessly.
Even if the publisher does not have an RDF+XML description, third parties can make claims about "https://doi.org/10.1234/123456789", although those claims would not be as easily discoverable.
One could even reference a Nanopublication, which is a semantic web description of the scientific claim.
<!-- cite something for Nanopublication, too -->

The purpose description can be even more granular, using the DoCO vocabulary \cite{constantin_document_2016}, which describes documents.

\small
```
<purpose>
  <prov:generated>
    <doco:figure>
      <dc:title>Figure 2b</dc:title>
      <dc:isPartOf rdf:resource="https://doi.org/10.1234/123456789" />
    </doco:figure>
  </prov:generated>
</purpose>
```
\normalsize

With this complete, anyone should be able to execute the experiments which generate figures or claims in the paper if they are labeled by the computational scientist in this language.

<!--
If one command generates data used by other commands, we can use an existing XML workflow vocabularies, such as wfdesc, to define a computational DAG.
This is more rich than an English string describing the purpose.

\small
```xml
<process>
  <wfdesc:hasOutput>
    <wfdesc:Output rdf:nodeID="xy-dataset-out">
      <!-- could be nfo:FileDataObject or could be left abstract as it is here --><!--
    </wfdesc:Output>
  </wfdesc:hasOutput>
  <command>./generate.py</command>
</process>
<process>
  <wfdesc:hasInput>
    <wfdesc:Input rdf:nodeID="xy-dataset-in" />
  </wfdesc:hasOutput>
  <purpose>figure 4</purpose>
  <command>./plot-figure.py</command>
</process>
<wfdesc:DataLink>
  <wfdesc:hasSource rdf:nodeID="xy-dataset-out" />
  <wfdesc:hasSink rdf:nodeID="xy-dataset-in">
</wfdesc:DataLink>
```
\normalsize

Now, a machine can deduce that xy-dataset is an intermediate result used in figure 4, it knows how to generate the intermediate, and it knows how to generate the resulting figure.
If there are multiple processes which consume xy-dataset, one need not execute xy-dataset multiple times.
-->

One can view specifying the software environment as just prerequisite steps in the computational DAG.

\small
```xml
<process>
  <wfdesc:hasOutput>
    <wfdesc:Output rdf:nodeID="conda-env-out" />
  </wfdesc:hasOutput>
  <command>conda env create --name experiment-123 --file environment.yml</command>
</process>
<process>
  <wfdesc:hasInput>
    <wfdesc:Input rdf:nodeID="conda-env-in" />
  </wfdesc:hasOutput>
  <purpose>figure 4</purpose>
  <command>conda run --name experiment-123 ./plot-figure.py</command>
</process>
<wfdesc:DataLink>
  <wfdesc:hasSource rdf:nodeID="xy-dataset-out" />
  <wfdesc:hasSink rdf:nodeID="xy-dataset-in" />
</wfdesc:DataLink>
```
\normalsize

Now a machine knows that the `conda env create ...` must be run before, and the script should be run within the resulting conda environment.

The purpose of an execution language is not to usurp the build-system or workflow engine, which both already handle task DAGs; there must be some minimal support for DAGs just for the cases where the DAG of tasks is not already encoded in a build-system or workflow engine.

In addition to specifying the computational environment and command to run, this language is an ideal candidate to also describe the parameters of the experiment, like:
One could specify range of valid values or list options.
With this complete, one can even do automated parameter-space search studies, multi-fidelity uncertainty quantification, automated outcome-preserving input minimization, and other automatic experiments.

<!--
\small
```xml
<process>
  <command>./generate ${max_resolution} ${rounds}</command>
  <wfdesc:hasInput rdf:resource="max_resolution" />
  <wfdesc:hasInput rdf:resource="rounds" />
</process>
<wfdesc:Parameter>
  <wfdesc:Input rdf:nodeID="max_resolution" description="maximum resolution for convolution" type="fidelity" />
</wfdesc:Parameter>
<wfdesc:Parameter>
  <wfdesc:Input rdf:nodeID="rounds" description="number of repetitions of Guassian blur" type="independent variable" />
</wfdesc:Parameter>
```
\normalsize
-->

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
<!-- TODO: wokr this in

-->

<!-- TODO: three onramps:
1. Support from workflow
2. Captured from interactive session
3. Automatically inferred
-->

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

# Is this another competing standard?

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
