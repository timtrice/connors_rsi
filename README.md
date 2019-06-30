
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.6.0-6666ff.svg)](https://cran.r-project.org/)
[![Netlify
Status](https://api.netlify.com/api/v1/badges/b3a76bf0-ec22-487d-b567-7c2ea7ff4812/deploy-status)](https://app.netlify.com/sites/twitterapi/deploys)
![Build
Status](https://img.shields.io/travis/timtrice/connors_rsi/master.svg)
[![Docker Cloud Build
Status](https://img.shields.io/docker/cloud/build/timtrice/distill.svg?style=popout)](https://cloud.docker.com/repository/docker/timtrice/connors_rsi)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/timtrice/connors_rsi/master?filepath=index.Rmd)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

# ConnorsRSI (0.0.0.9000)

## An Analysis of the Connors RSI(2) Trading Strategy

### Prerequisites

| Package     | Version |
| :---------- | :------ |
| desc        | \*      |
| devtools    | \*      |
| distill     | \*      |
| dplyr       | \*      |
| here        | \*      |
| hrbrthemes  | \*      |
| kableExtra  | \*      |
| purrr       | \*      |
| remotes     | \*      |
| rlang       | \*      |
| sessioninfo | \*      |
| styler      | \*      |
| TTR         | \*      |
| tidyquant   | \*      |
| usethis     | \*      |
| workflowr   | \*      |

Version not specified

#### Docker

A Docker image of this project is available for
    use.

  - [timtrice/connors\_rsi](https://cloud.docker.com/repository/docker/timtrice/connors_rsi)

##### Run

Set $LOCAL to your preferred working directory.

    LOCAL="/home/Projects/connors_rsi"
    
    docker run \
      -dti \
      -e DISABLE_AUTH=true \
      -p 8787:8787 \
      --name connors_rsi \
      -v $LOCAL:/home/rstudio/connors_rsi \
      timtrice/connors_rsi:release

##### Shell

    docker exec -ti connors_rsi /bin/bash

### Built With

  - [R 3.6.0](https://www.r-project.org/) - The R Project for
    Statistical Computing

### Contributing

Please read
[CONTRIBUTING.md](https://github.com/timtrice/connors_rsi/blob/master/.github/CONTRIBUTING.md)
for details on our R of conduct, and the process for submitting pull
requests to us.

### Code of Conduct

Please note that the ‘ConnorsRSI’ project is released with a
[Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). By
contributing to this project, you agree to abide by its terms.

### Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions
available, see the [tags on this
repository](https://github.com/timtrice/connors_rsi/tags).

### Authors

  - Trice, Tim (Role(s): aut, cre)

### License

This project is licensed under the MIT License - see the
[LICENSE.md](LICENSE.md) file for details

### Acknowledgements
