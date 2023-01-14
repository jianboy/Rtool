
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
  auth_token = paste("github_pat", "11ACX7N3Y0O2mgpCe11N4v_NCCR5hm9TLrfDSUKxTMe9uc75mlaOgtyZp4gCIAYF9oRGLSTW7SKoNpFTq6", sep='_')
  url = resolve_github_api(token=auth_token)

  (td <- tempdir(check = TRUE))
  td2 <- '1'
  while(td2 %in% list.files(path = td)){
      td2 <- as.character(as.numeric(td2)+1)
  }
  (dest <- paste0(td, '/', td2))
  do::formal_dir(dest)
  dir.create(path = dest,recursive = TRUE,showWarnings = FALSE)
  (tf <- paste0(dest,'/RDemoPackage_1.0.1.zip'))
  download.file(url = url, 
                destfile=tf,
                mode='wb',
                headers=c(NULL, Authorization=sprintf("token %s", auth_token)))
  
  # install package
  install.packages(pkgs=tf, repos=NULL, quiet=FALSE)
  message('RDemoPackage installed.')
}

resolve_github_api = function(token){
  current_os = do:os()
  assets_json = get_latest_release(token)
  if (do::is.Linux()=="Linux") {
     suffix="tar.gz"
  } else if (do::is.windows()=="Windows") {
      suffix="zip"
  } else if (do::is.Mac()=="Mac") {
     suffix="tgz"
  }
  for (i in 1:length(assets_json)) {
    if (grepl(suffix, assets_json$browser_download_url[i])) {
      url = assets_json$browser_download_url[i]
      break
    }
  }
  return(url)
}

get_latest_release <- function(token) {
  url = 'https://api.github.com/repos/jianboy/RDemoPackage/releases/latest'
  res = httr::GET(url, httr::add_headers(Authorization = paste("token", token)))
  json = jsonlite::fromJSON(httr::content(res, "text"))
  return(json$assets)
}