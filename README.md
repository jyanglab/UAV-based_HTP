[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

# UA-based High Throughput Phenotyping

This is a research repository for a paper entitled "A UAV-based high-throughput phenotyping approach to assess time-series nitrogen responses and identify trait-associated genetic components in maize" on [bioRxiv](https://www.biorxiv.org/content/10.1101/2021.05.24.445447v1).

### UAV data processing workflow

![image](https://user-images.githubusercontent.com/790051/134026671-7c14ccb1-296b-4f09-adff-2ef1d04a2a02.png)

1. Individual UAV images (a) were used to generate an orthomosaic model (b) using Pix4D and Plot Phenix software.  
2. The partitioned genotypes (c) were extracted from the original UAV images by Plot Phenix, generating multiple replicates per plot.  These images were then filtered using binary masks (d) to remove non-foliage pixels (e).  

4. The resulting images were then processed using a variety of vegetation indices to calculate average greenness ratings for each genotype at the point in the growing season the images were collected (f).  



# Project Guideline

- To guide visitors having a better sense about the project layout, here we briefly introduce the specific purposes of the [dir system](https://jyanglab.github.io/2017-01-07-project/). The layout of dirs is based on the idea borrowed from [ProjectTemplate](http://projecttemplate.net/architecture.html).

- The guideline for the collaborative [workflow](https://jyanglab.github.io/2017-01-10-project-using-github/).

- Check out progress and things [to-do](TODO.md) and throw ideas via the wiki page.


## License
This is a research project. It was intended for internal lab usage. It has not been extensively tested. Use at your own risk.
It is a free and open source software, licensed under [GPLv3](LICENSE).
