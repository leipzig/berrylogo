# berrylogo: a better sequence logo

[![Build Status](https://travis-ci.org/leipzig/berrylogo.svg?branch=master)](https://travis-ci.org/leipzig/berrylogo)

## Description

A berrylogo is a sequence logo alternative developed by [Charles C.
Berry](http://profiles.ucsd.edu/charles.berry) for "Selection of
Target Sites for Mobile DNA Integration in the Human Genome"
[[http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1664696](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1664696)](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1664696/)

Instead of “information content”, the y-axis is the log relative
frequency with respect to the background frequency, generated here from
the gc\_content parameter.

## Usage
    devtools::install_github("leipzig/berrylogo")
    library("berrylogo")
    freqs<-matrix(data=c(0.25,0.65,0.87,0.92,0.16,0.16,0.04,0.98,0.98,1.00,0.02,0.10,0.10,0.80,0.98,0.91,0.07,0.07,
                 0.11,0.05,0.04,0.00,0.26,0.17,0.00,0.01,0.00,0.00,0.29,0.17,0.01,0.03,0.00,0.00,0.32,0.32,
                 0.53,0.26,0.07,0.02,0.53,0.18,0.96,0.01,0.00,0.00,0.65,0.01,0.89,0.17,0.01,0.09,0.59,0.12,
                 0.11,0.04,0.02,0.06,0.05,0.49,0.00,0.00,0.02,0.00,0.04,0.72,0.00,0.00,0.01,0.00,0.02,0.49),
                 byrow=TRUE,nrow=4,dimnames=list(c('A','C','G','T')))
    p<-berrylogo(freqs,gc_content=.41)
    print(p)

## Output

![berrylogo](https://lh3.googleusercontent.com/V1olf3ftPS3kQhuMekofZofGP6TdnetAG9e-NfXusQtrjxe7ELd1wU63JBX748-5KXJegzFq8eSkd2-DtN87ysAN_Y3WafyE00UA4NAYrSB2cZBNB3LW_r3y-jWV1J9vzkNqh-hfHDlolawE2J1vAGRAj_zKIbDe4ViSOzzmtCuo9va44Jg8DwhglCVXlCaIUA9BS7-xp8XxrWwQ6HQeyyJoRJM46zKSeTbEeZNooOFxuYiVWOkdmyu8ZEiRK_ym1P5zTP0W3d-i7MInt6MZGQGurL7vTAJ1cTn1N-tHg3TCAngSfaCaAZoxPcVaiD-9uErYq6nyc4C_wxPbnEM6584qS-H6uFd6ZCXZD7v3GCyMeLpxBu3LkPPbjzkz2j9WwXPhvY5Vg85mVRG3FfF51v4GFltKKVmIMPeuzELhbpR18ORrm6GkNZVej9ClBc6Eou5wYYPCc6cx4Y5sLWRMz3m62em-QT2YdwCy_zwdmZIDwtd9a0oC7kaOPrp41YDVDD7eP8_rVO57kviYLiR5zFJ9suAYFeNYTRje7Ei2_5TlT7rbKcR92s0uGqUbZfQvfUh5iB5XxrW3zoRL8xMmV1x0B2zV-vwPRPITl4tsWvyihpjsK-8ZK4Yn1vnCFlFegoqua1fpJY9UJTe_KN_FfQkrP7jZJ3GO=w878-h699-no)
