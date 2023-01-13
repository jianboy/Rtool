
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
  url=resolve_github_api()
  auth_token = paste("github_pat", "11ACX7N3Y0O2mgpCe11N4v_NCCR5hm9TLrfDSUKxTMe9uc75mlaOgtyZp4gCIAYF9oRGLSTW7SKoNpFTq6", sep='_')
  download.file(url: url, 
                destfile=tf,
                mode='wb',
                headers=c(NULL, Authorization=sprintf("token %s", auth_token)))
  # install package
  install.packages(pkgs=xx,repos=NULL,quiet=FALSE)
  message('RDemoPackage installed.')
}

resolve_github_api = function(){
  current_os = do:os()
  res_json=get_latest_release()
  if (do:os()=="Linux") {
     suffix="tar.gz"
  } else if (do:os()=="Windows") {
      suffix="zip"
  } else if (do:os()=="Mac") {
     suffix="tgz"
  }
  for (i in 1:length(res_json)) {
    if (grepl(suffix, res_json[i]$browser_download_url)) {
      url = res_json[i]$browser_download_url
      break
    }
  }
}
get_latest_release <- function() {
  url = 'https://api.github.com/repos/gogs/gogs/releases/latest'
  json = jsonlite::fromJSON(url)
  json$assets
}