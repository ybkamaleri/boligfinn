#===================================================
# Demo multi-function roxygen2 - three ways to do it
#===================================================

# This shows how things do work, including wierd corner cases, not
# how they should be done.  Most of the information comes from
#    http://r-pkgs.had.co.nz/man.html

#====================================================
# Demo multi-function roxygen2 page using @describeIn
#====================================================

#' Group of functions page title
#'
#' Group of functions Description section
#'
#' Group of functions Details paragraph.
#'
#' @section After function section:
#' Despite its location, this actually comes after the function section.
#' @describeIn toBar Description for the base function in the group.
#'
#'    Returns no value. Not indented.
#'
#' @param x a param for toBar and notToBar
#' @param y a param just for notToBar
#' @param z a param just for theQuestions
#' @return Hard to have one return section for all functions, might want to have a manual list here,
#' But if doing a manual list, that kind of avoids the purpose of the Functions section. Probably
#' want to describe in aggregate here and in specific with each function.
toBar <- function (x) { return("barred x") }

#' @section Another section after function section:
#' Probably better if all sections come first, uless have one section per function. Makes it easier to
#' see the information flow.
#' @describeIn toBar Description for another function in the toBar group
notToBar <- function (x,y) { return( "unbarred x with y") }

#' @describeIn toBar
#'
#'    Final function in toBar group. Still on same line with name
#'    even though new paragraph. Indenting does nothing here either.
#' @param z a param just for theQuestion. Could put here, but easiest if all params are
#' described in the same place, with page documentation, so none get repeated.
theQuestion <- function (z) { return("question? z") }

#==========================================================
# Demo multi-function roxygen2 page using @rdname with NULL
#==========================================================

#' Group of functions page title
#'
#' Group of functions Description section
#'
#' Group of functions Details paragraph.
#'
#' @section After Arguments and Value sections:
#' Despite its location, this actually comes after the Arguments and Value sections.
#' Also, don't need to use null, could annotate first function, and then
#' using function name as the groupBy name is more intuitive.
#'
#' @param x a param for toBar and notToBar
#' @param y a param just for notToBar
#' @return Hard to have one return section for all functions,
#' might want to have a manual list here.
#' @name anyNameButFunctionNameIsUnique
NULL

#' @rdname anyNameButFunctionNameIsUnique
alsoToBar <- function (x) { return("barred x") }

#' @section Another section:
#' Probably better if all sections come first, uless have one section per function. Makes it easier to
#' see the information flow.
#' @rdname anyNameButFunctionNameIsUnique
alsoNotToBar <- function (x,y) { return( "unbarred x with y") }

#' @rdname anyNameButFunctionNameIsUnique
#' @param z a param just for theQuestion.
#'
#' Could put here, but easiest if all params are
#' described in the same place, with page documentation, so none get repeated.
alsoTheQuestion <- function (z) { return("question? z") }

#=====================================================================
# Demo multi-function roxygen2 page using @rdname with a base function
#=====================================================================

#' Group of functions page title
#'
#' Group of functions Description section
#'
#' Group of functions Details paragraph.
#'
#' @section After Arguments and Value sections:
#' Despite its location, this actually comes after the Arguments and Value sections.
#' Also, don't need to use null, could annotate first function, and then
#' using function name as the groupBy name is more intuitive.
#'
#' @param x a param for toBar and notToBar
#' @param y a param just for notToBar
#' @return Hard to have one return section for all functions,
#' might want to have a manual list here.
#' @rdname againToBar
againToBar <- function (x) { return("barred x") }

#' @section Another section:
#' Probably better if all sections come first, uless have one section per function. Makes it easier to
#' see the information flow.
#' @rdname againToBar
againNotToBar <- function (x,y) { return( "unbarred x with y") }

#' @rdname againToBar
#' @param z a param just for theQuestion.
#'
#' Could put here, but easiest if all params are
#' described in the same place, with page documentation, so none get repeated.
againTheQuestion <- function (z) { return("question? z") }
