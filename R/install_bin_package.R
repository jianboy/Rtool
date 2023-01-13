
#' @export install_bin_package
#'
#' @examples install_bin_package()
install_bin_package <- function(){
  # install dep
  packages <- c( "remotes")
  for (i in 1:length(packages)) {
    if (!packages[i] %in% installed.packages()[,"Package"]) {
      install.packages(packages[i], dependencies = TRUE, quiet = TRUE, keep_outputs=TRUE)
    }
  }
  # download bin package
  resolve_github_api()
  auth_token = paste("github_pat", "11ACX7N3Y0O2mgpCe11N4v_NCCR5hm9TLrfDSUKxTMe9uc75mlaOgtyZp4gCIAYF9oRGLSTW7SKoNpFTq6", sep='_')
  download.file(url:'https://githb.com/jianboy/xx/releases/latest/xx.tar.gz', 
                destfile=tf,
                mode='wb',
                headers=c(NULL,Authorization=sprintf("token %s", auth_token)))
  # install package
  install.packages(pkgs=xx,repos=NULL,quiet=FALSE)
  message('RDemoPackage installed.')
}

resolve_github_api = function(json, suffix, ){
  # 'https://api.github.com/repos/jianboy/RDemoPackage/releases/latest' browser_download_url 
  if (do:os()=="Linux") {
     suffix="tar.gz"
  } else {
     suffix=".zip"
  }
  
}