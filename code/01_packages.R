install.packages("remotes")

# Install Imports. Imports are R packages that are required to run scripts
# within the code directory, but not the analysis Rmds.
install.packages(remotes::local_package_deps(dependencies = "Imports"))

# Install Suggests packages. Suggests are those packages used to run
# analysis Rmds.
install.packages(remotes::local_package_deps(dependencies = "Suggests"))

# Get Remotes
remotes <- remotes::local_package_deps(dependencies = "Remotes")

if (!is.null(remotes)) {
  purrr::walk(
    .x = strsplit(
      x = remotes::local_package_deps(dependencies = "Remotes"),
      split = "::"
    ),
    .f = ~rlang::exec(
      .fn = utils::getFromNamespace(x = paste0("install_", .x[1]), ns = "remotes"),
      repo = .x[2],
      upgrade = "never"
    )
  )
}
