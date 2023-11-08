[![GloBI Review by Elton](../../actions/workflows/review.yml/badge.svg)](../../actions/workflows/review.yml) [![GloBI](https://api.globalbioticinteractions.org/interaction.svg?accordingTo=globi:globalbioticinteractions/osal-ar&refutes=true&refutes=false)](https://globalbioticinteractions.org/?accordingTo=globi:globalbioticinteractions/osal-ar) [![SWH](https://archive.softwareheritage.org/badge/swh:1:dir:c661978af87996301e495a9d5e25daa46c4000ee/)](https://archive.softwareheritage.org/swh:1:dir:c661978af87996301e495a9d5e25daa46c4000ee;origin=https://github.com/globalbioticinteractions/osal-ar;visit=swh:1:snp:1d39f1f93a829fc8903abae5a77198b2eabd3884;anchor=swh:1:rev:766c1a177de7b85a9422e20c7cc9f074da35bf96)

Configuration to help Global Biotic Interactions (GloBI, https://globalbioticinteractions.org) index: 

Klompen H, Johnson N (2018). Ohio State Acarology Laboratory (OSAL), Ohio State University. Museum of Biological Diversity, The Ohio State University. Accessed via https://mbd-db.osu.edu/hol/taxon_name/05fbf4bb-f8e1-404e-a27c-759d345aa4d0 on 2023-11-06 hash://sha256/fb23140e60f4889de35ae174b2570cf294012bff4f2c8c419c292af51c98c25f .

## Methods

At time of writing, 2023-11-07, the Ohio State Acarology Laboratory (OSAL) was no longer available via their original location at http://xbiod.osu.edu/ipt/archive.do?r=osal . In tracing the provenance of this web location, no activity after 2018 was detected. However, the site at https://mbd-db.osu.edu/hol/taxon_name/05fbf4bb-f8e1-404e-a27c-759d345aa4d0 did appear to be active. 

With no re-usable dataset available, a signed data package for OSAL was created using a hybrid approach of tracking structured data via the Museum of Biological Diversity Database API (e.g., [https://mbd-db.osu.edu/api/v1/backend_table/hol/taxon_name/collecting_units/records?taxon_name_id=05fbf4bb-f8e1-404e-a27c-759d345aa4d0&page=2826](data/9f/7d/9f7d85aa80aee850136c13b866118c284ce7b6e734e637d1ccef01f20b591c5a)),  as well as scraping semi-structured OSAL html pages (e.g., [https://mbd-db.osu.edu/hol/collecting_units/0eae5d0a-7cff-3aaa-e053-0100007f2cc9](data/87/e8/87e8a60fd72b9d1aa0823dc58194ef45c94fcb25c5d1e0c30fd743853d42844d)).


A data package was created using Preston[1,2,3] via the [track.sh](track.sh) bash script. The resulting package has signature hash://sha256/fb23140e60f4889de35ae174b2570cf294012bff4f2c8c419c292af51c98c25f and associated provenance and content was stored in the [data/](data/) folder.

Following, the signed OSAL data package was used to compile a table [specimen-associations.tsv](specimen-associations.tsv) via [make.sh](make.sh).



The index of the OSAL data package can be listed using the following bash command - 

```bash
preston ls\
 --anchor hash://sha256/fb23140e60f4889de35ae174b2570cf294012bff4f2c8c419c292af51c98c25f\
 --remote https://linker.bio,https://softwareheritage.org
```

## References

[1] Elliott M.J., Poelen J.H., Fortes J.A.B. (2020). Toward Reliable Biodiversity Dataset References. Ecological Informatics. https://doi.org/10.1016/j.ecoinf.2020.101132 hash://sha256/136c3c1808bcf463bb04b11622bb2e7b5fba28f5be1fc258c5ea55b3b84f482c

[2] Elliott M.J., Poelen, J.H. & Fortes, J.A.B. (2023) Signing data citations enables data verification and citation persistence. Sci Data. https://doi.org/10.1038/s41597-023-02230-y hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d

[3] Michael Elliott, Jorrit Poelen, Icaro Alzuru, Emilio Berti, & partha04patel. (2023). bio-guoda/preston: 0.7.6 (0.7.6). Zenodo. https://doi.org/10.5281/zenodo.10027474
