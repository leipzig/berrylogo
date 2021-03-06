library(berrylogo)

context("plot creation")

freqs<-matrix(data=c(0.25,0.65,0.87,0.92,0.16,0.16,0.04,0.98,0.98,1.00,0.02,0.10,0.10,0.80,0.98,0.91,0.07,0.07,
                     0.11,0.05,0.04,0.00,0.26,0.17,0.00,0.01,0.00,0.00,0.29,0.17,0.01,0.03,0.00,0.00,0.32,0.32,
                     0.53,0.26,0.07,0.02,0.53,0.18,0.96,0.01,0.00,0.00,0.65,0.01,0.89,0.17,0.01,0.09,0.59,0.12,
                     0.11,0.04,0.02,0.06,0.05,0.49,0.00,0.00,0.02,0.00,0.04,0.72,0.00,0.00,0.01,0.00,0.02,0.49),
              byrow=TRUE,nrow=4,dimnames=list(c('A','C','G','T')))

p<-berrylogo(freqs,gc_content=.41)

test_that("mappings",{
  expect_equal(as.character(p$mapping$label), "nt")
  expect_equal(as.character(p$mapping$x), "pos")
  expect_equal(as.character(p$mapping$y), "value")
})

test_that("Scale range is NULL",{
  expect_null(p$scales$scales[[1]]$range$range)
})
