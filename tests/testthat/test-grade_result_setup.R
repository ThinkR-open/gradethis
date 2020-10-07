test_that("grader setup works", {
  library(dplyr)
  library(purrr)
  
  set.seed(2020)
  good <- grade_result(
    setup = {
      library(dplyr)
      .solution <- iris %>% filter(Species == "setosa")
      .common_error <- iris %>% filter(Species == "virginica")
      .max <- max(iris$Sepal.Length)
    },
    fail_if(~ nrow(.result) != nrow(.solution), "custom message 1"),
    fail_if(~ ncol(.result) != ncol(.solution), "custom message 2"),
    fail_if(~ any(names(.result) != names(.solution)), "custom message 3"),
    fail_if(~ identical(.result, .common_error), "You filtered the wrong group"),
    fail_if(~ .max == 1.3, "custom message 4"),
    grader_args = list(),
    learnr_args = list(last_value = iris %>% filter(Species == "setosa"), envir_prep = new.env())
  )
  
  expect_equal(good$message,"That's glorious!  ")
  expect_true(good$correct)
  


  set.seed(2020)
  output <-   list(
    iris %>% filter(Species == "setosa"),
    iris %>% filter(Species == "virginica"),
    iris %>% select(Species),
    iris[1:50,],
    iris %>% filter(Species == "setosa") %>% setNames(letters[1:5])

  ) %>% map(
    ~grade_result(
      setup = {
        library(dplyr)
        .solution <- iris %>% filter(Species == "setosa")
        .common_error <- iris %>% filter(Species == "virginica")
        .max <- iris$Sepal.Length %>% max()
      },
      fail_if(~ ncol(.result) != ncol(.solution), "custom message 2"),
      fail_if(~ nrow(.result) != nrow(.solution), "custom message 1"),
      fail_if(~ any(names(.result) != names(.solution)), "custom message 3"),
      fail_if(~ identical(.result, .common_error), "You filtered the wrong group"),
      fail_if(~ .max == 1.3, "custom message 4"),
      grader_args = list(),
      learnr_args = list(last_value = .x, envir_prep = new.env())
    )

  )


  expect_equal(output %>% map_chr("message"), c("That's glorious!  ", "You filtered the wrong group  Try it again. I have a good feeling about this.",
                                                "custom message 2  But no need to fret, try it again.", "Superb work!  ",
                                                "custom message 3  Please try again."))



  expect_true(output %>% map_lgl(inherits,what = "grader_graded") %>% all())
  })
