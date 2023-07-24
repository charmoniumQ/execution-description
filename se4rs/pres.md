---
slideNumber: true
link-citations: true
slide-level: 2
header-includes: |
  <style>
    :root {
      --r-heading1-size: 1.6em;
      --r-heading2-size: 1.4em;
      --r-heading3-size: 1.2em;
      --r-heading4-size: 1em;
    }
    .reveal table {
      border: separate;
    }
    .reveal .slide-number {
      right: 40px;
      bottom: 120px;
      font-size: 16px;
    }
    code {
      font-size: 20pt
    }
  </style>
  <script>
    // The default Pandoc-generated citation links don't work because they link to a different slide.
    document.querySelectorAll(".citation a").forEach(a => {a.href = "#/references";});

    // Set the title without generating a title slide
    window.title = "Wanted: standards for automatic reproducibility of computational experiments";
  </script>
---

# Wanted: standards for automatic reproducibility of computational experiments {style="font-size: 1.2em"}

[Samuel Grayson, Reed Milewicz, Joshua Teves, Daniel S. Katz, Darko Marinov]{style="font-size: 1.0em"}

# Problem: artifact evaluation

::: incremental
- Author has to write plain-English description
- Artifact evaluator (AE) has to spend effort interpreting them
- Author: You didn't follow the instructions exactly!
- AE: You're instructions were ambiguous/unclear.
- Future user: Author and AE got it to work. How exactly?
:::

# Problem: large scale re-execution studies

::: incremental
- Repeatability in Computer Systems by Collberg and Proebsting
  - How many research codes could we still run?
- How do we reproduce the reproduction? [here][1]
- Authors: it would have worked; you just didn't invoke the right commands! (BarowyCB [here][2])
:::

[1]: http://reproducibility.cs.arizona.edu/v2/data/tissec15_DannerDKL12_build.txt
[2]: http://reproducibility.cs.arizona.edu/v2/index.html#BarowyCBM12

# Insights

::: incremental
- Everyone figures out how to reproduce by themselves.
  - Documentation is hard to write
  - Documentation, even if written, can be ambiguous
- Want a *machine-readable* way to *share* reproducibility instructions
  - Authors &rarr; with AE, readers
  - Re-executors &rarr; other re-executors
:::

# Insights

::: incremental
- Instructions to share = retrospective provenance
- Most important is commands/arguments
- Even imperfect data would be better starting point for automatic repair
- This data is _automatically_ collectable
:::

# Benefits to authors

::: incremental
- "Pushbutton" artifact evaluation
- Automatic uncertainty quantification
- Regression tests/CI
:::

# Research opportunities

Makes research software studyable by software engineering researchers

::: incremental
- Reproducibility assessment
- Provenance overhead
- Automatic repair studies
- Performance impact
:::

# Example

```xml
<rdf:RDF>
  <process rdf:about="#make">
    <command>make all</command>
  </process>
  <process rdf:about="#run" depends-on="#make">
    <command>./simulate</command>
    <prov:generated>
      <doco:figure>
        <rdf:Description>
          <dc:title>Figure 2b</dc:title>
          <dc:isPartOf rdf:resource=
            "https://doi.org/10.1234/123456789" />
        </rdf:Description>
      </doco:figure>
    </prov:generated>
  </process>
</rdf:RDF>
```

# Specification requirements

::: incremental
- Not a workflow engine, but can invoke one
- Decentralized dataset
  - Store with code repo or third party repo
  - Can be uploaded by authors, users, or re-executors (not just authors!)
  - Clients search code repo and third party repos
- With enough data, automatically re-executable
- Shell is lingua franca
  - Better semantics if we recognize shell command
:::

# Related ontologies

::: incremental
- wf4ever/wfdesc
- DoCO
- Nanopublications
- DOAP
- Transitive CRediT
:::

# Other data

::: incremental
- The format should support optional data that is more complex to collect
  - Automatic: Files read/written (1-15% overhead)
  - Manual: Input/output types
  - Manual: Classify parameters as {calibration, fidelity, random seed}
  - Manual: Link to publication
:::

# Why not ___?

::: incremental
- Workflow engine
- Docker/Nix/Guix
- Makefile
:::

# Wanted: A community effort

::: incremental
- Interested stakeholders
  - Computational scientists
  - Research software engineers/researchers
  - Provenance researchers
- Exemplars
- <https://github.com/charmoniumQ/execution-description>
:::

# Feedback/change

- introduce provenance earlier
- Capture install commands or not?
- Justify why not use make
- Title slide should be picture
- Change title of "Specification"
- Shell command in linked data
- Check https://se4science.org/workshops/se4rs23/index.htm
