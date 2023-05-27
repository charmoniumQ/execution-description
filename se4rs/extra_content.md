# Existing standards for execution descriptions of computational experiments

Of course, there are some existing standards and conventions that are used to describe how to run a computational experiment.

- **Build systems**:
  While "building" may refer strictly to compiling and linking, many build systems are general enough to be repurposed for describing how to execute a computational experiment.
  E.g., computational experiments might use GNU Make.
  However, build systems do not fully describe the computational environment (e.g., one might have to install system libraries before running `make`).
  There is only a loose convention over how to name the targets (e.g., should one run `make all`, `make`, or `make figure_1.png` to run the computational experiment from scratch?).
  <!-- TODO: There are a lot of e.g.s-->

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
  <!-- TODO: define a DAG -->
  A workflow script describes a DAG of tasks for a computational experiment.
  The tasks can be native or containerized.
  In practice, workflow scripts may not contain the inputs needed to run the experiment.
    - Case in point, a recent sample of containerized Snakemake workflows showed that these workflows often do not specify example inputs (cite: unpublished work, in submission to ACM REP '23).
     Even though Snakemake has a standard (<https://snakemake.github.io/snakemake-workflow-catalog/?rules=true>) for specifying the usage of its workflows, this standard does not have a place to put example data or an example invocation (<https://github.com/snakemake-workflows/dna-seq-varlociraptor/pull/204#issuecomment-1432876029>).

A Dockerfile is a combination of the above: a software environment definition composed with an optional main script (in the `CMD`).
Sometimes additional context is needed to build the container (e.g., the files referenceed in `ADD` or `COPY` commands may themselves need to be built).
While multi-stage containers mitigate this problem, in practice <!-- Cite Henkel --> most Dockerfiles cannot be automatically built.
Even if they can be built, the `CMD` might require input data or additional arguments, and there is no convention or standard of listing an "example invocation" in a machine-readable way.

## Linked data

This language could be implemented as a vocabulary for linked data in the semantic web.
Linked data is preferrable for these reasons:

1. Linked data is open to extensions.
2. It is possible to link to other resources in linked data.
3. There is already a rich set of ontologies for describing digital and physical resources (RO-crate, wf4prov, software project description, scientific hypotheses, CiTO) in linked data.
4. There is already a rich ecosystem for authoring ontologies and validating documents within those ontologies.

Using linked data to describing scientific workflows has already been suggested by Garijo and Gil in OPMW [@garijo_new_2011], Soiland-Reyes et al. in RO-Crate [@soiland-reyes_packaging_2022], and Gray et al. in Bioschemas [@gray_bioschemas_2017], which indicates confidence in its flexibility and long-term support.
It is a natural extension to use linked data to specify metadata about the experiment in this language.

...

The execution description is linked data, so it can live anywhere, and existing strategies for finding, filtering, and trusting linked data sets would work for execution descriptions.

...

This is the dream of linked data: machine-readable data by different authors hosted in different locations linking together seamlessly.
Even if the publisher does not have an RDF+XML description, third parties can make claims about "https://doi.org/10.1234/123456789", although those claims would not be as easily discoverable.
The purpose description can be even more granular, using the DoCO vocabulary \cite{constantin_document_2016}, which describes documents, as shown in the block labeled `fig-pub`.

# Retrospective provenance

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
