test_that("merge_environments works", {
  merge_environments <- gradethis:::merge_environments
  e1 <- new.env()
  e2 <- new.env()

  e1$a <- "a from e1"
  e2$a <- "a from e2"
  e2$.a <- "a maskey"
  e2$b <- "b from e2"
  e2$.b <- "b maskey"

  new <- merge_environments(e1 = e1, e2 = e2)


  expect_is(new, "environment")
  expect_equal(merge_environments(e1, e2)$a , "a from e2")
  expect_equal(merge_environments(e2, e1)$a , "a from e1")
  expect_equal(names(merge_environments(e2, e1)) , c(".b", ".a", "b", "a"))
})
