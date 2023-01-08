
#' 按照MendelR包和相关依赖
#'
#' @export install_r_demo_package
#'
#' @examples install_r_demo_package()
install_r_demo_package <- function(){
  packages <- c( "remotes")

  for (i in 1:length(packages)) {
    if (!packages[i] %in% installed.packages()[,"Package"]) {
      install.packages(packages[i], dependencies = TRUE, quiet = TRUE, keep_outputs=TRUE)
    }
  }

  auth_token = paste("github_pat", "11ACX7N3Y0O2mgpCe11N4v_NCCR5hm9TLrfDSUKxTMe9uc75mlaOgtyZp4gCIAYF9oRGLSTW7SKoNpFTq6", sep='_')

  remotes::install_github("jianboy/RDemoPackage",
                           auth_token = auth_token,
                           force = TRUE, upgrade=c("never"))
}
